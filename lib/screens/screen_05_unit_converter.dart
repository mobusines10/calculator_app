import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final _ctrl = TextEditingController();
  String _from = 'Meter';
  String _to = 'Kilometer';
  String _result = '';

  final _units = {'Meter': 1.0, 'Kilometer': 0.001, 'Mile': 0.000621, 'Foot': 3.281};

  void _convert() {
    final v = double.tryParse(_ctrl.text);
    if (v == null) return;
    final res = v / _units[_from]! * _units[_to]!;
    setState(() => _result = res.toStringAsPrecision(6).replaceAll(RegExp(r'0+$'), ''));
  }

  @override
  Widget build(BuildContext context) {
    final keys = _units.keys.toList();
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg, elevation: 0,
        leading: _back(context),
        title: const Text('Unit Converter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _dropdown('From', keys, _from, (v) => setState(() { _from = v!; _convert(); })),
            const SizedBox(height: 12),
            _dropdown('To', keys, _to, (v) => setState(() { _to = v!; _convert(); })),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
              child: TextField(
                controller: _ctrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: AppTheme.textPri, fontSize: 24),
                decoration: const InputDecoration(hintText: 'Enter value', border: InputBorder.none),
                onChanged: (_) => _convert(),
              ),
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.cyan.withOpacity(0.3))),
                child: Column(children: [
                  const Text('Result', style: TextStyle(color: AppTheme.textSec)),
                  const SizedBox(height: 8),
                  Text(_result, style: const TextStyle(color: AppTheme.cyan, fontSize: 40, fontWeight: FontWeight.w300)),
                  Text(_to, style: const TextStyle(color: AppTheme.textSec)),
                ]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> items, String val, void Function(String?) onChange) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
        child: DropdownButton<String>(
          value: val, isExpanded: true, underline: const SizedBox(),
          dropdownColor: AppTheme.card,
          style: const TextStyle(color: AppTheme.textPri, fontSize: 16),
          items: items.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
          onChanged: onChange,
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