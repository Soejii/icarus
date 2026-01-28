import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/chat/presentation/providers/chat_controller.dart';
import 'package:gaia/features/chat/presentation/widgets/chat_list_item.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Chat",
        leadingIcon: false,
      ),
      body: chatAsync.when(
        data: (pagedChats) {
          if (pagedChats.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsHelper.imgChatNotFound,
                    width: 200.w,
                    height: 200.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Belum ada chat',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.inactive,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refresh(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  itemCount:
                      pagedChats.items.length + (pagedChats.hasMore ? 1 : 0),
                  separatorBuilder: (context, index) {
                    if (index >= pagedChats.items.length) {
                      return const SizedBox.shrink();
                    }
                    return Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    if (index >= pagedChats.items.length) {
                      return pagedChats.isMoreLoading == true
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }

                    final chat = pagedChats.items[index];
                    return ChatListItem(chat: chat);
                  },
                ),
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
                onPressed: () => ref.refresh(chatControllerProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteName.contactPicker);
        },
        backgroundColor: context.brand.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
