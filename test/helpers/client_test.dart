import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:palm_api/palm_api.dart';
import 'package:palm_api/src/helpers/client.dart';
import 'package:palm_api/src/helpers/palm_api_version.dart';
import 'package:test/test.dart';

void main() {
  test('client should use first version of API if there arent any version selected', () async {
    late Uri url;
    final client = PalmClient(
      client: MockClient((request) {
        url = request.url;
        return Future.value(Response('{}', 200));
      }),
    );

    await client.get('');

    expect(url.pathSegments.contains(PalmApiVersion.v1Beta2.name), true);
  });

  test('client should use selected version of API if there are a version selected', () async {
    final apiVersion = PalmApiVersion.v1Beta3;
    late Uri url;
    final client = PalmClient(
      apiVersion: apiVersion,
      client: MockClient((request) {
        url = request.url;
        return Future.value(Response('{}', 200));
      }),
    );

    await client.get('');

    expect(url.pathSegments.contains(apiVersion.name), true);
  });
}
