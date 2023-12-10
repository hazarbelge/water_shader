import "package:dio/dio.dart";
import 'package:water_shader/network/index.dart';

class ExternalRequests {
  static int timeOutMilliseconds = 5000 * 60;

  static Options get requestOptions => Options(
        headers: RequestInterceptor.getHeaders,
        receiveTimeout: const Duration(minutes: 2),
        validateStatus: (int? status) => status! < 500,
      );
}
