import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final String name;

  final int age;

  const ThirdPage({super.key, required this.name, required this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$name, вам $age лет',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: ElevatedButton(
                onPressed: () {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Вернуться на главную'),
              )),
        ],
      ),
    ));
  }
}
