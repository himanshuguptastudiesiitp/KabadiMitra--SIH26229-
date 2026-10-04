import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "settings"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "settings")),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t(lang, "language"), style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _LangBtn(Lang.hi, "हिंदी", store),
                    const SizedBox(width: 8),
                    _LangBtn(Lang.mr, "मराठी", store),
                    const SizedBox(width: 8),
                    _LangBtn(Lang.en, "English", store),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(I18n.t(lang, "voice"), style: const TextStyle(fontWeight: FontWeight.w800)),
                Switch(
                  value: store.voiceOn,
                  activeThumbColor: AppColors.primary,
                  onChanged: store.setVoiceOn,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Row(
              children: [
                Icon(
                  store.darkMode ? Icons.dark_mode : Icons.light_mode,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(I18n.t(lang, "themeTitle"), style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text(
                        store.darkMode ? I18n.t(lang, "darkTheme") : I18n.t(lang, "defaultTheme"),
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: store.darkMode,
                  activeThumbColor: AppColors.primary,
                  onChanged: store.setDarkMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LangBtn extends StatelessWidget {
  final Lang lang;
  final String label;
  final AppStore store;
  const _LangBtn(this.lang, this.label, this.store);

  @override
  Widget build(BuildContext context) {
    final on = store.language == lang;
    return SelectChip(
      label: label,
      selected: on,
      expanded: true,
      onTap: () => store.setLanguage(lang),
    );
  }
}
