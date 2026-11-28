
import 'package:flutter/material.dart';
import '../widgets/login_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // =====================================
  // PROSES LOGIN (BELUM MENGGUNAKAN API)
  // =====================================
  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Login sebagai $username (belum terhubung ke server)',
          ),
        ),
      );
  }

  // =====================================
  // NAVIGASI REGISTER
  // =====================================
  void _register() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Halaman Register belum dibuat.'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // JUDUL HALAMAN
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          bottom: 14,
                        ),
                        child: Text(
                          'Login Page',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 22,
                          ),
                        ),
                      ),

                      // LOGIN CARD
                      SizedBox(
                        height: constraints.maxHeight < 882
                            ? 850
                            : constraints.maxHeight - 32,
                        child: LoginCard(
                          formKey: _formKey,
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          onLogin: _login,
                          onRegister: _register,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
