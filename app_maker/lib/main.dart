import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AppMaker());
}

class AppMaker extends StatelessWidget {
  const AppMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Maker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
