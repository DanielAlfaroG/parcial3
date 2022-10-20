import 'package:flutter/material.dart';
import 'package:parcial3/paginas/Home.dart';

void main() {
  runApp(parcial3());
}

class parcial3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home()
    );
  }
}