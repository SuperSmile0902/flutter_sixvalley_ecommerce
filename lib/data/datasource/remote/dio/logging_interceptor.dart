import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print("--> ${options.method} ${options.path}");
    // print("Headers: ${options.headers.toString()}");
    // print("<-- END HTTP");
    print("<===-----END HTTP----===>");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // print(
    //     "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    dynamic responseAsString = response.data;

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print("<===---Second responseAsString---===>");
        // print(
        //     responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      print("<==---response DATA---==> ");
    }
    print("<==================END onResponse====================>");
    // print("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}
