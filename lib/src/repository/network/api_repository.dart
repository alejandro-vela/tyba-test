import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../../global_locator.dart';
import 'endpoint.dart';
import 'shared_configuration.dart';

abstract class APIRepository {
  Future<http.Response> request({required Endpoint endpoint});
}

class DefaultAPIRepository implements APIRepository {
  final _logger = global<Logger>();

  @override
  Future<http.Response> request({required Endpoint endpoint}) async {
    _logger.d('Request endpoint: $endpoint');

    final url = Uri.https(
        SharedConfiguration.network.baseUrlDevelopment, endpoint.path);

    var headers = {...SharedConfiguration.network.headers};
    headers.addAll(endpoint.headers);

    switch (endpoint.method) {
      case Method.get:
        return _get(url, headers);
      case Method.post:
        return _post(url, headers, endpoint.parameters);
      case Method.put:
        return _put(url, headers, endpoint.parameters);
      case Method.delete:
        return _delete(url, headers, endpoint.parameters);
    }
  }

  Future<Response> _get(Uri url, Map<String, String> headers) {
    _logger.d('get() with url ($url) - headers ($headers)');
    return http.get(url, headers: headers);
  }

  Future<Response> _post(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('post() with url ($url) - headers ($headers) - body ($body)');
    return http.post(url,
        headers: headers, body: jsonEncode(body), encoding: Utf8Codec());
  }

  Future<Response> _put(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('put() with url ($url) - headers ($headers) - body ($body)');
    return http.put(url,
        headers: headers, body: jsonEncode(body), encoding: Utf8Codec());
  }

  Future<Response> _delete(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('delete() with url ($url) - headers ($headers) - body ($body)');
    return http.delete(url,
        headers: headers, body: jsonEncode(body), encoding: Utf8Codec());
  }
}
