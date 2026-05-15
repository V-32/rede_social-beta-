//Vítor Gabriel Gaspar de Paula N°32 e Vítor Augusto Almeida Costa N°31
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
    
    
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); 

   
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
            
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.blur_on, 
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