import 'dart:io';

import 'package:dotenv/dotenv.dart';

final isCI = Platform.environment['IS_CI'] == 'true';

class TestEnv {
  static final DotEnv _env = DotEnv(includePlatformEnvironment: true);
  static get palmApiKey {
    if (isCI) return Platform.environment['PALM_API_KEY'];
    _env.load();
    return _env['PALM_API_KEY'];
  }
}
