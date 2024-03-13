import 'package:flutter/material.dart';
import 'package:simple_get_it/main.dart';

abstract class CounterModel extends ChangeNotifier {
  int get counter;
  void increment();
}

class CounterModelImpl extends CounterModel {
  int _counter = 0;

  CounterModelImpl() {
    /// lets pretend we have to do some async initialization
    /// using signalReady is not necessary in most cases
    /// just use registerSingletonAsync instead
    Future.delayed(const Duration(seconds: 3))
        .then((_) => getIt.signalReady(this));
  }

  @override
  int get counter => _counter;

  @override
  void increment() {
    _counter++;
    notifyListeners();
  }
}