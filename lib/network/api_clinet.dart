import 'package:dio/dio.dart';
import 'package:parking_lot_system/const/endpoint.dart';

class ApiClient {
  final Dio _dio;

  final String? _baseUrl;

  ApiClient(this._dio, this._baseUrl) {
    _dio
      ..options.baseUrl = _baseUrl ?? ''
      ..options.headers = <String, dynamic>{}
      ..options.responseType = ResponseType.json
      ..interceptors.addAll(
        [
          LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            logPrint: print,
          ), // LogInterceptor
        ],
      );
  }

  Future<Map<String, dynamic>> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? isDownload,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isDownload != null && isDownload == true) {
        final data = <String, dynamic>{};
        data["data"] = response;
        return data;
      } else {
        return response.data as Map<String, dynamic>;
      }
    } on DioError catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['error'] = e.response?.data['error'];
      errorResponse['statusCode'] = e.response?.statusCode;
      errorResponse['message'] = e.response?.data['message'];
      return errorResponse;
    }
  }
}
