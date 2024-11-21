import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class NewsItem {
  String? title; //title
  String? link; //link
  String? creator; //dc:creator
  String? pubDate; //pubDate
  String? category; //category
  List<String>? categories;
  String? guid; //guid
  String? description; //description
  String? imageString; //media:thumbnail

  NewsItem(
      {this.title,
      this.link,
      this.creator,
      this.pubDate,
      this.categories,
      this.guid,
      this.description,
      this.imageString});

  // Ho dovuto utilizzare una libreria esterna per
  // convertire HTML-escaped [data] in unescaped string.
  String getHtmlDecodedString(String stringToDecode) {
    return HtmlUnescape().convert(stringToDecode);
  }

  // Mi recupero l'immagine dal link dell'oggetto
  Image? getImageFromLink() {
    return Image.network(
      fit: BoxFit.fitWidth,
      imageString ?? "",
      errorBuilder: (context, obj, stackTrace) {
        return Container();
      },
    );
  }

  // Avrei poututo utilizzare 'json_serializable' però quando eseguivo
  // dart run build_runner build il progetto non buildava più
  factory NewsItem.fromJson(Map<String, dynamic> json) {
    List<String> categories = [];
    if (json['category'] is List) {
      categories = List.from(json['category']);
    } else if (json['category'] is String) {
      categories = [json['category']];
    }
    return NewsItem(
        title: json['title'] ?? 'Unknown',
        link: json['link'] ?? 'Unknown',
        creator: json['dc:creator'] ?? 'Unknown',
        pubDate: json['pubDate'] ?? 'Unknown',
        categories: categories,
        guid: json['guid']['value'] ?? 'Unknown',
        description: json['description'] ?? 'Unknown',
        imageString: json['media:thumbnail']['_url'] ?? 'Unknown');
  }
}
