import 'carnet.dart';
import 'dart:convert';
import 'dart:io';

class CarnetController {
  static final instance = CarnetController();
  Carnet? carnet;

  void createCarnet(String name) {
    carnet = Carnet(name);
  }

  void setCarnet(Carnet c) {
    carnet = c;
  }

  void addUser(String user) {
    carnet?.addUser(user);
  }

  void addTransaction(String who, double amount, String what) {
    carnet?.addTransaction(who, amount, what);
  }

  void deleteCarnet() {
    carnet = null;
  }
}
