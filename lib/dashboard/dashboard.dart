import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul Dashboard'),
      ),
      body: const Center(
        child: Text('Modul Dashboard untuk aplikasi Tanamin'),
      ),
    );
  }
}