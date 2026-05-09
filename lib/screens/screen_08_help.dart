import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg, elevation: 0,
        leading: _back(context),
        title: const Text('Help', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _HelpTile('Basic Calculator', 'Use + − × ÷ for math. AC to clear, ⌫ to delete.'),
          _HelpTile('Scientific', 'Use sin, cos, tan, log, √ and more.'),
          _HelpTile('Unit Converter', 'Convert Length, Weight and Temperature.'),
          _HelpTile('History', 'View your past calculations.'),
          _HelpTile('DEG / RAD', 'Toggle between Degrees and Radians.'),
        ],
      ),
    );
  }

  Widget _back(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.border)),
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
    ),
  );
}

class _HelpTile extends StatelessWidget {
  final String title, desc;
  const _HelpTile(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppTheme.textPri, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: AppTheme.textSec, fontSize: 13)),
        ],
      ),
    );
  }
}