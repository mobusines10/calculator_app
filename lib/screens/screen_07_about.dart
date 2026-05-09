import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _openInstagram() async {
    final uri = Uri.parse('https://www.instagram.com/motexas10');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg, elevation: 0,
        leading: _back(context),
        title: const Text('About', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo with glow
            Container(
              width: 110, height: 110,
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppTheme.purple.withOpacity(0.6), width: 2),
                boxShadow: [
                  BoxShadow(color: AppTheme.purple.withOpacity(0.4), blurRadius: 40, spreadRadius: 5),
                ],
              ),
              child: const Icon(Icons.calculate_rounded, color: AppTheme.purple, size: 56),
            ),
            const SizedBox(height: 20),
            const Text('CALCIX',
                style: TextStyle(color: AppTheme.textPri, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 6)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.purple.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.purple.withOpacity(0.3)),
              ),
              child: const Text('Version 1.0.0',
                  style: TextStyle(color: AppTheme.purple, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 32),
            // Info cards
            _tile(Icons.school_rounded,  'Course',     'Android Programming'),
            const SizedBox(height: 8),
            _tile(Icons.person_rounded,  'Developer',  'Mohamed Elmohandis'),
            const SizedBox(height: 8),
            _tile(Icons.code_rounded,    'Built with', 'Flutter & Dart'),
            const SizedBox(height: 24),
            // Instagram button
            GestureDetector(
              onTap: _openInstagram,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF833AB4), Color(0xFFE1306C), Color(0xFFF77737)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFE1306C).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 6)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),child: const Center(
                      child: Text('ig', style: TextStyle(
                        color: Colors.white, fontSize: 16,
                        fontWeight: FontWeight.w900, fontStyle: FontStyle.italic,
                      )),
                    ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Follow on Instagram', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                        Text('@motexas10', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Made with ❤️ using Flutter',
                style: TextStyle(color: AppTheme.textSec, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _tile(IconData icon, String label, String value) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
        child: Row(children: [
          Icon(icon, color: AppTheme.purple, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppTheme.textSec, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(color: AppTheme.textPri, fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _back(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.border)),
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
    ),
  );
}