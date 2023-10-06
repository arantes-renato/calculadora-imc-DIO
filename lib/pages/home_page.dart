import 'package:calculadora_imc_2/repository/imc_repository.dart';
import 'package:calculadora_imc_2/services/notificacao.dart';
import 'package:calculadora_imc_2/shared/widgets/texto.dart';
import 'package:calculadora_imc_2/shared/widgets/imc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcReposistory = ImcRepository();
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  String dia = '';
  var _listaIMC = <Imc>[];
  double peso = 0.0;
  double altura = 0.0;
  double mediaIMC = 0.0;
  Widget mensagem = Container();

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  void obterIMC() {
    _listaIMC = imcReposistory.listarIMC();
    if (_listaIMC.length > 1) {
      mediaIMC =
          _listaIMC.map((imc) => imc.calcularIMC()).reduce((a, b) => a + b) /
              _listaIMC.length;
    } else {
      mediaIMC = 0.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pesoController.text = '';
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text(
                      'Informe o Peso(Kg) e Altura(cm):',
                      style: TextStyle(fontSize: 14),
                    ),
                    content: Wrap(children: [
                      TextLabel(
                        controller: pesoController,
                        texto: 'Peso(Kg)',
                      ),
                      TextLabel(
                        controller: alturaController,
                        texto: 'Altura(cm)',
                      ),
                    ]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar')),
                      TextButton(
                          onPressed: () {
                            peso = double.tryParse(
                                    pesoController.text.replaceAll(',', '.')) ??
                                0.0;
                            altura = double.tryParse(alturaController.text
                                    .replaceAll(',', '.')
                                    .replaceAll('.', '')) ??
                                0.0;
                            imcReposistory.adicionarIMC(Imc(altura, peso));
                            Navigator.of(context).pop();
                            obterIMC();
                          },
                          child: const Text('Salvar'))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add_outlined),
        ),
        appBar: AppBar(
            title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Calcular IMC 2.0'),
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Data',
                      textAlign: TextAlign.start,
                    )),
                    Expanded(
                        child: Text(
                      'Altura(m)',
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      'Peso(Kg)',
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      'IMC',
                      textAlign: TextAlign.end,
                    )),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: _listaIMC.length,
                            itemBuilder: (BuildContext bc, int index) {
                              var imc = _listaIMC[index];
                              return Dismissible(
                                onDismissed:
                                    (DismissDirection dismissDirection) {
                                  imcReposistory.removerrIMC(imc.id);
                                  obterIMC();
                                },
                                key: Key(imc.id),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          DateFormat.Md('pt_BR')
                                              .format(imc.dia),
                                          textAlign: TextAlign.start,
                                        )),
                                        Expanded(
                                            child: Text(
                                          '${(imc.altura / 100).toStringAsFixed(2)}m',
                                          textAlign: TextAlign.center,
                                        )),
                                        Expanded(
                                            child: Text(
                                          '${(imc.peso).toStringAsFixed(2)}Kg',
                                          textAlign: TextAlign.center,
                                        )),
                                        Expanded(
                                            child: Text(
                                          imc.calcularIMC().toStringAsFixed(2),
                                          textAlign: TextAlign.end,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mediaIMC <= 0.00 ? '' : 'Média IMC:',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          mediaIMC <= 0.00 ? '' : mediaIMC.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (mediaIMC > 0.00) Expanded(child: notificacao(mediaIMC))
                  ],
                )),
                const Card(
                  elevation: 8,
                  shadowColor: Colors.white30,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      children: [
                        Text('Tabela IMC.'),
                        Text(
                          'De 0 a 16.0: Magreza Grave.,\nDe 16.0 a 17.0: Magreza Moderada.\nDe 17 a 18.5: Magreza Leve.\nDe 18.5 a 25: Saudável.\nDe 25.0 a 30.0: Sobrepeso.\nDe 30.0 a 35.0: Obesidade I.\nDe 35.0 a 40.0: Obesidade II.\nAcima de 40.0: Obesidade III.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
