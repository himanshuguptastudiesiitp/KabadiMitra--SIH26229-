import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'onboarding_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _register() {
    final store = context.read<AppStore>();
    if (nameCtrl.text.trim().isNotEmpty) {
      store.setDisplayName(nameCtrl.text.trim());
    }
    store.seedDemo();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppStore>().language;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "register"))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ScreenTitle(title: I18n.t(lang, "register"), sub: I18n.t(lang, "loginSub")),
          const SizedBox(height: 20),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
              labelText: I18n.t(lang, "name"),
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 12),
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
          const SizedBox(height: 24),
          BigButton(label: I18n.t(lang, "newAccount"), onPressed: _register),
        ],
      ),
    );
  }
}
