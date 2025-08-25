import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/presentation/add_screen/add_screen.dart';
import 'package:novi_test/presentation/auth/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AppController();
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
