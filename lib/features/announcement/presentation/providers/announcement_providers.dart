import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/announcement/data/announcement_repository_impl.dart';
import 'package:gaia/features/announcement/data/datasource/announcement_remote_data_source.dart';
import 'package:gaia/features/announcement/domain/announcement_repository.dart';
import 'package:gaia/features/announcement/domain/usecase/get_detail_announcement_usecase.dart';
import 'package:gaia/features/announcement/domain/usecase/get_list_announcement_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_providers.g.dart';

@riverpod
AnnouncementRemoteDataSource announcementRemoteDataSource(Ref ref) {
  return AnnouncementRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
AnnouncementRepository announcementRepository(Ref ref) {
  return AnnouncementRepositoryImpl(
    ref.watch(
      announcementRemoteDataSourceProvider,
    ),
  );
}

@riverpod
GetListAnnouncementUsecase getListAnnouncementUsecase(Ref ref) {
  return GetListAnnouncementUsecase(
    ref.watch(
      announcementRepositoryProvider,
    ),
  );
}

@riverpod
GetDetailAnnouncementUsecase getDetailAnnouncementUsecase(Ref ref) {
  return GetDetailAnnouncementUsecase(
    ref.watch(announcementRepositoryProvider),
  );
}
