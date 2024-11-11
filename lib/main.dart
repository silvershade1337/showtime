import 'package:flutter/material.dart';
import 'package:showtime/pages/home.dart';
import 'package:showtime/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowTime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 207, 0, 0),
          background: const Color.fromARGB(255, 29, 29, 29)
        ),
        useMaterial3: true,
      ),
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage()
      },
      initialRoute: "/splash",
    );
  }
}
