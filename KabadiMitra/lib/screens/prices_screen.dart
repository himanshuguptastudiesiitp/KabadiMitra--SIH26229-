import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppStore>().language;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "priceBoard"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "priceBoard"), sub: I18n.t(lang, "nagpur")),
          const SizedBox(height: 12),
          ...priceBoard.map((row) {
            final up = row.trend.last >= row.trend.first;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.category, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(I18n.materialLabel(lang, row.category),
                              style: const TextStyle(fontWeight: FontWeight.w800)),
                          Text("${inr(row.low)}–${inr(row.high)} · ${I18n.t(lang, "perKg")}",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(inr(row.ratePerKg),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                        Icon(up ? Icons.trending_up : Icons.trending_down,
                            size: 18, color: up ? AppColors.success : AppColors.danger),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
