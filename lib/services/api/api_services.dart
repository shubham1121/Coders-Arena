import 'dart:async';
import 'package:coders_arena/utils/global_context.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiServices {
  late Dio _dio;
  ApiServices() {
    _dio = Dio();
  }

  Future<Response?> getContestList({required String clistApiEndUrl}) async {
    try {
      final Response response = await _dio.get(dotenv.env['clistApiBaseUrl']! + clistApiEndUrl);
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }

  Future<Response?> get({required String apiEndUrl}) async {
    try {
      final Response response =
          await _dio.get(dotenv.env['apiBaseUrl']! + apiEndUrl);
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }

  Future<Response?> post(
      {required String apiEndUrl, required Map<String, dynamic> data}) async {
    try {
      final Response response =
          await _dio.post(dotenv.env['apiBaseUrl']! + apiEndUrl, data: data);
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }

  Future<Response?> update(
      {required String apiEndUrl,
      required Map<String, dynamic> data,
      bool? showMessage,
      String? message}) async {
    try {
      final Response response =
          await _dio.patch(dotenv.env['apiBaseUrl']! + apiEndUrl, data: data);
      switch (response.statusCode) {
        case 200:
          if (showMessage != null && showMessage) {
            ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
                .showSnackBar(SnackBar(content: Text(message!)));
          }
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }

  Future<Response?> put(
      {required String apiEndUrl, required Map<String, dynamic> data}) async {
    try {
      final Response response =
          await _dio.put(dotenv.env['apiBaseUrl']! + apiEndUrl, data: data);
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }

  Future<Response?> delete(
      {required String apiEndUrl, required Map<String, dynamic> data}) async {
    try {
      final Response response =
          await _dio.delete(dotenv.env['apiBaseUrl']! + apiEndUrl);
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return null;
      }
    } on TimeoutException catch (error) {
      debugPrint(error.message);
    } on DioError catch (error) {
      debugPrint(error.message);
    }
    return null;
  }
}
