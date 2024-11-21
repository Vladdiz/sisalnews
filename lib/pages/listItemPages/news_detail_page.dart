import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key, required this.link});
  final String link;

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late WebViewController controller = WebViewController();
  bool isLoading = true;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = WebViewController()
        ..loadRequest(
          Uri.parse(widget.link),
        )
        ..setNavigationDelegate(
            NavigationDelegate(onPageFinished: (String url) {
          if (isLoading) {
            setState(() {
              isLoading = false;
            });
          }
        }));
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(widget.link));
    return Scaffold(
        appBar: AppBar(title: Text('Sisal News')),
        body: SafeArea(
          child: Stack(children: [
            // Mostriamo il CircularProgressIndicator se la pagina sta caricando
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : WebViewWidget(controller: controller, key: key),
          ]),
        ));
  }
}
