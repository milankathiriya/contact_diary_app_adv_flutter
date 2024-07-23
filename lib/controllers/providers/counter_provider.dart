import 'package:flutter/material.dart';
import 'package:rwa1_adv_flutter_5pm/models/counter_model.dart';

class CounterProvider extends ChangeNotifier {
  CounterModel counterModel = CounterModel(counter: 0);

  void increment() {
    counterModel.counter++;
    notifyListeners();
  }
}
