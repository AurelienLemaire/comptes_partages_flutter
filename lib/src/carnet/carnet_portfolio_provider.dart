import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_provider.dart';

import 'carnet.dart';
import 'dart:convert';
import 'dart:io';

class CarnetPortFolioProvider {
  Future<void> serializeCarnetPortFolio(CarnetPortfolio carnetPortfolio) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    const filename = 'carnetportfolio.txt';
    var file = File(filename);
    var sink = file.openWrite();

    sink.write(encoder.convert({
      'default': carnetPortfolio.getDefaultCarnet(),
      'carnets': carnetPortfolio.getCarnetsNamesList()
    }));
    await sink.close();
  }

  void serializeCarnetPortFolioSync(CarnetPortfolio carnetPortfolio) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    const filename = 'carnetportfolio.txt';
    var file = File(filename);
    file.writeAsStringSync(encoder.convert({
      'default': carnetPortfolio.getDefaultCarnet(),
      'carnets': carnetPortfolio.getCarnetsNamesList()
    }));
  }

  CarnetPortfolio deserializeCarnetPortFolio() {
    const JsonDecoder decoder = JsonDecoder();

    const filename = 'carnetportfolio.txt';
    var file = File(filename);
    var contents = file.readAsStringSync();
    var result = decoder.convert(contents);

    CarnetPortfolio carnetPortfolio = CarnetPortfolio();
    carnetPortfolio.setDefaultCarnet(result['default']);
    List<String> carnetsNames = List<String>.from(result['carnets']);

    CarnetProvider provider = CarnetProvider();
    for (String cname in carnetsNames) {
      Carnet c = provider.deserializeCarnet(cname);
      carnetPortfolio.addCarnet(c);
    }

    return carnetPortfolio;
  }
}
