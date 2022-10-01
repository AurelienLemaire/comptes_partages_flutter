import 'dart:convert';
import 'dart:io';

import 'package:comptes_partages_flutter/src/carnet/carnet.dart';

class CarnetProvider {
  Future<void> serializeCarnet(Carnet c) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    final filename = '${c.name()}.txt';
    var file = File(filename);
    var sink = file.openWrite();
    sink.write(encoder.convert(c));
    await sink.close();
  }

  void serializeCarnetSync(Carnet c) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    final filename = '${c.name()}.txt';
    var file = File(filename);
    file.writeAsStringSync(encoder.convert(c));
  }

  Carnet deserializeCarnet(String name) {
    const JsonDecoder decoder = JsonDecoder();

    final filename = '$name.txt';
    var file = File(filename);
    var contents = file.readAsStringSync();
    var result = decoder.convert(contents);
    return Carnet.fromJson(result);
  }
}
