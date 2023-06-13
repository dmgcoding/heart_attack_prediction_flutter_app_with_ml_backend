import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000';

  static Future<http.Response?> getRequest(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl/$path');
    try {
      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      throw HttpException('Failed to fetch data: $e');
    }
  }

  static Future<http.Response?> postRequest(String path,
      {Map<String, dynamic>? bodyJson, String? token}) async {
    final url = Uri.parse('$baseUrl/$path');

    try {
      Map<String, String> headers = {};

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = json.encode(bodyJson);

      final response = await http.post(url, body: body, headers: headers);
      return response;
    } catch (e) {
      throw HttpException('Failed to fetch data: $e');
    }
  }
}
