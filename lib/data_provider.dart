import 'package:flutter/material.dart';

class AppDataProvider extends InheritedWidget {
  const AppDataProvider(
      {super.key, required super.child, required this.personData});

  final PersonData personData;

  static AppDataProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class PersonData extends ChangeNotifier {
  String? name;
  int? age;

  void changeName(String name) {
    this.name = name;

    notifyListeners();
  }

  void changeAge(int age) {
    this.age = age;

    notifyListeners();
  }
}
