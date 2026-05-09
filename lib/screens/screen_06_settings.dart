import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg, elevation: 0,
        leading: _back(context),
        title: const Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('General', style: TextStyle(color: AppTheme.purple, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            _navTile(context, Icons.calculate_rounded,     'Basic Calculator',     '/home'),
            const SizedBox(height: 8),
            _navTile(context, Icons.functions_rounded,     'Scientific Calculator','/scientific'),
            const SizedBox(height: 8),
            _navTile(context, Icons.swap_horiz_rounded,    'Unit Converter',       '/unit-converter'),
            const SizedBox(height: 8),
            _navTile(context, Icons.history_rounded,       'History',              '/history'),
            const SizedBox(height: 16),
            const Text('App', style: TextStyle(color: AppTheme.purple, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            _navTile(context, Icons.info_outline_rounded,  'About',                '/about'),
            const SizedBox(height: 8),
            _navTile(context, Icons.help_outline_rounded,  'Help',                 '/help'),
          ],
        ),
      ),
    );
  }

  Widget _navTile(BuildContext context, IconData icon, String title, String route) =>
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
          child: Row(children: [
            Icon(icon, color: AppTheme.purple, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(color: AppTheme.textPri, fontSize: 15))),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.textSec, size: 14),
          ]),
        ),
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