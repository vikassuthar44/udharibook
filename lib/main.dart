
import 'package:flutter/material.dart';

import 'database/drift_database/DatabaseDriftHelper.dart';
import 'home/home_page.dart';

void main() {
  /*if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  if (kIsWeb) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfiWeb;
  }*/
  runApp(const MyApp());
}

Future<bool> initialInilization() async {
  await DatabaseDriftHelper.registerDatabase();
  return true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialInilization(),
        builder: (context, value) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomePage(title: 'Udhari Book'),
          );
        });
  }
}
