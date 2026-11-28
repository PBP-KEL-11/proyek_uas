
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final bool isLoading;

  const LoginCard({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.onRegister,
    this.isLoading = false,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _obscurePassword = true;

  static const Color darkGreen = Color(0xFF2F6B3A);
  static const Color textColor = Color(0xFF365C54);
  static const Color brownColor = Color(0xFFAD8065);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        return ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Stack(
            children: [
              // =====================================
              // BACKGROUND UTAMA
              // =====================================
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFDDF2D8), // Hijau mint terang
                        Color(0xFFB6D4B9), // Hijau sage
                        Color(0xFFD5EED2), // Hijau mint lembut
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // =====================================
              // BACKGROUND FOTO DENGAN LENGKUNGAN
              // =====================================
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height * 0.43,
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/background_img_auth.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF345C4B),
                                  Color(0xFF789D81),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          );
                        },
                      ),

                      // Overlay gelap
                      Container(
                        color: Colors.black.withOpacity(0.42),
                      ),
                    ],
                  ),
                ),
              ),

              // =====================================
              // JUDUL DAN SUBJUDUL
              // =====================================
              Positioned(
                top: height * 0.065,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Masuk Akun',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Selamat datang kembali di Tanamin.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================
              // LOGO TANAMAN
              // =====================================
              Positioned(
                top: height * 0.305,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_tanamin.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // =====================================
              // FORM LOGIN
              // =====================================
              Positioned(
                top: height * 0.56,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // USERNAME
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: widget.usernameController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: textColor,
                          ),
                          decoration: _inputDecoration(
                            hint: 'Masukkan Username',
                            icon: Icons.person_outline,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Username tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        // PASSWORD
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: widget.passwordController,
                          obscureText: _obscurePassword,
                          onFieldSubmitted: (_) {
                            widget.onLogin();
                          },
                          style: const TextStyle(
                            color: textColor,
                          ),
                          decoration: _inputDecoration(
                            hint: 'Masukkan Password',
                            icon: Icons.lock_outline,
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: textColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 50),

                        // TOMBOL LOGIN
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: widget.isLoading
                                ? null
                                : widget.onLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: widget.isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // LINK REGISTER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum memiliki akun?',
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),

                            TextButton(
                              onPressed: widget.onRegister,
                              style: TextButton.styleFrom(
                                foregroundColor: textColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================
  // DECORATION INPUT FIELD
  // =====================================
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: brownColor,
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.black87,
      ),
      filled: true,
      fillColor: const Color(0xFFE6E0D5).withOpacity(0.85),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: brownColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: brownColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: darkGreen,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }
}

// =====================================
// CUSTOM CLIPPER UNTUK LENGKUNGAN FOTO
// =====================================
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.72);

    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.15,
      size.width,
      size.height * 0.72,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
