import 'package:flutter/material.dart';

Widget notificacao(double imc) {
  if (imc > 0.0 && imc < 16.0) {
    return const Text('Você está com magreza grave.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 16.0 && imc < 17.0) {
    return const Text('Você está com magreza moderada.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 17.0 && imc < 18.5) {
    return const Text('Você está com magreza leve.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 18.5 && imc < 25.0) {
    return const Text('Você está saudável.', style: TextStyle(fontSize: 25));
  } else if (imc >= 25.0 && imc < 30.0) {
    return const Text('Você está com sobrepeso.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 30.0 && imc < 35.0) {
    return const Text('Você está com obesidade I.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 35.0 && imc < 40.0) {
    return const Text('Você está com obesidade II.',
        style: TextStyle(fontSize: 25));
  } else if (imc >= 40.0) {
    return const Text('Você está com obesidade III.',
        style: TextStyle(fontSize: 25));
  } else {
    return const Text('Dados inválidos', style: TextStyle(fontSize: 25));
  }
}
