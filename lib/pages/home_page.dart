import 'package:calculadora_imc/services/notificacao.dart';
import 'package:calculadora_imc/services/pessoa.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Pessoa _pessoa = Pessoa();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 52, 1, 146),
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Column(children: [
              const Icon(
                Icons.calculate,
                size: 150,
                color: Color.fromARGB(255, 83, 46, 152),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
              ),
              TextField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura (cm)'),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _pessoa.setNome(_nomeController.text);
                    _pessoa
                        .setPeso(double.tryParse(_pesoController.text) ?? 0.0);
                    _pessoa.setAltura(
                        double.tryParse(_alturaController.text) ?? 0.0);
                    double imc = _pessoa.calcularIMC();
                    Widget mensagem = notificacao(imc);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(child: Text('Resultado do IMC')),
                          content: SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (imc == 0.0) mensagem,
                                if (_pessoa.getNome() == '')
                                  Text(
                                    'Seu IMC é: ${imc.toStringAsFixed(2)}.',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                if (imc != 0.0 && _pessoa.getNome() != '')
                                  Text(
                                    '${_pessoa.getNome().toUpperCase()}, seu IMC é: ${imc.toStringAsFixed(2)}.',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                if (imc != 0.0)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (imc != 0.0) mensagem,
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _nomeController.clear();
                                  _pesoController.clear();
                                  _alturaController.clear();
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Calcular IMC'),
                ),
              )
            ])));
  }
}
