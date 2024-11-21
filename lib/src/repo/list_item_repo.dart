import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/api_service.dart';

final newsItemProvider = Provider((ref) => NewsItemRepo());

class NewsItemRepo {
  // Recuperiamo l'oggetto Dio con il logger e le proprie opzioni
  Dio dio = ApiService().provideDio();

  // Questa è la chiamata API vera e propria per recuperare i dati con una GET
  Future<Response> getItemsFromApi() async {
    return await dio.get(
        'https://www.gazzetta.it/dynamic-feed/rss/section/Calcio/Serie-A.xml');
  }
}
