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
  String? errorKey;
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
      setState(() => errorKey = "validEmail");
      return;
    }
    if (passCtrl.text.length < 4) {
      setState(() => errorKey = "passwordShort");
      return;
    }
    setState(() {
      busy = true;
      errorKey = null;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => busy = false);
      store.seedDemo();
      if (!store.onboardingDone) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
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
        child: Column(
          children: [
            // Top-right theme icon only
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                tooltip: store.darkMode ? "Light" : "Dark",
                onPressed: store.toggleDarkMode,
                icon: Icon(
                  store.darkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  const SizedBox(height: 8),
                  Icon(Icons.recycling, size: 48, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text(I18n.t(lang, "appName"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(I18n.t(lang, "login"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text(I18n.t(lang, "loginSub"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
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
                  if (errorKey != null) ...[
                    const SizedBox(height: 8),
                    Text(I18n.t(lang, errorKey!),
                        style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
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
                        context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _skip,
                    child: Text(I18n.t(lang, "skipDemo"),
                        style: const TextStyle(color: AppColors.muted)),
                  ),
                  const SizedBox(height: 8),
                  Text(I18n.t(lang, "language"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _LoginLang(Lang.hi, "हिंदी"),
                      const SizedBox(width: 8),
                      _LoginLang(Lang.mr, "मराठी"),
                      const SizedBox(width: 8),
                      _LoginLang(Lang.en, "English"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginLang extends StatelessWidget {
  final Lang lang;
  final String label;
  const _LoginLang(this.lang, this.label);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final on = store.language == lang;
    return SelectChip(
      label: label,
      selected: on,
      expanded: true,
      onTap: () => store.setLanguage(lang),
    );
  }
}
