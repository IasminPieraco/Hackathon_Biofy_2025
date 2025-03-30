import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'chat_page.dart';

class DetalhesLotePage extends StatefulWidget {
  const DetalhesLotePage({super.key});

  @override
  _DetalhesLotePageState createState() => _DetalhesLotePageState();
}

class _DetalhesLotePageState extends State<DetalhesLotePage> {
  List<String> avisos = [];

  @override
  void initState() {
    super.initState();
    fetchAvisos();
  }

  Future<void> fetchAvisos() async {
    try {
      final response = await http.get(Uri.parse('http://10.20.30.245:5000/avisos'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          avisos = List<String>.from(data);
        });
      } else {
        throw Exception('Erro ao carregar avisos');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Widget avisoCard(String mensagem) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white38),
      ),
      child: Text(
        mensagem,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
  Future<Map<String, dynamic>?> buscarUsuarioPorEmail() async {
    final prefs = await SharedPreferences.getInstance();

    String? usuariosString = prefs.getString('usuarios');
    String? emailBuscado = prefs.getString('email')?.trim();

    print("Usuarios armazenados: $usuariosString");
    print("Email buscado: $emailBuscado");

    if (usuariosString != null && emailBuscado != null) {
      List<dynamic> usuarios = json.decode(usuariosString);

      for (var usuario in usuarios) {
        print("Verificando usuário: ${usuario['email']}");
        if (usuario['email'].toString().trim() == emailBuscado) {
          print("Usuário encontrado: ${usuario['nome']}");
          return usuario;
        }
      }
    }

    print("Usuário não encontrado.");
    return null;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800], // Cor de fundo igual à imagem
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Seção de informações do produtor
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Map<String, dynamic>?>(
                      future: buscarUsuarioPorEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return infoText("Nome do produtor", "Carregando...", bold: true);
                        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                          return infoText("Nome do produtor", "Usuário não encontrado", bold: true);
                        } else {
                          print("Nome do usuário exibido: ${snapshot.data!['nome']}");
                          return infoText("Nome do produtor", snapshot.data!['nome'] ?? "Desconhecido", bold: true);
                        }
                      },
                    ),



                    infoText("Nome do local", "Uberaba", bold: true),
                    const SizedBox(height: 10),
                    infoText("Cultura", "Soja", bold: true),
                    infoText("Última atualização", "23:59 29/03/2025", bold: true),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Caixa com o título "Avisos"
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Avisos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Lista de avisos dinâmicos
                  avisos.isNotEmpty
                      ? Column(
                    children: avisos.map((aviso) => avisoCard(aviso)).toList(),
                  )
                      : const Center(
                    child: Text(
                      "Nenhum aviso disponível",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Mapa de localização
              const Text("Localização",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 5),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: const LatLng(-19.761801, -47.963522),
                      initialZoom: 12,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 40,
                            height: 40,
                            point: const LatLng(-19.765578, -47.956517),
                            child: const Icon(
                                Icons.location_on, color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Botão de conversa
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
                child: const Text("CONVERSAR COM UM AGRÔNOMO",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoText(String label, String value,
      {bool bold = false, bool link = false, Color? color}) {
    return RichText(
      text: TextSpan(
        text: "$label\n",
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: link ? Colors.blue : color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
