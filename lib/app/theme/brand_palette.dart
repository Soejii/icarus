import 'package:flutter/material.dart';

@immutable
class BrandPalette extends ThemeExtension<BrandPalette> {
  final Color primary;
  final Color secondary;
  final Color inactive;
  final Color textMain;
  final Color textSecondary;
  final Color success;
  final Color green;
  final LinearGradient mainGradient;
  final List<BoxShadow> shadow;
  final List<BoxShadow> invertedShadow;

  const BrandPalette({
    required this.primary,
    required this.secondary,
    required this.inactive,
    required this.textMain,
    required this.textSecondary,
    required this.success,
    required this.green,
    required this.mainGradient,
    required this.shadow,
    required this.invertedShadow,
  });

  // Your current AppColors as defaults
  factory BrandPalette.defaults() => const BrandPalette(
        primary: Color.fromRGBO(0, 154, 222, 1),
        secondary: Color.fromRGBO(0, 117, 176, 1),
        inactive: Color.fromRGBO(133, 139, 166, 1),
        textMain: Color.fromRGBO(4, 23, 53, 1),
        textSecondary: Color.fromRGBO(82, 103, 137, 1),
        success: Color.fromRGBO(90, 175, 85, 1),
        green: Color.fromRGBO(90, 175, 85, 1),
        mainGradient: LinearGradient(
          colors: [
            Color.fromRGBO(28, 178, 255, 1),
            Color.fromRGBO(90, 199, 255, 1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        shadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        invertedShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, -4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      );

  // Build from JSON overrides (missing keys fall back to defaults)
  factory BrandPalette.fromConfig(Map<String, dynamic> colors) {
    final d = BrandPalette.defaults();

    Color _hex(String? v, Color fb) {
      if (v == null || v.isEmpty) return fb;
      var hex = v.replaceAll('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    }

    final left =
        _hex(colors['gradientLeft'] as String?, d.mainGradient.colors.first);
    final right =
        _hex(colors['gradientRight'] as String?, d.mainGradient.colors.last);
    final shadowOpacity = (colors['shadowOpacity'] as num?)?.toDouble() ?? 0.25;

    return BrandPalette(
      primary: _hex(colors['primary'] as String?, d.primary),
      secondary: _hex(colors['secondary'] as String?, d.secondary),
      inactive: _hex(colors['inactive'] as String?, d.inactive),
      textMain: _hex(colors['textMain'] as String?, d.textMain),
      textSecondary: _hex(colors['textSecondary'] as String?, d.textSecondary),
      success: _hex(colors['success'] as String?, d.success),
      green: _hex(colors['green'] as String?, d.green),
      mainGradient: LinearGradient(
          colors: [left, right],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      shadow: [
        BoxShadow(
            color: Colors.black.withOpacity(shadowOpacity),
            offset: const Offset(0, 4),
            blurRadius: 4),
      ],
      invertedShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(shadowOpacity),
            offset: const Offset(0, -4),
            blurRadius: 4),
      ],
    );
  }

  @override
  BrandPalette copyWith({
    Color? primary,
    Color? secondary,
    Color? inactive,
    Color? textMain,
    Color? textSecondary,
    Color? success,
    Color? green,
    LinearGradient? mainGradient,
    List<BoxShadow>? shadow,
    List<BoxShadow>? invertedShadow,
  }) =>
      BrandPalette(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        inactive: inactive ?? this.inactive,
        textMain: textMain ?? this.textMain,
        textSecondary: textSecondary ?? this.textSecondary,
        success: success ?? this.success,
        green: green ?? this.green,
        mainGradient: mainGradient ?? this.mainGradient,
        shadow: shadow ?? this.shadow,
        invertedShadow: invertedShadow ?? this.invertedShadow,
      );

  @override
  BrandPalette lerp(ThemeExtension<BrandPalette>? other, double t) {
    if (other is! BrandPalette) return this;
    Color _l(Color a, Color b) => Color.lerp(a, b, t)!;
    return BrandPalette(
      primary: _l(primary, other.primary),
      secondary: _l(secondary, other.secondary),
      inactive: _l(inactive, other.inactive),
      textMain: _l(textMain, other.textMain),
      textSecondary: _l(textSecondary, other.textSecondary),
      success: _l(success, other.success),
      green: _l(green, other.green),
      mainGradient: LinearGradient(
        colors: [
          Color.lerp(
              mainGradient.colors.first, other.mainGradient.colors.first, t)!,
          Color.lerp(
              mainGradient.colors.last, other.mainGradient.colors.last, t)!,
        ],
        begin: mainGradient.begin,
        end: mainGradient.end,
      ),
      shadow: shadow,
      invertedShadow: invertedShadow,
    );
  }
}

// Nice sugar in widgets: context.brand.primary, etc.
extension BrandX on BuildContext {
  BrandPalette get brand => Theme.of(this).extension<BrandPalette>()!;
}
