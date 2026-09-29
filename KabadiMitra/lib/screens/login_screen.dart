import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'onboarding_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;
  bool busy = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    final store = context.read<AppStore>();
    if (!emailCtrl.text.contains("@")) {
      setState(() => error = "Valid email required");
      return;
    }
    if (passCtrl.text.length < 4) {
      setState(() => error = "Password too short");
      return;
    }
    setState(() {
      busy = true;
      error = null;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => busy = false);
      store.seedDemo();
      if (!store.onboardingDone) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      } else {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  void _skip() {
    final store = context.read<AppStore>();
    store.seedDemo();
    store.completeOnboarding();
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _LangChip(
                        label: "हिंदी",
                        selected: store.language == Lang.hi,
                        onTap: () => store.setLanguage(Lang.hi),
                      ),
                      const SizedBox(width: 8),
                      _LangChip(
                        label: "English",
                        selected: store.language == Lang.en,
                        onTap: () => store.setLanguage(Lang.en),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: store.isDark ? "Default theme" : "Dark theme",
                  onPressed: store.toggleTheme,
                  icon: Icon(
                    store.isDark ? Icons.light_mode : Icons.dark_mode,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Icon(Icons.recycling, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              I18n.t(lang, "appName"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              I18n.t(lang, "login"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              I18n.t(lang, "loginSub"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: I18n.t(lang, "email"),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: I18n.t(lang, "password"),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error!,
                style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 20),
            BigButton(
              label: busy ? I18n.t(lang, "working") : I18n.t(lang, "loginGo"),
              onPressed: busy ? null : _login,
            ),
            const SizedBox(height: 12),
            BigButton(
              label: I18n.t(lang, "newAccount"),
              primary: false,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _skip,
              child: const Text("Skip (demo)", style: TextStyle(color: AppColors.muted)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  store.isDark ? "Dark" : "Default",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                Switch(
                  value: store.isDark,
                  activeThumbColor: AppColors.primary,
                  onChanged: store.setDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
