import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String texto;
  final TextEditingController controller;
  const TextLabel({
    Key? key,
    required this.texto,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          label: Text(
        texto,
        style: const TextStyle(fontSize: 16),
      )),
    );
  }
}
