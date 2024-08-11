import 'dart:io';

import 'package:dio/dio.dart';

class HttpBizInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO 添加通用请求头信息

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO 校验服务端错误码
    if (response.statusCode != 200) {
      var exception =
          DioException(requestOptions: response.requestOptions, response: response, type: DioExceptionType.badResponse);
      handler.reject(exception, true);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO 处理错误
    final exception = HttpException(err.message ?? "Server Error");
    switch (err.type) {
      case DioExceptionType.badResponse: // 服务端自定义错误体处理
        {
          final response = err.response;
          final statusCode = response?.statusCode ?? 0;
          switch (statusCode) {
            case 401:
              break;
            case 404:
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
        }
        break;
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionTimeout:
        break;
      default:
        break;
    }
    DioException errNext = err.copyWith(error: exception);
    handler.next(errNext);
  }
}
