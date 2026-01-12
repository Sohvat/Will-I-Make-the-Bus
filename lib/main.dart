import 'package:flutter/material.dart';
import 'bus_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const BusApp(),
    );
  }
}

