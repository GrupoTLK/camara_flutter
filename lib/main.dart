import 'package:flutter/material.dart';
//import 'dart:async';
import 'dart:io';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:blog_app/models/ImageUploadModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camara Gallery',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _pickedImage;

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Seleccione la ruta de la imagen"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camara"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Galeria"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            )
    );

    if(imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if(file != null) {
        setState(() => _pickedImage = file);
      }
    }
  }
///////////////////////////////////////////Imagen, Icono y Nota en el Centro de la Pantalla/////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pasos para Ensamblaje"),
      ),
      body: Center(
        child: _pickedImage == null ?
        Text("Nada que mostrar") :
        Image(image: FileImage(_pickedImage)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.image),
      ),
    );
  }
}
