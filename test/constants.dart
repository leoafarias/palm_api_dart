import 'package:dotenv/dotenv.dart';

class TestEnv {
  static final DotEnv _env = DotEnv(includePlatformEnvironment: true)..load();
  static get palmApiKey {
    return _env['PALM_API_KEY'];
  }
}
