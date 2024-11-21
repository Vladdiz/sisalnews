import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/ext_link_page.dart';
import '../../pages/listItemPages/news_page.dart';
import '../../pages/upload_image_page.dart';

// La prima volta l'indice iniziale è zero
final indexBottomNavbarProvider = StateProvider<int>((ref) {
  return 0;
});

// Instanziamo le pagine una sola volta
final bodies = [const NewsPage(), ExternalLinkPage(), UploadImagePage()];
