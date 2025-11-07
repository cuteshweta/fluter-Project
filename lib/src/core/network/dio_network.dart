import 'package:dio/dio.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart';

import '../utils/log/app_logger.dart';
import 'logger_interpertor.dart';

class DioNetwork {
  late final Dio appApi;

  DioNetwork() {
    appApi = Dio(baseOptions(apiUrl));
    appApi.interceptors.add(loggerInterceptor());
  }

  static BaseOptions baseOptions(String url) {
    return BaseOptions(baseUrl: url, responseType: ResponseType.json);
  }

  static LoggerInterceptor loggerInterceptor() {
    return LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    );
  }
}
