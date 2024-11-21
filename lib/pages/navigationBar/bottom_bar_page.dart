import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/controller/navigation_bar_controller.dart';

class BottomBarPage extends ConsumerWidget {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    return Scaffold(
      body: bodies[indexBottomNavbar],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar, // La variabile del provider
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: "Notizie"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "Instagram"),
          BottomNavigationBarItem(
              icon: Icon(Icons.image), label: "Carica Immagine")
        ],
        onTap: (value) {
          // Al tap assegniamo il nuovo indice selezionato all'indexBottomNavbarProvider
          // in modo che il currentIndex si aggiorni automaticamente
          ref.read(indexBottomNavbarProvider.notifier).update((state) => value);
        },
      ),
    );
  }
}
