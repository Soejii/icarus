import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/chat/presentation/providers/chat_detail_controller.dart';
import 'package:icarus/features/chat/presentation/widgets/chat_message_list_widget.dart';
import 'package:icarus/features/chat/presentation/widgets/chat_message_input_widget.dart';
import 'package:icarus/features/chat/presentation/widgets/chat_detail_app_bar_widget.dart';

class ChatDetailScreen extends HookConsumerWidget {
  final int userId;

  const ChatDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatDetailAsync = ref.watch(chatDetailEntityProvider(userId));
    final messagesAsync = ref.watch(chatDetailControllerProvider(userId));
    final controller = ref.read(chatDetailControllerProvider(userId).notifier);

    final scrollController = useScrollController();
    final textController = useTextEditingController();
    final focusNode = useFocusNode();

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;
        final position = scrollController.position;
        final data = ref.read(chatDetailControllerProvider(userId)).value;

        if (data?.hasMore == true &&
            position.pixels >= position.maxScrollExtent - 200 &&
            !controller.isLoadingMore) {
          controller.loadMore();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, userId]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: chatDetailAsync.when(
        data: (data) => ChatDetailAppBarWidget(contact: data.contact),
        loading: () => const ChatDetailAppBarWidget(),
        error: (_, __) => const ChatDetailAppBarWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (data) {
                if (data.items.isEmpty) {
                  return const Center(child: Text('Belum ada pesan'));
                }
                return ChatMessageListWidget(
                  messages: data.items,
                  scrollController: scrollController,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ChatMessageInputWidget(
            textController: textController,
            focusNode: focusNode,
            onSend: () => _sendMessage(
              textController, 
              scrollController, 
              ref, 
              context
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(
    TextEditingController textController,
    ScrollController scrollController,
    WidgetRef ref,
    BuildContext context,
  ) async {
    final message = textController.text.trim();
    if (message.isEmpty) return;

    final controller = ref.read(chatDetailControllerProvider(userId).notifier);

    controller.addOptimisticMessage(message);
    textController.clear();

    try {
      await controller.sendMessage(message);
    } catch (error) {
      controller.removeOptimisticMessage(message);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim pesan: $error'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                controller.addOptimisticMessage(message);
                controller.sendMessage(message);
              },
            ),
          ),
        );
      }
    }
  }
}