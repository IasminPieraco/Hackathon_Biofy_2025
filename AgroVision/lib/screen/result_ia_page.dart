import 'dart:convert';
import 'dart:io';

import 'package:AgroVision/classes/category_model.dart';
import 'package:AgroVision/common/build_button.dart';
import 'package:AgroVision/common/page_default.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  final File? image;

  const ApiScreen({Key? key, required this.image}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  Future<List<CategoryModel>> fetchData() async {
    final response = await http.post(
      Uri.parse('http://10.20.30.245:5000/classify'),
      body:  jsonEncode({
        'image_base64': base64Encode(widget.image!.readAsBytesSync()),
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<CategoryModel> categories =
      jsonData.map((json) => CategoryModel.fromJson(json)).toList();

      categories.sort((a, b) => b.percentual.compareTo(a.percentual));

      return categories;
    } else {
      print(response.statusCode);
      throw Exception('Falha ao carregar os dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageDefault(
      child: FutureBuilder<List<CategoryModel>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SUGESTÃO PARA CONTROLE DE INFESTAÇÃO',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    BuildButton(
                      label: 'Chat com Agrônomo',
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ChatScreen()),
                        // );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'POSSÍVEL PRAGA DETECTADA',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Image(
                      image: widget.image != null
                          ? FileImage(widget.image!) as ImageProvider
                          : AssetImage('assets/images/placeholder.png'),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data[index].category, style: TextStyle(color: Colors.white, fontSize: 22)),
                            Text('${(data[index].percentual*100).toStringAsFixed(02)}%', style: TextStyle(color: Colors.white, fontSize: 22)),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text("*Dados gerados por um modelo de inteligência artificial treinado com imagens de pragas e doenças de plantas.", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
