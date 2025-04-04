import 'package:flutter/material.dart';
import 'package:AgroVision/common/page_default.dart';
import 'Informacoes_lote_page.dart';
import 'banco_Imagens_page.dart';
import 'chat_page.dart';

class InicioAPage extends StatelessWidget {
  const InicioAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageDefault(child:  Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'SEJA BEM-VINDO, AGRÔNOMO!',
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
                label: 'Chat com Fazendeiro',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildButton(
                icon: Icons.image,
                label: 'Banco de Imagens',
                  onPressed: () {
                   Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => const BancoDeImagensPage()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildButton(
                icon: Icons.map,
                label: 'Informações do Lote',
                  onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapaLotePage()),
                );
               }
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
