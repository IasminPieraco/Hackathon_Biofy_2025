import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:AgroVision/common/page_default.dart';
import 'package:AgroVision/screen/inicioF_page.dart';
import 'package:AgroVision/screen/inicioA_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



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
    final enderecoController = useTextEditingController();

    final formKey = GlobalKey<FormState>(); // Chave do Formulário

    return PageDefault(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            width: 320,
            child: Form(
              key: formKey, // Associando o formulário à chave
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'NOVO USUÁRIO',
                      style: TextStyle(
                        color: Colors.white,
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
                    validator: (value) {
                      if (value == null || value.trim().length < 3) {
                        return 'Nome deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo CPF
                  TextFormField(
                    controller: cpfController,
                    decoration: _inputDecoration('CPF'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.length != 11 || !RegExp(r'^\d+$').hasMatch(value)) {
                        return 'CPF deve ter 11 dígitos numéricos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Email
                  TextFormField(
                    controller: emailController,
                    decoration: _inputDecoration('Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Digite um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Senha
                  TextFormField(
                    controller: senhaController,
                    decoration: _inputDecoration('Senha'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Endereço
                  TextFormField(
                    controller: enderecoController,
                    decoration: _inputDecoration('Endereço'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O endereço não pode estar vazio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Telefone
                  TextFormField(
                    controller: telefoneController,
                    decoration: _inputDecoration('Telefone'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.length < 10 || !RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Telefone deve ter pelo menos 10 dígitos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Sou:',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  // Checkbox Agrônomo (se selecionar, desmarca Fazendeiro)
                  _buildCheckboxTile(
                    title: 'Agrônomo',
                    value: isAgronomo.value,
                    onChanged: (val) {
                      isAgronomo.value = val!;
                      if (val) isFazendeiro.value = false;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Checkbox Fazendeiro (se selecionar, desmarca Agrônomo)
                  _buildCheckboxTile(
                    title: 'Fazendeiro',
                    value: isFazendeiro.value,
                    onChanged: (val) {
                      isFazendeiro.value = val!;
                      if (val) isAgronomo.value = false;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Botão Cadastrar
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (!isAgronomo.value && !isFazendeiro.value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Selecione Agrônomo ou Fazendeiro')),
                          );
                          return;
                        }

                        // Pegamos os dados digitados
                        final newUser = {
                          'email': emailController.text,
                          'senha': senhaController.text,
                          'tipoUsuario': isAgronomo.value ? 'agronomo' : 'fazendeiro',
                          'nome': nameController.text,
                        };

                        // Pegamos os usuários já cadastrados
                        final prefs = await SharedPreferences.getInstance();
                        final String? usersString = prefs.getString('usuarios');
                        List<dynamic> users = usersString != null ? jsonDecode(usersString) : [];

                        // Adicionamos o novo usuário à lista
                        users.add(newUser);

                        // Salvamos a lista atualizada
                        await prefs.setString('usuarios', jsonEncode(users));
                        print("Usuário salvo: ${jsonEncode(users)}");


                        // Redirecionamos para a tela correta
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.black,
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
