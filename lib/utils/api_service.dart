import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final _baseUrl = "https://www.gazzetta.it";
  final _receiveTimeout = const Duration(seconds: 5);
  final _connectTimeout = const Duration(seconds: 5);
  final _sendTimeout = const Duration(seconds: 5);

  late Dio _dio;
  ApiService._internal();
  static final ApiService _apiService = ApiService._internal();
  factory ApiService() => _apiService;

  Dio provideDio() {
    // Le opzioni per le quali tutte le chiamate hanno queste variabili
    BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: _receiveTimeout,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
    );

    // Per comodità faccio il log delle chiamate API per vederle in console
    PrettyDioLogger prettyDioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );

    _dio = Dio(baseOptions);

    //Aggiungo il loggeler all'interceptor
    _dio.interceptors.addAll({
      prettyDioLogger,
    });

    return _dio;
  }
}
