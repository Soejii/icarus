import 'package:firebase_analytics/firebase_analytics.dart';

import 'analytics_tracker.dart';

class FirebaseAnalyticsTracker implements AnalyticsTracker {
  FirebaseAnalyticsTracker(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> trackScreen(
    String screenName, {
    Map<String, Object>? params,
  }) {
    return _analytics.logScreenView(
      screenName: screenName,
      parameters: params,
    );
  }

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, Object>? params,
  }) {
    return _analytics.logEvent(name: name, parameters: params);
  }

  @override
  Future<void> setUserId(String userId) => _analytics.setUserId(id: userId);

  @override
  Future<void> setUserProperty(String name, String value) {
    return _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> clearData() {
    return _analytics.resetAnalyticsData();
  }
}
