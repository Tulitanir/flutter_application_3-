import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameForm extends StatefulWidget {
  const NameForm({super.key});

  @override
  NameFormState createState() {
    return NameFormState();
  }
}

class NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите важе имя';
              }
              return null;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Введите ваше имя",
                labelText: "Ваше имя",
                suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(Icons.clear))),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]")),
              LengthLimitingTextInputFormatter(30)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Войти'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void doSmth() {}
}
