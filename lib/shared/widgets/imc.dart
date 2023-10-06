import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  double _altura = 0.0;
  double _peso = 0.0;
  final DateTime _data = DateTime.now();

  Imc(this._altura, this._peso);

  String get id => _id;

  DateTime get dia => _data;

  set peso(double peso) {
    _peso = peso;
  }

  double get peso => _peso;

  set altura(double altura) {
    _altura = altura;
  }

  double get altura => _altura;

  double calcularIMC() {
    if (_altura > 0 && _peso > 0 && (_altura / 100) > 1.000) {
      return _peso / ((_altura / 100) * (_altura / 100));
    } else {
      return 0.0;
    }
  }
  
}
