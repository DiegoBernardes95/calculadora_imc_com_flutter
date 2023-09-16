import 'package:calculadora_imc/pages/calculadora_imc_pages.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const CalculadoraIMC());
}

class CalculadoraIMC extends StatelessWidget {
  const CalculadoraIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculadoraImcPages(),
    );
  }
}