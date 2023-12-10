import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:water_shader/core/utils/index.dart';
import 'package:water_shader/network/index.dart';

abstract class BaseProvider {
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");

    final int start = DateTime.now().millisecondsSinceEpoch;
    return GlobalVariables.tools.dio
        .get(
      url,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    )
        .then(
      (Response<dynamic> value) {
        final int end = DateTime.now().millisecondsSinceEpoch;
        debugPrint("Request Time (${value.realUri}): ${end - start}");
        return value as Response<T>;
      },
    );
  }

  Future<Response<T>> post<T>(String? url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");

    final int start = DateTime.now().millisecondsSinceEpoch;
    return GlobalVariables.tools.dio
        .post(
      url!,
      data: body,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    )
        .then(
      (Response<dynamic> value) {
        final int end = DateTime.now().millisecondsSinceEpoch;
        debugPrint("Request Time (${value.realUri}): ${end - start}");
        return value as Response<T>;
      },
    );
  }

  Future<Response<T>> put<T>(String? url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");

    final int start = DateTime.now().millisecondsSinceEpoch;
    return GlobalVariables.tools.dio
        .put(
      url!,
      data: body,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    )
        .then(
      (Response<dynamic> value) {
        final int end = DateTime.now().millisecondsSinceEpoch;
        debugPrint("Request Time (${value.realUri}): ${end - start}");
        return value as Response<T>;
      },
    );
  }

  Future<Response<T>> delete<T>(String? url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");

    final int start = DateTime.now().millisecondsSinceEpoch;
    return GlobalVariables.tools.dio
        .delete(
      url!,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    )
        .then(
      (Response<dynamic> value) {
        final int end = DateTime.now().millisecondsSinceEpoch;
        debugPrint("Request Time (${value.realUri}): ${end - start}");
        return value as Response<T>;
      },
    );
  }
}
