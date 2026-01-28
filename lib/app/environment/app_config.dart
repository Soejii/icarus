import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:icarus/app/theme/brand_spec.dart';

class AppConfig {
  final String appName;
  final Uri baseUrl;
  final Map<String, bool> features;
  final String deeplinkScheme;
  final BrandSpec brandSpec;
  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.features,
    required this.deeplinkScheme,
    required this.brandSpec,
  });

  factory AppConfig.fromJson(Map<String, dynamic> j) => AppConfig(
        appName: j['appName'] as String,
        baseUrl: Uri.parse(j['baseUrl'] as String),
        features: Map<String, bool>.from(j['features'] ?? const {}),
        deeplinkScheme: j['deeplinkScheme'] as String? ?? 'gaiaapp',
        brandSpec: BrandSpec.fromJson(j['brandSpec'] as Map<String, dynamic>),
      );
}

class AppConfigLoader {
  static Future<AppConfig> load(String client, String env) async {
    Future<String> read(String c, String e) =>
        rootBundle.loadString('assets/clients/$c/config.$e.json');

    String jsonStr;
    try {
      jsonStr = await read(client, env);
    } on FlutterError {
      try {
        jsonStr = await read(client, 'dev');
      } on FlutterError {
        try {
          jsonStr = await read('default', env);
        } on FlutterError {
          jsonStr = await read('default', 'dev');
        }
      }
    }
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    final cfg = AppConfig.fromJson(map);
    assert(env != 'prod' || cfg.baseUrl.toString().isNotEmpty,
        'prod baseUrl must not be empty');
    return cfg;
  }
}
