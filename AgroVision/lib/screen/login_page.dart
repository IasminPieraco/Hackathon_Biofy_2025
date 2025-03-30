import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:AgroVision/common/page_default.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:AgroVision/screen/cadastro_page.dart';
import 'package:AgroVision/screen/inicioF_page.dart';
import 'package:AgroVision/screen/inicioA_page.dart';




// 1. Criamos um StateNotifier para gerenciar o estado do formulário
class LoginFormState {
  final String email;
  final String password;
  final bool obscurePassword;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

// 2. Criamos o StateNotifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
}

// 3. Criamos o Provider
final loginFormProvider =
StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

// 4. Página de Login usando HookConsumerWidget
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final state = ref.watch(loginFormProvider);
    final notifier = ref.read(loginFormProvider.notifier);

    return PageDefault(
      child: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de Email
                TextFormField(
                  initialValue: state.email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'exemplo@email.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: notifier.updateEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Digite um email válido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Campo de Senha
                TextFormField(
                  initialValue: state.password,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: notifier.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: state.obscurePassword,
                  onChanged: notifier.updatePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // Links "Esqueci minha senha" e "Não tenho cadastro"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CadastroPage()),
                        );
                      },
                      child: const Text(
                        'Não tenho cadastro',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 30),

                // Botão de Login
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text('Login realizado para ${state.email}'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text('Entrar'),
                ),

                const SizedBox(height: 20),

                // Botões Sociais
                _buildSocialLoginButton(
                  context,
                  icon: Icons.g_mobiledata,
                  label: 'Entrar com o Google',
                  textColor: Colors.black,
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  context,
                  icon: Icons.facebook,
                  label: 'Entrar com o Facebook',
                  textColor: Colors.blueAccent,
                ),

                const SizedBox(height: 30),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color textColor,
      }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // ação de login social
        },
        icon: Icon(icon, color: textColor),
        label: Text(label, style: TextStyle(color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
