import 'dart:async';
import 'package:flutter/material.dart';
import 'perfil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    // Configura a rotação lenta (3 segundos por volta completa)
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Faz girar continuamente

    // Timer para mudar de tela após 4 segundos
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PerfilPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animação de Rotação
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.blur_on, // Ícone que simula a logo do FreeLogo Design
                size: 100,
                color: Color(0xFF9C27B0),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Carregando...",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 1.2,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}