import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kids_play_time/app/constant_web.dart';

class RepositoryHelper {
  BuildContext context;

  RepositoryHelper(this.context);

  Future<ResponseObject> apiCall({
    required String url,
    String method = "GET",
    Map<String, String>? fields,
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) async {
    Uri uri = Uri.parse(url);

    try {
      final request = http.MultipartRequest(method, uri);
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';

      if (headers != null) {
        request.headers.addAll(headers);
      }

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null && files.isNotEmpty) {
        request.files.addAll(files);
      }

      final response = await request.send().timeout(const Duration(seconds: 30));

      final responseData = await response.stream.transform(utf8.decoder).join();

      debugPrint(responseData);

      var decodedJson = {};
      try {
        decodedJson = json.decode(responseData);
      } catch (e) {
        decodedJson = json.decode(json.encode(responseData));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decodedJson['response'].toString().toLowerCase() == 'error') {
          return ResponseObject(
            id: ResponseCode.FAILED,
            object: decodedJson.toString().contains('message') ? decodedJson['message'] : 'Something went wrong!!!',
          );
        } else {
          return ResponseObject(
            id: ResponseCode.SUCCESSFUL,
            object: responseData,
          );
        }
      } else if (response.statusCode == 401) {
        return ResponseObject(id: ResponseCode.AUTHORIZATION_FAILED, object: 'Please login again');
      } else if (decodedJson.toString().contains('errors')) {
        return ResponseObject(id: ResponseCode.FAILED, object: decodedJson['errors']);
      } else if (decodedJson.toString().contains('message')) {
        return ResponseObject(id: ResponseCode.FAILED, object: decodedJson['message']);
      } else {
        return ResponseObject(id: ResponseCode.FAILED, object: 'Status code for request ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      log(uri.toString());

      return ResponseObject(
        id: ResponseCode.FAILED,
        object: "",
      );
    }
  }
}
