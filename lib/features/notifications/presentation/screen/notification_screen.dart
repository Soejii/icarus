import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icarus/features/notifications/presentation/providers/notification_controller.dart';
import 'package:icarus/features/notifications/presentation/widgets/notification_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotification = ref.watch(notificationControllerProvider);
    final provider = ref.watch(notificationControllerProvider.notifier);

    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.loadMore();
        }
      }

      scrollController.addListener(
        () => onScroll(),
      );
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Notifikasi',
        leadingIcon: true,
      ),
      // body: asyncNotification.when(
      //   data: (data) {
      //     if (data.items.isNotEmpty) {
      //       return RefreshIndicator(
      //         onRefresh: () =>
      //             ref.read(notificationControllerProvider.notifier).refresh(),
      //         child: ListView.builder(
      //           controller: scrollController,
      //           itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
      //           itemBuilder: (context, i) {
      //             if (i >= data.items.length) {
      //               return const Padding(
      //                 padding: EdgeInsets.all(16),
      //                 child: Center(child: CircularProgressIndicator()),
      //               );
      //             }
      //             final item = data.items[i];
      //             return NotificationCard(entity: item);
      //           },
      //         ),
      //       );
      //     } else {
      //       return const DataNotFoundScreen(dataType: 'Notifikasi');
      //     }
      //   },
      //   error: (error, stackTrace) => BufferErrorView(
      //     error: error,
      //     stackTrace: stackTrace,
      //     onRetry: () => ref.invalidate(notificationControllerProvider),
      //   ),
      //   loading: () => const Center(child: CircularProgressIndicator()),
      // ),
    );
  }
}
