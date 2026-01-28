import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'analytics_tracker.dart';
import 'firebase_analytics_tracker.dart';

part 'analytics_providers.g.dart';

@riverpod
FirebaseAnalytics firebaseAnalytics(Ref ref) => FirebaseAnalytics.instance;

@riverpod
AnalyticsTracker analyticsTracker(Ref ref) {
  return FirebaseAnalyticsTracker(
    ref.watch(firebaseAnalyticsProvider),
  );
}
