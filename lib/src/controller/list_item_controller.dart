import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:xml2json/xml2json.dart';

import '../models/news_item.dart';
import '../repo/list_item_repo.dart';

final newsItemControllerProvider = Provider((ref) {
  // Facciamo il return del Controller con il Repo
  return NewsItemController(newsItemRepo: ref.watch(newsItemProvider));
});

class NewsItemController {
  NewsItemController({required NewsItemRepo newsItemRepo})
      : _newsItemRepo = newsItemRepo;

  final NewsItemRepo _newsItemRepo;
  List<NewsItem> itemsList = [];

  Future<List<NewsItem>> getItems() async {
    // Per non rifare la chiamata quando abbiamo già i dati che ci interessano
    if (itemsList.isNotEmpty) return itemsList;
    Response response = await _newsItemRepo.getItemsFromApi();
    final xml2json = Xml2Json();
    // Convertiamo il file XML in un JSON per comodità
    xml2json.parse(response.data);
    final jsonString = xml2json.toParkerWithAttrs();
    // Utilizziamo decode che messo a disposizione da Flutter
    final jsonObject = json.decode(jsonString);
    // Qua andiamo a recuperarci gli oggetti singoli
    itemsList = jsonObject['rss']['channel']['item']
        .map<NewsItem>((singleItem) => NewsItem.fromJson(singleItem))
        .toList();
    // Ritorniamo la lista con gli oggetti
    return itemsList;
  }
}
