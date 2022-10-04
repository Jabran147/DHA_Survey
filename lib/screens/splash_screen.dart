import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import './login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/img/dha_lahore_logo.png'),
      title: const Text(
        'DHA Maintenance',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      loaderColor: const Color(0xFF0F0A38),
      logoWidth: 80,
      loadingText: const Text('Powered By PITB'),
      navigator: LoginScreen(),
      durationInSeconds: 3,
    );
  }
}
