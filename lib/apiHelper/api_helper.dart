import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:staging_fox_jek_clone_app/apiHelper/api_base_url.dart';
import 'package:staging_fox_jek_clone_app/apiHelper/api_parameters.dart';

class ApiHelper {
  /// Declare Variable
  final _dio = Dio();

  ApiHelper() {
    initializeDio();
  }

  /// this method used to initialize Dio
  initializeDio() {
    _dio.options.baseUrl = ApiBaseUrl.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: 15);
    _dio.options.receiveTimeout = Duration(seconds: 15);
    _dio.options.headers['content-type'] = ApiParameters.applicationAndJson;
    _dio.options.headers['Authorization'] = ApiParameters.applicationAndJson;
    _dio.options.headers['select-time-zone'] = ApiParameters.asiaCalcutta;
    _dio.options.headers['select-ip-address'] = ApiParameters.ipAddress;

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      queryParameters: true,
      canShowLog: true,
      logPrint: debugPrint,
    ));
  }

  /// this is all method of Dio to get data from [API]

  post(String endPoints, {Map<String, dynamic>? body, Map<String, dynamic>? queryParents}) async {
    Response response = await _dio.post(endPoints, queryParameters: queryParents, data: body);
    return response.data;
  }

  get(String endPoints, {Map<String, dynamic>? body, Map<String, dynamic>? queryParents}) async {
    Response response = await _dio.get(endPoints, queryParameters: queryParents, data: body);
    return response.data;
  }

  put(String endPoints, {Map<String, dynamic>? body, Map<String, dynamic>? queryParents}) async {
    Response response = await _dio.put(endPoints, queryParameters: queryParents, data: body);
    return response.data;
  }

  delete(String endPoints, {Map<String, dynamic>? body, Map<String, dynamic>? queryParents}) async {
    Response response = await _dio.delete(endPoints, queryParameters: queryParents, data: body);
    return response.data;
  }
}
