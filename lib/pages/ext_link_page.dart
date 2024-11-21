import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class ExternalLinkPage extends StatefulWidget {
  const ExternalLinkPage({super.key});

  @override
  State<ExternalLinkPage> createState() => _ExternalLinkPageState();
}

class _ExternalLinkPageState extends State<ExternalLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("Instagram"))),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(mediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(minPadding),
                  child: Text(
                      "Premendo sul pulsante sottostante avverrà un reindirizzamento sull'applicazione instragram se già installata sul dispositivo, altrimenti si aprirà lo store per l'installazione dell'app"),
                ),
              ),
              Expanded(
                child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          // Per Android utilizziamo il nome del pacchetto messo nel AndroidManifest
                          // Per iOS utilizziamo lo scheme URL messo nel Info.plist
                          await LaunchApp.openApp(
                            androidPackageName: 'com.instagram.android',
                            iosUrlScheme: 'instagram://',
                            appStoreLink:
                                'itms-apps://itunes.apple.com/it/app/instagram/id389801252',
                          );
                        },
                        child: Text("Apri Instagram"))),
              ),
            ],
          ),
        )));
  }
}
