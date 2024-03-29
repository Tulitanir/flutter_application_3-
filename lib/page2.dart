import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String name;
  const SecondPage({super.key, required this.name});

  @override
  SecondPageState createState() {
    return SecondPageState(name);
  }
}

class SecondPageState extends State<SecondPage> {
  final String name;
  int age = 0;

  final TextEditingController _textEditingController = TextEditingController();

  SecondPageState(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              '$name, добро пожаловать!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            'Укажите вашу дату рождения: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: "Дата рождения"),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              )),
        ],
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2025));

    if (_picked != null) {
      _textEditingController.text = _picked.toString().split(" ")[0];
    }
  }
}
