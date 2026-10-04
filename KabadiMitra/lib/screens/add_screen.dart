import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'estimate_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  MaterialId category = MaterialId.pcb;
  double kg = 4;
  late final TextEditingController weightCtrl;

  @override
  void initState() {
    super.initState();
    weightCtrl = TextEditingController(text: kg.toStringAsFixed(1));
  }

  @override
  void dispose() {
    weightCtrl.dispose();
    super.dispose();
  }

  void _setKg(double v) {
    final clamped = v.clamp(0.1, 500.0);
    setState(() {
      kg = clamped;
      weightCtrl.text = kg == kg.roundToDouble()
          ? kg.toStringAsFixed(0)
          : kg.toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      if (weightCtrl.text.isEmpty) weightCtrl.text = kg.toStringAsFixed(1);
    });
  }

  void _onWeightTyped(String raw) {
    final parsed = double.tryParse(raw.replaceAll(',', '.'));
    if (parsed == null) return;
    setState(() => kg = parsed.clamp(0.1, 500.0));
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    final row = rateFor(category);
    final value = (kg * row.ratePerKg).round();

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "addScrap"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "addScrap")),
          const SizedBox(height: 12),
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: ThemeX.surfaceAlt(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ThemeX.line(context)),
            ),
            child: Center(
              child: store.pendingPhoto != null
                  ? const Icon(Icons.check_circle, size: 48, color: AppColors.success)
                  : TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.camera_alt),
                      label: Text(I18n.t(lang, "openCamera")),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(I18n.t(lang, "pickType"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: materialOrder.map((id) {
              final on = id == category;
              return SelectChip(
                label: I18n.materialLabel(lang, id),
                selected: on,
                onTap: () => setState(() => category = id),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text(I18n.t(lang, "weight"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () => _setKg(kg - 0.5),
                icon: Icon(Icons.remove_circle_outline, color: ThemeX.ink(context)),
              ),
              Expanded(
                child: TextField(
                  controller: weightCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: ThemeX.ink(context),
                  ),
                  decoration: InputDecoration(
                    hintText: I18n.t(lang, "weightEnter"),
                    suffixText: I18n.t(lang, "kgUnit"),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onChanged: _onWeightTyped,
                  onEditingComplete: () {
                    final parsed = double.tryParse(weightCtrl.text.replaceAll(',', '.'));
                    if (parsed != null) {
                      _setKg(parsed);
                    } else {
                      _setKg(kg);
                    }
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              IconButton(
                onPressed: () => _setKg(kg + 0.5),
                icon: Icon(Icons.add_circle_outline, color: ThemeX.ink(context)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppCard(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t(lang, "estimate"), style: const TextStyle(color: Colors.white70)),
                Text(inr(value),
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800)),
                Text("${inr(row.ratePerKg)}${I18n.t(lang, "perKg")}",
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BigButton(
            label: I18n.t(lang, "save"),
            onPressed: () {
              final parsed = double.tryParse(weightCtrl.text.replaceAll(',', '.'));
              final finalKg = (parsed ?? kg).clamp(0.1, 500.0);
              final finalValue = (finalKg * row.ratePerKg).round();
              final lot = store.addLot(
                category: category,
                weightKg: finalKg,
                estimatedValue: finalValue.toDouble(),
                ratePerKg: row.ratePerKg,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => EstimateScreen(lotId: lot.id)),
              );
            },
          ),
        ],
      ),
    );
  }
}
