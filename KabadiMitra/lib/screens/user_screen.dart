import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'settings_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    final paid = store.lots
        .where((l) => l.paymentStatus == PaymentStatus.paid)
        .fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.t(lang, "userPage")),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Text(
                store.displayName.isNotEmpty ? store.displayName[0].toUpperCase() : "R",
                style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            store.displayName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            store.role == UserRole.collector
                ? I18n.t(lang, "roleCollector")
                : store.role == UserRole.recycler
                    ? I18n.t(lang, "roleRecycler")
                    : I18n.t(lang, "roleAdmin"),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text(
                        "${store.lots.length}",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                      ),
                      Text(I18n.t(lang, "lots"), style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text(
                        inr(paid),
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      Text(I18n.t(lang, "earnings"), style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
