import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:palm_api/src/exception.dart';

const _defaultAPIEndpoint = 'https://generativelanguage.googleapis.com/v1beta2';

class PalmClient {
  final String _baseUrl;

  http.Client httpClient; // Instantiate the HTTP client

  PalmClient({
    /// Change the baseUrl for proxy implementation
    String? baseUrl,
    http.Client? client,
  })  : httpClient = client ?? http.Client(),
        _baseUrl = baseUrl ?? _defaultAPIEndpoint;

  /// General method to make a GET request.
  ///
  /// [path] is appended to the base URL to form the full URL to connect to.
  ///
  /// Returns the JSON body of the response, parsed as a Map.
  Future<Map<String, dynamic>> get(String path) async {
    Uri url = Uri.parse('$_baseUrl/$path');
    var response = await httpClient.get(url);

    // If the request was successful, parse and return the JSON response body.
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    // If the server responds with another status code, we throw an
    // exception with the status code and the error body.
    throw PalmApiException(response.body, response.statusCode);
  }

  /// Method to make POST request.
  ///
  /// [path] is appended to the base URL and [body] is the request payload.
  ///
  /// Returns the JSON body of the response.
  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    Uri url = Uri.parse('$_baseUrl/$path');
    var response = await httpClient.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    // If the server returns a OK response, parse and return the JSON response body.
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    throw PalmApiException(response.body, response.statusCode);
  }

  /// Don't forget to close the httpClient when it's no longer used.
  void dispose() {
    httpClient.close();
  }
}
