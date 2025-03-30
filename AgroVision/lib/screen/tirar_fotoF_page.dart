import 'dart:io';

import 'package:AgroVision/common/page_default.dart';
import 'package:AgroVision/screen/result_ia_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TirarFotoFPage extends StatefulWidget {
  @override
  _TirarFotoFPageState createState() => _TirarFotoFPageState();
}

class _TirarFotoFPageState extends State<TirarFotoFPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Função para abrir a câmera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ApiScreen(
                image: _image,
              )));
    }
  }

  // Função para abrir a galeria
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ApiScreen(
                    image: _image,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageDefault(
      child: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'CAPTURAR IMAGEM DA PRAGA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 90),
              GestureDetector(
                  onTap: _pickImageFromCamera,
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.camera_alt_outlined,
                                size: 100, color: Colors.black),
                          ),
                        ),
                      ),

                      // Botão "Tirar Foto"
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        width: 275,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'Tirar Foto',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  )),

              const SizedBox(height: 50),
              GestureDetector(
                onTap: _pickImageFromGallery,
                // Adiciona a função para abrir a galeria
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.image_outlined,
                              size: 100, color: Colors.black),
                        ),
                      ),
                    ),

                    // Botão "Escolher da Galeria"
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      width: 275,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Escolher da Galeria',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), // Empurra os botões para o final da tela
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Ação para configurações
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.help_outline, color: Colors.white),
                    onPressed: () {
                      // Ação para ajuda
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
