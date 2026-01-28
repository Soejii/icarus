import 'package:gaia/shared/core/infrastructure/network/config_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'brand_palette.dart';

part 'brand_providers.g.dart';

@riverpod
BrandPalette brandPalette(Ref ref) {
  final cfg = ref.watch(appConfigProvider);
  // big todo for color
  // return cfg.colors.isEmpty ? BrandPalette.defaults() : BrandPalette.fromConfig(cfg.colors);
  return BrandPalette.defaults();
}
