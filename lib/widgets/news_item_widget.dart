import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/models/news_item.dart';
import '../utils/theme.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({super.key, required this.item});
  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    // Qua faccio il subString per recuperarmi i primi 50 caratteri della stringa
    final String description = (item.description?.length ?? 0) > 50
        ? '${item.description?.substring(0, 49)}...'
        : item.description ?? "";
    return Padding(
      padding:
          EdgeInsets.fromLTRB(maxPadding, minPadding, maxPadding, minPadding),
      child: GestureDetector(
        onTap: () {
          context
              .goNamed("newsDetail", pathParameters: {'link': item.link ?? ""});
        },
        child: Card(
          // Ho deciso di inserire gli elementi all'interno di una Card
          // Perché graficamente mi sembrava la soluzione più coerente con il tipo di elemento
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immagine
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: item.getImageFromLink()),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      mediumPadding, mediumPadding, mediumPadding, 0),
                  child: Column(
                    children: [
                      // Titolo
                      Text(item.getHtmlDecodedString(item.title ?? ""),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      mediumPadding, 0, mediumPadding, mediumPadding),
                  // Descrizione
                  child: Text(item.getHtmlDecodedString(description.trim())
                      // overflow: TextOverflow.ellipsis, - Avrei potuto utilizzare questo metodo
                      //ma avrei dovuto mettere le maxLines, qua invece il vincolo sono i 50 caratteri
                      ),
                )
              ]),
        ),
      ),
    );
  }
}
