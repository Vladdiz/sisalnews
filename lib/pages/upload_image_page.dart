import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart'
    as path_package; // Ho dovuto fare 'as' perché questa libreria contiene una var di nome Context
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/theme.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  XFile? image;
  Image? imageSaved;
  final picker = ImagePicker();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Verifichiamo se abbiamo già un'immagine salvata e la recuperiamo
      if (prefs.getString('image_saved') != null &&
          prefs.getString('image_saved') != "") {
        File imageSavedFile = await getImageFromSp();
        imageSaved = Image.file(imageSavedFile);
      }
      // Per mostrare l'immagine recuperata
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Carica immagine"))),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(mediumPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(minPadding),
                  child: Text(
                      "Premendo sul pulsante sottostante comparirà un menù con la possiblità di selezionare un'immagine dalla galleria o scattarla con la fotocamera del cellulare. L'immagine verrà mostrata e salvata nella cartella dell'applicazione in modo che al prossimo avvio dell'app sarà ancora presente all'interno della pagina."),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image != null
                            ? Image.file(File(image?.path ?? ""), height: 380)
                            : SizedBox(
                                height: imageSaved != null ? 400 : 0,
                                child: imageSaved ?? Container()),
                        Padding(
                          padding: EdgeInsets.only(top: minPadding),
                          child: ElevatedButton(
                              onPressed: () {
                                showOptions();
                              },
                              child: Text('Aggiungi una foto')),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future getImageFromGallery() async {
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    image = imageFile;
    saveImageToAppDir(imageFile);
    setState(() {});
  }

  Future getImageFromCamera() async {
    final XFile? photoFile = await picker.pickImage(source: ImageSource.camera);
    if (photoFile == null) return;
    image = photoFile;
    saveImageToAppDir(photoFile);
    setState(() {});
  }

  Future saveImageToAppDir(XFile image) async {
    // Recuperiamo la cartella dell'app (Per iOS è necessario buildare editando lo scheme del Runner e buildare in )
    // Modalità Release! Altrimenti in Debug iOS cambia il nome della cartella ad ogni build e si perde l'immagine
    final Directory duplicateFile = await getApplicationDocumentsDirectory();
    // Recuperiamo il percorso
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Verifichiamo se abbiamo già un'immagine e la eliminiamo in caso
    if (prefs.getString('image_saved') != null &&
        prefs.getString('image_saved') != "") {
      final String imageSavedPath = prefs.getString('image_saved') ?? "";
      // Recuperiamo il vecchio file attraverso il path salvato nelle Sps
      File? oldFile = File(imageSavedPath);
      // Eliminazione
      oldFile.delete();
    }
    final String fileName = path_package.basename(image.path);
    // Salviamo il file con il path della cartella
    await image.saveTo('${duplicateFile.path}/$fileName');
    // Salviamo il nuovo percorso nelle Sp
    prefs.setString('image_saved', '${duplicateFile.path}/$fileName');
  }

  Future<File> getImageFromSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return File(prefs.getString('image_saved') ?? "");
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Galleria'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
