// ignore_for_file: unused_import

import 'dart:core';
import 'package:comptes_partages_flutter/src/carnet/carnet.dart';

import 'transaction.dart';

/// Une classe pour modéliser un carnet de transactions et les opérations associées
class CarnetPortfolio {
  String _defaultCarnetName = "";

  final Map<String, Carnet> _carnets = {};
  Map<String, Carnet> get carnets => _carnets;

  /// Constructeur pour initialiser a partir d'un ensemble de transactions vides
  CarnetPortfolio();

  String getDefaultCarnet() {
    return _defaultCarnetName;
  }

  void setDefaultCarnet(String n) {
    _defaultCarnetName = n;
  }

  addCarnet(Carnet c) {
    if (_carnets.isEmpty) {
      setDefaultCarnet(c.name());
    }
    _carnets.addAll({c.name(): c});
  }

  removeCarnet(Carnet c) {
    _carnets.remove(c.name());
    setDefaultCarnet("");
    if (_carnets.isNotEmpty) {
      setDefaultCarnet(getCarnetsNamesList()[0]);
    }
  }

  List<String> getCarnetsNamesList() {
    return List<String>.from(_carnets.keys);
  }

  List<Carnet> getCarnetsList() {
    return List<Carnet>.from(_carnets.values);
  }
}
