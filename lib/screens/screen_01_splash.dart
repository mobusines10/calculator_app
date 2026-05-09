import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080810),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF14141F),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF6C5CE7).withOpacity(0.5)),
              ),
              child: const Icon(Icons.calculate_rounded,
                  color: Color(0xFF6C5CE7), size: 48),
            ),
            const SizedBox(height: 20),
            const Text('CALCIX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5)),
            const SizedBox(height: 8),
            const Text('Smart Calculator',
                style: TextStyle(color: Color(0xFF7070A0), fontSize: 14)),
          ],
        ),
      ),
    );
  }
}