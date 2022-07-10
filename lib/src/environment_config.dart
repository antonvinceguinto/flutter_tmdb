import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig {
  // Add the API key by running `flutter run --dart-define=movieApiKey=<value>`
  final movieApiKey = const String.fromEnvironment('movieApiKey');
}

final environmentConfigProvider = Provider<EnvironmentConfig>(
  (ref) => EnvironmentConfig(),
);
