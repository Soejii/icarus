class Environments {
  static const String PRODUCTION = 'prod';
  static const String DEV = 'dev';
}

class ConfigEnvironments {
  static const String _currentEnvironments =
      String.fromEnvironment('ENV', defaultValue: Environments.PRODUCTION);

  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'baseUrl': 'https://demo.sidigs.com/api/student',
    },
    {
      'env': Environments.PRODUCTION,
      'baseUrl': '',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
      orElse: () => throw Exception('Environment not found'),
    );
  }
}

