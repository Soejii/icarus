abstract class AnalyticsTracker {
  Future<void> trackScreen(
    String screenName, {
    Map<String, Object>? params,
  });

  Future<void> trackEvent(
    String name, {
    Map<String, Object>? params,
  });

  Future<void> setUserId(String userId);

  Future<void> setUserProperty(String name, String value);

  Future<void> clearData();
}
