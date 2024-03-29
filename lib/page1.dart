import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/data_provider.dart';
import 'package:flutter_application_3/page2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var data = AppDataProvider.of(context);

    return Scaffold(
        body: Center(
            child: ListenableBuilder(
                listenable: data!.personData,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(32),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Информация о вас:\nИмя: ${data.personData.name ?? '(Имя)'}\nВозраст: ${data.personData.age ?? '(Возраст)'}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ))),
                      const Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            'Представьтесь:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const Padding(
                          padding: EdgeInsets.all(32), child: NameForm())
                    ],
                  );
                })));
  }
}

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
                return 'Пожалуйста, введите ваше имя';
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
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),
              LengthLimitingTextInputFormatter(30)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var name = _controller.text;
                  AppDataProvider.of(context)?.personData.changeName(name);

                  _controller.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Scaffold(body: SecondPage())));
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
}
