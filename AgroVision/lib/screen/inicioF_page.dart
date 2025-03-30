import 'package:AgroVision/screen/chat_page.dart';
import 'package:AgroVision/screen/tirar_fotoF_page.dart';
import 'package:flutter/material.dart';
import 'package:AgroVision/common/page_default.dart';

import 'loc_mapa_page.dart';

class InicioFPage extends StatelessWidget {
  const InicioFPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageDefault(child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'SEJA BEM-VINDO, FAZENDEIRO!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Aqui estão nossas principais ferramentas:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              _buildButton(
                icon: Icons.chat,
                label: 'Chat com Agrônomo',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildButton(
                icon: Icons.camera_alt,
                label: 'Monitoramento por câmera',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TirarFotoFPage()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildButton(
                  icon: Icons.map,
                  label: 'Localização do Lote',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetalhesLotePage()),
                  );
                },
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

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
