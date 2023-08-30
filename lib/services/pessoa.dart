class Pessoa {
  String _nome = "";
  double _peso = 0.0;
  double _altura = 0.0;

  void setNome(String nome) {
    _nome = nome;
  }

  String getNome() {
    return _nome;
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  double getPeso() {
    return _peso;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  double getAltura() {
    return _altura;
  }

  double calcularIMC() {
    if (_altura > 0 && _peso > 0) {
      return _peso / ((_altura / 100) * (_altura / 100));
    } else {
      return 0.0;
    }
  }
}
