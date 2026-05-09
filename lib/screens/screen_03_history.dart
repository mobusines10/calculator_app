import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, String>> _items = [
    {'expr': '9 × 9',     'result': '81'},
    {'expr': '125 + 375', 'result': '500'},
    {'expr': '√144',      'result': '12'},
    {'expr': '2 ^ 10',    'result': '1024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg,
        elevation: 0,
        leading: _back(context),
        title: const Text('History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        actions: [
          GestureDetector(
            onTap: () => setState(() => _items.clear()),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.orange.withOpacity(0.3)),
              ),
              child: const Text('Clear', style: TextStyle(color: AppTheme.orange, fontSize: 13)),
            ),
          ),
        ],
      ),
      body: _items.isEmpty
          ? Center(child: Text('No history yet', style: TextStyle(color: AppTheme.textSec)))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, i) {
          final item = _items[_items.length - 1 - i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['expr']!, style: const TextStyle(color: AppTheme.textSec, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(item['result']!, style: const TextStyle(color: AppTheme.textPri, fontSize: 26, fontWeight: FontWeight.w300)),
                  ],
                ),
                const Icon(Icons.north_west_rounded, color: AppTheme.purple, size: 18),
              ],
            ),
          );
        },
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