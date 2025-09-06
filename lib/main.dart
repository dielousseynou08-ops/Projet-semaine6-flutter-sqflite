import 'package:flutter/material.dart';
import 'package:myquicknotes/authentification/connexion.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Quick Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF5CAFE7)),
      home: LoginScreen(),
    );
  }
}
