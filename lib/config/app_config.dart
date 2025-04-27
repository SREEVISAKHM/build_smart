// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

abstract class AppConfig {
  /// Set environment via:
  /// flutter run --dart-define=env=dev
  static const ENV = String.fromEnvironment('env', defaultValue: 'prod');

  static const isDev = ENV == 'dev';
  static const isProd = ENV == 'prod';
  static const isProdRelease = ENV == 'prod' && kReleaseMode;

  /// API Base URLs
  static const baseUrl = isProd
      ? 'https://temporaryProd.com/'
      : "https://https://temporaryDev.com";

  /// Full endpoint examples
  static const loginEndpoint = '$baseUrl/login';
}
