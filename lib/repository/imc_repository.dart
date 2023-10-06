import 'package:calculadora_imc_2/shared/widgets/imc.dart';

class ImcRepository {
  final List<Imc> _imc = [];

  void adicionarIMC(Imc imc) {
    _imc.add(imc);
  }

  void removerrIMC(String id) {
    _imc.remove(_imc.where((imc) => imc.id == id).first);
  }

  List<Imc> listarIMC() {
    return _imc;
  }
}
