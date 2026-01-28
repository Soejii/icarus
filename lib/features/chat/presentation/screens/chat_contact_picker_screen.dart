import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaia/features/chat/domain/type/chat_role_type.dart';
import 'package:gaia/features/chat/presentation/providers/contact_controller.dart';
import 'package:gaia/features/chat/presentation/widgets/chat_contact_list_item.dart';
import 'package:gaia/features/chat/presentation/widgets/chat_contact_tab_bar.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';

class ChatContactPickerScreen extends HookConsumerWidget {
  const ChatContactPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final selectedRole = useState<ChatRole>(ChatRole.student);
  final contactAsync = ref.watch(contactControllerProvider(selectedRole.value.name));
  final controller = ref.read(contactControllerProvider(selectedRole.value.name).notifier);
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.extentAfter < 200) {
          final currentData = ref.read(contactControllerProvider(selectedRole.value.name)).asData?.value;
          if (currentData != null && currentData.hasMore && !currentData.isMoreLoading) {
            controller.loadMore(selectedRole.value.name);
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, selectedRole.value]);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Pilih Kontak",
        leadingIcon: true,
      ),
      body: Column(
        children: [
          ChatContactTabBar(
            selectedRole: selectedRole.value,
            onRoleChanged: (role) {
              selectedRole.value = role;
            },
          ),
          Expanded(
            child: contactAsync.when(
              data: (pagedContacts) {
                final contacts = pagedContacts.items;

                if (contacts.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => controller.refresh(selectedRole.value.name),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: contacts.length + (pagedContacts.hasMore ? 1 : 0),
                      separatorBuilder: (context, index) {
                        if (index >= contacts.length) return const SizedBox.shrink();
                        return Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          height: 1,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (index >= contacts.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final contact = contacts[index];
                        return ChatContactListItem(
                          contact: contact,
                          onTap: () {
                            context.goNamed(
                              RouteName.chatDetail,
                              pathParameters: {'userId': contact.id.toString()},
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () => ref.refresh(contactControllerProvider(selectedRole.value.name)),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}