import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["X-Naver-Client-Id"] = "mcnvkkPFl53se6mAfTsm";
    options.headers["X-Naver-Client-Secret"] = "2JbpudtprO";
    super.onRequest(options, handler);
  }
}
