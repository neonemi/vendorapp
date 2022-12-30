import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';

import 'package:http/http.dart' as http;

import '../core.dart';

class ApiProvider {
  ApiProvider({
    required this.token,
    required this.eventBus,
  });

  final String token;
  final int _timeOut = 50;
  final EventBus eventBus;

  // This method will create a URL with base app API
  Uri getUri(String path, {Map<String, dynamic>? queryParameters}) {
    String url = Apis.baseUrl;
    String uriPath = path;

    if (url.contains('/')) {
      final List<String> urlSegment = url.split('/');

      url = urlSegment[0];

      if (uriPath.startsWith('/')) {
        uriPath = uriPath.substring(1);
      }

      uriPath = '/${urlSegment.sublist(1).join('/')}/$uriPath';
    }
    //return Uri.http(url, uriPath, queryParameters);
    return Uri.https(url, uriPath, queryParameters);
  }

  Future<dynamic> get(Uri endPoint, {bool auth = true}) async {
    final Map<String, String> headers;
    if (auth) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }

    late http.Response response;
    try {
      response = await http.get(endPoint, headers: headers).timeout(
            Duration(seconds: _timeOut),
            onTimeout: _onTimeOut,
          );
    } catch (e) {
      throw (HttpException(e.toString()));
    }
    return await _handleResponse(response);
  }

  Future<dynamic> post({
    Object? requestBody,
    required Uri endPoint,
    HttpHeaders? headers,
    bool formEncode = false,
    bool multipartFormData = false,
    bool auth = true,
  }) async {
    http.Response response;
    try {
      Map<String, String> headers = {
        'Content-Type': formEncode
            ? 'application/x-www-form-urlencoded'
            : multipartFormData
                ? 'multipart/form-data'
                : 'application/json',
        'Accept': 'application/json'
      };
      if (auth) {
        headers['Authorization'] = 'Bearer $token';
      }
      response = await http
          .post(endPoint, body: requestBody, headers: headers)
          .timeout(
            Duration(seconds: _timeOut),
            onTimeout: _onTimeOut,
          );
    } catch (e) {
      throw (HttpException(e.toString()));
    }

    return await _handleResponse(response);
  }

  Future<dynamic> put({
    Object? requestBody,
    required Uri endPoint,
    bool auth = true,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if (auth) {
      headers['Authorization'] = 'Bearer $token';
    }
    late http.Response response;
    try {
      response = await http
          .put(
            endPoint,
            body: requestBody,
            headers: headers,
          )
          .timeout(
            Duration(seconds: _timeOut),
            onTimeout: _onTimeOut,
          );
    } catch (e) {
      throw (HttpException(e.toString()));
    }

    return await _handleResponse(response);
  }

  Future<dynamic> delete(Uri endPoint, {bool auth = true}) async {
    final Map<String, String> headers;
    if (auth) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }

    late http.Response response;
    try {
      response = await http.delete(endPoint, headers: headers).timeout(
        Duration(seconds: _timeOut),
        onTimeout: _onTimeOut,
      );
    } catch (e) {
      throw (HttpException(e.toString()));
    }
    return await _handleResponse(response);
  }
  postMultipart({
    var request,
    bool setContentType = true,
  }) async {
    if (setContentType) {
      request.headers["Content-Type"] = 'multipart/form-data';
    }
    request.headers["Accept"] = 'application/json; charset=utf-8';
    request.headers["Authorization"] = 'Bearer $token';

    var streamResponse = await request.send();
    late http.Response response;
    try {
      response = await http.Response.fromStream(streamResponse);
    } catch (e) {
      throw (HttpException(e.toString()));
    }
    return await _handleResponse(response);
  }

  FutureOr<http.Response> _onTimeOut() {
    eventBus.fire(const TimeOutEvent());
    return http.Response("{'message':'Time Out'}", -1);
  }

  /// Handle response from API
  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      final Map<String, dynamic> res = json.decode(response.body);
      print('json res'+res.toString());
      int status = res['status'];
      if (status==200) {
        return res;
      } else {
        throw (HttpException(res['message']));
      }
    } else {

      String mAlert = "Something went wrong";

      eventBus.fire(ErrorAlertEvent(mAlert));
      throw (HttpException(mAlert));
    }
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message); // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}
