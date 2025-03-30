import 'dart:convert';

import 'package:AgroVision/classes/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BancoDeImagensPage extends StatefulWidget {
  const BancoDeImagensPage({super.key});

  @override
  _BancoDeImagensPageState createState() => _BancoDeImagensPageState();
}

class _BancoDeImagensPageState extends State<BancoDeImagensPage> {
  late Future<List<ImageModel>> futureImages;

  Future<List<ImageModel>> fetchImages() async {

      final planta1 = ImageModel(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV0EN3UDpPtGkUpJFUIbX1nXETeNLlhsvvfA&s',
        name: 'Soja',
        date: '10/10/2021',
      );

      final planta2 = ImageModel(
        imageUrl: 'https://safraviva.com.br/wp-content/uploads/clorose-batata.jpg',
        name: 'Milho',
        date: '10/10/2021',
      );

      final planta3 = ImageModel(
        imageUrl: 'https://safraviva.com.br/wp-content/uploads/pragas-da-batata-mosca-minadora.jpg',
        name: 'Café',
        date: '10/10/2021',
      );

      final planta4 = ImageModel(
        imageUrl: 'https://www.picturethisai.com/image-handle/website_cmsname/image/1080/440243343377563654.jpeg?x-oss-process=image/format,webp',
        name: 'Feijão',
        date: '10/10/2021',
      );

      return [planta1, planta2, planta3, planta4];
  }

  @override
  void initState() {
    super.initState();
    futureImages = fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A8A13),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Banco de Imagens', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Banco de Imagens',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<ImageModel>>(
                future: futureImages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma imagem disponível', style: TextStyle(color: Colors.white)));
                  }

                  final images = snapshot.data!;
                  return ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return ImageCard(
                        imageUrl: image.imageUrl,
                        title: image.name,
                        date: image.date,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;

  const ImageCard({
    required this.imageUrl,
    required this.title,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        subtitle: Text(date, style: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}
