import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/routing.dart';
import 'utils/theme.dart';

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sisal App',
      theme: appTheme,
      routerConfig: router,
    );
  }
}
