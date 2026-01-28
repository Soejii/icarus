class BrandSpec {
  final String logoAsset;
  final double logoWidth;
  final double logoHeight;

  final String? logoNameAsset; // null means hidden
  final double? logoNameWidth;
  final double? logoNameHeight;

  final int betweenNameAndForm;

  const BrandSpec({
    required this.logoAsset,
    required this.logoWidth,
    required this.logoHeight,
    this.logoNameAsset,
    this.logoNameWidth,
    this.logoNameHeight,
    required this.betweenNameAndForm,
  });

  factory BrandSpec.fromJson(Map<String, dynamic> j) => BrandSpec(
        logoAsset: j['logoAsset'] as String,
        logoNameAsset: j['logoNameAsset'] as String?,
        logoWidth: (j['logoWidth'] as num).toDouble(),
        logoHeight: (j['logoHeight'] as num).toDouble(),
        logoNameHeight: (j['logoNameHeight'] as num?)?.toDouble(),
        logoNameWidth: (j['logoNameWidth'] as num?)?.toDouble(),
        betweenNameAndForm: j['betweenNameAndForm'],
      );
}
