import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _expr = '';
  String _result = '0';

  void _press(String k) {
    HapticFeedback.lightImpact();
    setState(() {
      if (k == 'AC')     { _expr = ''; _result = '0'; }
      else if (k == '⌫') { if (_expr.isNotEmpty) _expr = _expr.substring(0, _expr.length - 1); }
      else if (k == '=') { _calc(); }
      else { _expr += {'×': '×', '÷': '÷'}[k] ?? k; }
    });
  }

  void _calc() {
    try {
      var e = _expr.replaceAll('×', '*').replaceAll('÷', '/');
      final v = _parse(e);
      setState(() {
        _result = v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsPrecision(8).replaceAll(RegExp(r'0+$'), '');
        _expr = _result;
      });
    } catch (_) { setState(() => _result = 'Error'); }
  }

  double _parse(String s) {
    s = s.trim();
    for (int i = s.length - 1; i > 0; i--)
      if (s[i] == '+' || s[i] == '-')
        return _parse(s.substring(0, i)) + (s[i] == '+' ? 1 : -1) * _parse(s.substring(i + 1));
    for (int i = s.length - 1; i >= 0; i--)
      if (s[i] == '*' || s[i] == '/') {
        final l = _parse(s.substring(0, i)), r = _parse(s.substring(i + 1));
        return s[i] == '*' ? l * r : l / r;
      }
    return double.parse(s);
  }

  final _rows = [
    ['AC', '±',  '%',  '÷'],
    ['7',  '8',  '9',  '×'],
    ['4',  '5',  '6',  '-'],
    ['1',  '2',  '3',  '+'],
    ['0',  '.',  '⌫',  '='],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.bg,
        body: SafeArea(
          child: Column(
              children: [
          Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconBtn(Icons.grid_view_rounded, () => Navigator.pushNamed(context, '/settings')),
              const Text('CALCIX', style: TextStyle(color: AppTheme.textPri, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 4)),
              _iconBtn(Icons.history_rounded, () => Navigator.pushNamed(context, '/history')),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_expr.isEmpty ? '0' : _expr, style: const TextStyle(color: AppTheme.textSec, fontSize: 20), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text(_result, style: TextStyle(color: _result == 'Error' ? AppTheme.orange : AppTheme.cyan, fontSize: _result.length > 10 ? 32 : 48, fontWeight: FontWeight.w300)),
            ],
          ),
        ),
        // SCI button
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/scientific'),
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.purple.withOpacity(0.15),borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.purple.withOpacity(0.4)),
                    ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.functions_rounded, color: AppTheme.purple, size: 16),
                      SizedBox(width: 8),
                      Text('Scientific Calculator', style: TextStyle(color: AppTheme.purple, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
            ),
        ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: _rows.map((row) => Expanded(
                        child: Row(
                          children: row.map((k) => Expanded(
                            child: Padding(padding: const EdgeInsets.all(4), child: _key(k)),
                          )).toList(),
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ],
          ),
        ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 38, height: 38,
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.border)),
      child: Icon(icon, color: AppTheme.textSec, size: 18),
    ),
  );

  Widget _key(String k) {
    Color bg, fg; double fs = 22;
    if (k == '=')                           { bg = AppTheme.purple; fg = Colors.white; }
    else if (k == 'AC')                     { bg = AppTheme.orange; fg = Colors.white; }
    else if (['+','-','×','÷'].contains(k)) { bg = AppTheme.surface; fg = AppTheme.cyan; fs = 24; }
    else if (['±','%','⌫'].contains(k))     { bg = AppTheme.surface; fg = AppTheme.textSec; }
    else                                    { bg = AppTheme.card; fg = AppTheme.textPri; }

    return GestureDetector(
      onTap: () => _press(k),
      child: Container(
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.border)),
        child: Center(
          child: k == '⌫'
              ? Icon(Icons.backspace_outlined, color: fg, size: 20)
              : Text(k, style: TextStyle(color: fg, fontSize: fs)),
        ),
      ),
    );
  }
}