import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/notifications/data/datasource/notification_remote_data_source.dart';
import 'package:gaia/features/notifications/data/notification_repository_impl.dart';
import 'package:gaia/features/notifications/domain/notification_repository.dart';
import 'package:gaia/features/notifications/domain/usecase/get_notification_usecase.dart';
import 'package:gaia/features/notifications/domain/usecase/read_notification_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(Ref ref) {
  return NotificationRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    ref.watch(notificationRemoteDataSourceProvider),
  );
}

@riverpod
GetNotificationUsecase getNotificationUsecase(Ref ref) {
  return GetNotificationUsecase(
    ref.watch(notificationRepositoryProvider),
  );
}

@riverpod
ReadNotificationUsecase readNotificationUsecase(Ref ref) {
  return ReadNotificationUsecase(
    ref.watch(notificationRepositoryProvider),
  );
}

