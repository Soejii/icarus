class ApiGuard {
  /// Checks if the response is an HTML string (typically Laravel Blade)
  static bool isHtml(dynamic data) {
    if (data is String) {
      final content = data.trim().toLowerCase();
      return content.contains('<html') || content.contains('<!doctype');
    }
    return false;
  }

  /// Validates that the top-level response is a JSON object
  static bool isJsonMap(dynamic data) {
    return data is Map<String, dynamic>;
  }

  /// Extracts a meaningful error message from the response, or falls back
  static String extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'Unknown error';
    }
    return 'Unknown error';
  }

  static bool hasValidMapData(Map<String, dynamic> json) {
    return json.containsKey('data') && json['data'] is Map<String, dynamic>;
  }

  static bool hasValidListData(Map<String, dynamic> json) {
    return json['data'] is List;
  }

  static bool hasValidPaginatedListData(Map<String, dynamic> json) {
    return json['data'] is Map<String, dynamic> &&
           json['data']['data'] is List;
  }
}