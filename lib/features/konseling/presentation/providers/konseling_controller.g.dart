// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'konseling_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$konselingTabIndexHash() => r'ebb1f800cee3aefc571b6ba676bf599e05c457f2';

/// See also [KonselingTabIndex].
@ProviderFor(KonselingTabIndex)
final konselingTabIndexProvider =
    AutoDisposeNotifierProvider<KonselingTabIndex, int>.internal(
  KonselingTabIndex.new,
  name: r'konselingTabIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$konselingTabIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$KonselingTabIndex = AutoDisposeNotifier<int>;
String _$konselingControllerHash() =>
    r'8315e3815f82f1f4df857b331f54891183bee735';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$KonselingController
    extends BuildlessAutoDisposeNotifier<AsyncValue<Paged<KonselingEntity>>> {
  late final KonselingType type;

  AsyncValue<Paged<KonselingEntity>> build(
    KonselingType type,
  );
}

/// See also [KonselingController].
@ProviderFor(KonselingController)
const konselingControllerProvider = KonselingControllerFamily();

/// See also [KonselingController].
class KonselingControllerFamily
    extends Family<AsyncValue<Paged<KonselingEntity>>> {
  /// See also [KonselingController].
  const KonselingControllerFamily();

  /// See also [KonselingController].
  KonselingControllerProvider call(
    KonselingType type,
  ) {
    return KonselingControllerProvider(
      type,
    );
  }

  @override
  KonselingControllerProvider getProviderOverride(
    covariant KonselingControllerProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'konselingControllerProvider';
}

/// See also [KonselingController].
class KonselingControllerProvider extends AutoDisposeNotifierProviderImpl<
    KonselingController, AsyncValue<Paged<KonselingEntity>>> {
  /// See also [KonselingController].
  KonselingControllerProvider(
    KonselingType type,
  ) : this._internal(
          () => KonselingController()..type = type,
          from: konselingControllerProvider,
          name: r'konselingControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$konselingControllerHash,
          dependencies: KonselingControllerFamily._dependencies,
          allTransitiveDependencies:
              KonselingControllerFamily._allTransitiveDependencies,
          type: type,
        );

  KonselingControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final KonselingType type;

  @override
  AsyncValue<Paged<KonselingEntity>> runNotifierBuild(
    covariant KonselingController notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(KonselingController Function() create) {
    return ProviderOverride(
      origin: this,
      override: KonselingControllerProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<KonselingController,
      AsyncValue<Paged<KonselingEntity>>> createElement() {
    return _KonselingControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is KonselingControllerProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KonselingControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<Paged<KonselingEntity>>> {
  /// The parameter `type` of this provider.
  KonselingType get type;
}

class _KonselingControllerProviderElement
    extends AutoDisposeNotifierProviderElement<KonselingController,
        AsyncValue<Paged<KonselingEntity>>> with KonselingControllerRef {
  _KonselingControllerProviderElement(super.provider);

  @override
  KonselingType get type => (origin as KonselingControllerProvider).type;
}

String _$detailKonselingControllerHash() =>
    r'130ab6c4e4d3ddfd35d06e83e2e31901f5d1c4d0';

abstract class _$DetailKonselingController
    extends BuildlessAutoDisposeAsyncNotifier<KonselingEntity> {
  late final KonselingType type;
  late final int id;

  FutureOr<KonselingEntity> build(
    KonselingType type,
    int id,
  );
}

/// See also [DetailKonselingController].
@ProviderFor(DetailKonselingController)
const detailKonselingControllerProvider = DetailKonselingControllerFamily();

/// See also [DetailKonselingController].
class DetailKonselingControllerFamily
    extends Family<AsyncValue<KonselingEntity>> {
  /// See also [DetailKonselingController].
  const DetailKonselingControllerFamily();

  /// See also [DetailKonselingController].
  DetailKonselingControllerProvider call(
    KonselingType type,
    int id,
  ) {
    return DetailKonselingControllerProvider(
      type,
      id,
    );
  }

  @override
  DetailKonselingControllerProvider getProviderOverride(
    covariant DetailKonselingControllerProvider provider,
  ) {
    return call(
      provider.type,
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailKonselingControllerProvider';
}

/// See also [DetailKonselingController].
class DetailKonselingControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailKonselingController,
        KonselingEntity> {
  /// See also [DetailKonselingController].
  DetailKonselingControllerProvider(
    KonselingType type,
    int id,
  ) : this._internal(
          () => DetailKonselingController()
            ..type = type
            ..id = id,
          from: detailKonselingControllerProvider,
          name: r'detailKonselingControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailKonselingControllerHash,
          dependencies: DetailKonselingControllerFamily._dependencies,
          allTransitiveDependencies:
              DetailKonselingControllerFamily._allTransitiveDependencies,
          type: type,
          id: id,
        );

  DetailKonselingControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.id,
  }) : super.internal();

  final KonselingType type;
  final int id;

  @override
  FutureOr<KonselingEntity> runNotifierBuild(
    covariant DetailKonselingController notifier,
  ) {
    return notifier.build(
      type,
      id,
    );
  }

  @override
  Override overrideWith(DetailKonselingController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailKonselingControllerProvider._internal(
        () => create()
          ..type = type
          ..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailKonselingController,
      KonselingEntity> createElement() {
    return _DetailKonselingControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailKonselingControllerProvider &&
        other.type == type &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailKonselingControllerRef
    on AutoDisposeAsyncNotifierProviderRef<KonselingEntity> {
  /// The parameter `type` of this provider.
  KonselingType get type;

  /// The parameter `id` of this provider.
  int get id;
}

class _DetailKonselingControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailKonselingController,
        KonselingEntity> with DetailKonselingControllerRef {
  _DetailKonselingControllerProviderElement(super.provider);

  @override
  KonselingType get type => (origin as DetailKonselingControllerProvider).type;
  @override
  int get id => (origin as DetailKonselingControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
