import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/controller/list_item_controller.dart';
import '../../src/models/news_item.dart';
import '../../widgets/news_item_widget.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _ListaPageState();
}

class _ListaPageState extends ConsumerState<NewsPage> {
  //In questo modo utilizziamo RiverPod per recuperare i dati ma soltanto la prima volta che viene instanziata la classe
  late final Future myFuture = ref.watch(newsItemControllerProvider).getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Notizie"))),
      body: SafeArea(
          child: Center(
              child: FutureBuilder(
                  future: myFuture,
                  builder: (context, snapshot) {
                    // Durante il caricamento mostriamo il loader
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }
                    // Ci recuperiamo gli elementi
                    final items = snapshot.data;
                    return ListView.builder(
                      itemCount: items?.length,
                      itemBuilder: (BuildContext context, int index) {
                        NewsItem singleItem = items?[index];
                        return NewsItemWidget(item: singleItem);
                      },
                    );
                  }))),
    );
  }
}
