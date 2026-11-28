import 'package:flutter/material.dart';
import 'package:proyek_uas/authentication/screens/login_screen.dart';

// Pintu masuk khusus untuk menguji halaman authentication.
// Jalankan dengan: flutter run -d chrome -t lib/main_auth.dart
void main() {
  runApp(const AuthPreviewApp());
}

class AuthPreviewApp extends StatelessWidget {
  const AuthPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
