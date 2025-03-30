import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:AgroVision/common/page_default.dart';
import 'package:AgroVision/screen/inicioF_page.dart';
import 'package:AgroVision/screen/inicioA_page.dart';



class CadastroPage extends HookConsumerWidget {
  const CadastroPage({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAgronomo = useState(false);
    final isFazendeiro = useState(false);
    final nameController = useTextEditingController();
    final cpfController = useTextEditingController();
    final emailController = useTextEditingController();
    final senhaController = useTextEditingController();
    final telefoneController = useTextEditingController();

    return PageDefault(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter, // Alinha o texto no topo e no centro
                  child: Text(
                    'NOVO USUARIO',
                    style: TextStyle(
                      color: Colors.white, // Branco
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Campo Nome
                TextFormField(
                  controller: nameController,
                  decoration: _inputDecoration('Nome'),
                ),

                const SizedBox(height: 16),

                // Campo CPF
                TextFormField(
                  controller: cpfController,
                  decoration: _inputDecoration('CPF'),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                //Campo email
                TextFormField(
                  controller: emailController,
                  decoration: _inputDecoration('Email'),
                ),
                const SizedBox(height: 16),


                //Campo senha
                TextFormField(
                  controller: senhaController,
                  decoration: _inputDecoration('Senha'),
                ),
                const SizedBox(height: 16),

                //Campo telefone
                TextFormField(
                  controller: telefoneController,
                  decoration: _inputDecoration('Telefone'),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Sou:',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),

                // Agrônomo
                _buildCheckboxTile(
                  title: 'Agrônomo',
                  value: isAgronomo.value,
                  onChanged: (val) => isAgronomo.value = val!,
                ),

                const SizedBox(height: 10),

                // Fazendeiro
                _buildCheckboxTile(
                  title: 'Fazendeiro',
                  value: isFazendeiro.value,
                  onChanged: (val) => isFazendeiro.value = val!,
                ),

                const SizedBox(height: 30),

                // Botão Cadastrar

                ElevatedButton(
                  onPressed: () {
                    if (isFazendeiro.value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => InicioFPage()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => InicioAPage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fundo branco
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Borda arredondada
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Tamanho do botão
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.black, // Texto preto
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffffffff),
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(30),
      ),
      child: CheckboxListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
