// lib/main.dart

import 'package:flutter/material.dart';
// HomePage’in olduğu dosyayı doğru path ile import et.
// Eğer HomePage’i lib/src/home/home_page.dart içinde oluşturduysan:
import 'src/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // DEBUG banner’ı kaldırır
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          elevation: 0,
        ),
      ),
      // Burada HomePage sınıfını çağırıyoruz:
      home: const HomePage(),
    );
  }
}
