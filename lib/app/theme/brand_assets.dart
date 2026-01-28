// lib/theme/brand_assets.dart
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_spec.dart';
import 'package:icarus/shared/core/infrastructure/network/config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:icarus/app/environment/build_environment.dart';

part 'brand_assets.g.dart';

class BrandAssets {
  BrandAssets(this.client, this.brandSpec);
  final String client;
  final BrandSpec brandSpec;

  String get _base => 'assets/clients/$client';

  // Brand-specific (preferred)
  String logo() => '$_base/images/img_logo.png';
  String logoName() => '$_base/images/img_logo_name.png';

  // Brand-aware helpers (icons/images inside client folder)
  String icon(String name) => '$_base/icons/$name';
  String image(String name) => '$_base/images/$name';

  // Optional: fallback to default if missing (async)
  Future<String> imageWithFallback(String name) async {
    final clientPath = image(name);
    try {
      await rootBundle.load(clientPath);
      return clientPath;
    } catch (_) {
      return 'assets/images/$name';
    }
  }
}

@riverpod
BrandAssets brandAssets(Ref ref) {
  final cfg = ref.watch(appConfigProvider);
  const client =
      BuildEnv.client; 
  return BrandAssets(
    client,
    cfg.brandSpec
  );
}
