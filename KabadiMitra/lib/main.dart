import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_store.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_screen.dart';
import 'models/types.dart';
import 'utils/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KabadiwalaApp());
}

class KabadiwalaApp extends StatelessWidget {
  const KabadiwalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStore()..seedDemo(),
      child: Consumer<AppStore>(
        builder: (context, store, _) {
          return MaterialApp(
            title: 'Kabadi Mitra',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: store.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const LoginScreen(),
            routes: {
              "/home": (_) => const MainShell(),
            },
          );
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final isAdmin = store.role == UserRole.admin;

    final pages = isAdmin
        ? const [HomeScreen(), AdminScreen()]
        : const [HomeScreen()];

    return Scaffold(
      body: pages[index.clamp(0, pages.length - 1)],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: I18n.t(store.language, "home"),
          ),
          if (isAdmin)
            NavigationDestination(
              icon: const Icon(Icons.admin_panel_settings_outlined),
              selectedIcon: const Icon(Icons.admin_panel_settings),
              label: I18n.t(store.language, "adminDesk"),
            ),
        ],
      ),
    );
  }
}
