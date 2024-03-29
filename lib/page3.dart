import 'package:flutter/material.dart';
import 'package:flutter_application_3/data_provider.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});
  @override
  Widget build(BuildContext context) {
    var data = AppDataProvider.of(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${data?.personData.name}, вам ${data?.personData.age} лет',
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
