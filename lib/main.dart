import 'package:easy_khata/landing/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_khata/util/shared_pref.dart';
import 'package:easy_khata/util/theme/theme.dart';
import 'package:easy_khata/util/theme/theme_provider.dart';

import 'database/drift_database/DatabaseDriftHelper.dart';
import 'firebase_options.dart';
import 'home/home_page.dart';
import 'package:easy_khata/util/Cosntant.dart';

import 'landing/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

Future<bool> initialInilization() async {
  await DatabaseDriftHelper.registerDatabase();
  return true;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return FutureBuilder(
        future: initialInilization(),
        builder: (context, value) {
          return MaterialApp(
            title: 'Easy Khata',
            debugShowCheckedModeBanner: false,
            theme: UdhariTheme.lightTheme,
            darkTheme: UdhariTheme.darkTheme,
            themeMode: theme,
            home: SharedPrefs.instance.getBool(Constant.isLogin) == true
                ? const HomePage(title: 'Easy Khata')
                : const LoginPage(),
          );
        });
  }
}
