import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_provider.dart';

import 'carnet.dart';
import 'dart:convert';
import 'dart:io';

class CarnetPortFolioController {
  static final instance = CarnetPortFolioController();
  CarnetPortfolio? carnetPortfolio;

  void createCarnetPortfolio() {
    carnetPortfolio = CarnetPortfolio();
  }

  void setCarnetPortfolio(CarnetPortfolio c) {
    carnetPortfolio = c;
  }

  void addCarnet(Carnet c) {
    carnetPortfolio?.addCarnet(c);
  }
}
