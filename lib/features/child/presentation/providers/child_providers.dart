import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/child/data/child_repository_impl.dart';
import 'package:icarus/features/child/data/datasource/child_remote_datasource.dart';
import 'package:icarus/features/child/domain/child_repository.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/features/child/domain/usecase/get_children_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'child_providers.g.dart';

@riverpod
ChildRemoteDataSource childRemoteDataSource(Ref ref) =>
    ChildRemoteDataSource(ref.watch(dioProvider));

@riverpod
ChildRepository childRepository(Ref ref) =>
    ChildRepositoryImpl(ref.watch(childRemoteDataSourceProvider));

@riverpod
GetChildrenUsecase getChildrenUsecase(Ref ref) =>
    GetChildrenUsecase(ref.watch(childRepositoryProvider));

@Riverpod(keepAlive: true)
class ChildListController extends _$ChildListController {
  @override
  Future<List<ChildEntity>> build() async {
    final usecase = ref.read(getChildrenUsecaseProvider);
    final result = await usecase.call();
    return result.fold((f) => throw f, (list) => list);
  }
}

/// Tracks which child is currently selected. Persists across navigation (keepAlive).
@Riverpod(keepAlive: true)
class SelectedChild extends _$SelectedChild {
  @override
  ChildEntity? build() => null;

  void select(ChildEntity child) => state = child;
}
