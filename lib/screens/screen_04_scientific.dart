import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../core/theme/app_theme.dart';

class ScientificScreen extends StatefulWidget {
  const ScientificScreen({super.key});

  @override
  State<ScientificScreen> createState() => _ScientificScreenState();
}

class _ScientificScreenState extends State<ScientificScreen> {
  String _expr = '';
  String _result = '0';
  bool _isDeg = true;
  final _rows = [
    ['sin', 'cos', 'tan', 'ln',  'log'],
    ['√',   'x²',  'xʸ',  'π',   'e'  ],
    ['(',   ')',   'n!',  'AC',  '⌫'  ],
    ['7',   '8',   '9',   '÷',   '×'  ],
    ['4',   '5',   '6',   '+',   '-'  ],
    ['1',   '2',   '3',   '0',   '='  ],
  ];
  void _press(String k) {
    HapticFeedback.lightImpact();
    setState(() {
      if (k == 'AC')     { _expr = ''; _result = '0'; }
      else if (k == '⌫') { if (_expr.isNotEmpty) _expr = _expr.substring(0, _expr.length - 1); }
      else if (k == '=') { _calc(); }
      else {
        final t = {'×':'×','÷':'÷','sin':'sin(','cos':'cos(','tan':'tan(','ln':'ln(','log':'log(','√':'sqrt(','x²':'^2)','xʸ':'^','π':'π','e':'e','n!':'!'};
        _expr += t[k] ?? k;
      }
    });
  }

  void _calc() {
    try {
      double toRad(double d) => _isDeg ? d * math.pi / 180 : d;
      var e = _expr.replaceAll('×','*').replaceAll('÷','/').replaceAll('π','${math.pi}').replaceAll('e','${math.e}');
      e = e.replaceAllMapped(RegExp(r'sin\(([^)]+)\)'), (m) => '${math.sin(toRad(double.parse(m[1]!)))}');
      e = e.replaceAllMapped(RegExp(r'cos\(([^)]+)\)'), (m) => '${math.cos(toRad(double.parse(m[1]!)))}');
      e = e.replaceAllMapped(RegExp(r'tan\(([^)]+)\)'), (m) => '${math.tan(toRad(double.parse(m[1]!)))}');
      e = e.replaceAllMapped(RegExp(r'sqrt\(([^)]+)\)'), (m) => '${math.sqrt(double.parse(m[1]!))}');
      e = e.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), (m) => '${math.log(double.parse(m[1]!))}');
      e = e.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (m) => '${math.log(double.parse(m[1]!)) / math.ln10}');
      e = e.replaceAllMapped(RegExp(r'([\d.]+)\^([\-]?[\d.]+)'), (m) => '${math.pow(double.parse(m[1]!), double.parse(m[2]!))}');
      e = e.replaceAllMapped(RegExp(r'(\d+)!'), (m) => '${_fact(int.parse(m[1]!))}');
      final v = _parse(e);
      setState(() {
        _result = v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsPrecision(8).replaceAll(RegExp(r'0+$'), '');
        _expr = _result;
      });
    } catch (_) { setState(() => _result = 'Error'); }
  }

  double _fact(int n) => n <= 1 ? 1 : n * _fact(n - 1);

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
    if (s.startsWith('(') && s.endsWith(')')) return _parse(s.substring(1, s.length - 1));
    return double.parse(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.bg,
        appBar: AppBar(
            backgroundColor: AppTheme.bg,
            elevation: 0,
            leading: _back(context),
            title: const Text('Scientific', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            actions: [
            GestureDetector(
            onTap: () => setState(() => _isDeg = !_isDeg),
    child: Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
    color: AppTheme.cyan.withOpacity(0.15),borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppTheme.cyan.withOpacity(0.3)),
    ),
      child: Text(_isDeg ? 'DEG' : 'RAD', style: const TextStyle(color: AppTheme.cyan, fontSize: 12, fontWeight: FontWeight.w700)),
    ),
            ),
            ],
        ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_expr.isEmpty ? '0' : _expr, style: const TextStyle(color: AppTheme.textSec, fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(_result, style: TextStyle(color: AppTheme.textPri, fontSize: _result.length > 10 ? 28 : 40, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                children: _rows.map((row) => Expanded(
                  child: Row(
                    children: row.map((k) => Expanded(
                      child: Padding(padding: const EdgeInsets.all(3), child: _key(k)),
                    )).toList(),
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _key(String k) {
    Color bg, fg; double fs = 15;
    if (k == '=')                              { bg = AppTheme.purple; fg = Colors.white; fs = 20; }
    else if (k == 'AC')                        { bg = AppTheme.orange; fg = Colors.white; }
    else if (['+','-','×','÷'].contains(k))    { bg = AppTheme.surface; fg = AppTheme.cyan; fs = 20; }
    else if (['sin','cos','tan','ln','log','√','x²','xʸ','n!','π','e'].contains(k)) { bg = AppTheme.surface; fg = AppTheme.purple; }
    else                                       { bg = AppTheme.card; fg = AppTheme.textPri; fs = 18; }

    return GestureDetector(
      onTap: () => _press(k),
      child: Container(
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.border)),
        child: Center(
          child: k == '⌫'
              ? Icon(Icons.backspace_outlined, color: AppTheme.textSec, size: 16)
              : Text(k, style: TextStyle(color: fg, fontSize: fs, fontWeight: FontWeight.w500)),
        ),
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