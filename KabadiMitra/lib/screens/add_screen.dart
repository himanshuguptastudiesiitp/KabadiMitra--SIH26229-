import 'package:flutter/material.dart';
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
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(12),
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
              return ChoiceChip(
                label: Text(I18n.materialLabel(lang, id)),
                selected: on,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: on ? Colors.white : AppColors.ink,
                  fontWeight: FontWeight.w600,
                ),
                onSelected: (_) => setState(() => category = id),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text(I18n.t(lang, "weight"), style: Theme.of(context).textTheme.titleLarge),
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => kg = (kg - 0.5).clamp(0.5, 500)),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                "${kg.toStringAsFixed(1)} kg",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              IconButton(
                onPressed: () => setState(() => kg = (kg + 0.5).clamp(0.5, 500)),
                icon: const Icon(Icons.add_circle_outline),
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
                Text(
                  inr(value),
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),
                ),
                Text(
                  "${inr(row.ratePerKg)}${I18n.t(lang, "perKg")}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BigButton(
            label: I18n.t(lang, "save"),
            onPressed: () {
              final lot = store.addLot(
                category: category,
                weightKg: kg,
                estimatedValue: value.toDouble(),
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
