import 'package:flutter/material.dart';
import 'package:flutter_application_3/data_provider.dart';
import 'package:flutter_application_3/page3.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  SecondPageState createState() {
    return SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = AppDataProvider.of(context);
    return Form(
      key: _formKey2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              '${data?.personData.name}, добро пожаловать!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            'Укажите вашу дату рождения: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: const EdgeInsets.all(32),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: "Дата рождения"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, укажите вашу дату рождения';
                  }
                  var date = DateTime.parse(value);
                  if (getDiffY(date, DateTime.now()) < 14) {
                    return 'Возраст не может быть меньше 14 лет';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () {
                  _selectDate(context, _controller);
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                  var date = DateTime.parse(_controller.text);
                  var age = getDiffY(date, DateTime.now());
                  AppDataProvider.of(context)?.personData.changeAge(age);
                  _controller.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThirdPage()));
                }
              },
              child: const Text('Войти'),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _selectDate(
    BuildContext context, TextEditingController controller) async {
  DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2025));

  if (picked != null) {
    controller.text = picked.toString().split(" ")[0];
  } else {
    controller.text = "";
  }
}

int getDiffY(DateTime then, DateTime now) {
  int years = now.year - then.year;
  int months = now.month - then.month;
  int days = now.day - then.day;
  if (months < 0 || (months == 0 && days < 0)) {
    years--;
  }

  return years;
}
