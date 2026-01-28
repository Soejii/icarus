// lib/bootstrap/firebase_init.dart
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';

// import the four files you generated
import 'firebase_options_default_prod.dart' as dprod;
import 'firebase_options_default_dev.dart' as ddev;
import 'firebase_options_mancaksa_prod.dart' as mprod;
import 'firebase_options_mancaksa_dev.dart' as mdev;

const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'defaultProd');

FirebaseOptions _opts(String f) {
  log("Current Flavor :$flavor");
  switch (f) {
    case 'defaultDev':
      return ddev.DefaultFirebaseOptions.currentPlatform;
    case 'mancaksaProd':
      return mprod.DefaultFirebaseOptions.currentPlatform;
    case 'mancaksaDev':
      return mdev.DefaultFirebaseOptions.currentPlatform;
    case 'defaultProd':
    default:
      return dprod.DefaultFirebaseOptions.currentPlatform;
  }
}

Future<void> initFirebase() async {
    // ignore: avoid_print
  print('Firebase FLAVOR at runtime: $flavor');

  final opts = _opts(flavor);
  // ignore: avoid_print
  print('Firebase appId: ${opts.appId}');
  // ignore: avoid_print
  print('Firebase projectId: ${opts.projectId}');
  // ignore: avoid_print
  print('Firebase apiKey: ${opts.apiKey.substring(0, 8)}****');
  await Firebase.initializeApp(options: _opts(flavor));
}
