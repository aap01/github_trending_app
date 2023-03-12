class RemoteConfig {
  final String baseUrl;
  static RemoteConfig instance =
      const RemoteConfig._internal(baseUrl: 'https://api.github.com');
  const RemoteConfig._internal({
    required this.baseUrl,
  });
}
