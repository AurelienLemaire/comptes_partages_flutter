import 'package:comptes_partages_flutter/src/carnet/carnet.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_provider.dart';
import 'package:comptes_partages_flutter/src/carnet/transaction_repository.dart';
import 'package:flutter/material.dart';

import 'src/comptes_partages_app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final SettingsController settingsController =
      SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  initData();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(ComptesPartagesApp(settingsController: settingsController));
}

void initData() {
  // var c = Carnet("aurelien");
  // c.addUser("aurelien");
  // c.addUser("aurelie");
  // c.addTransactionList(TransactionRepository.getMockupTransactionList());
  // CarnetController.instance.setCarnet(c);

  // CarnetPortfolio portfolio = new CarnetPortfolio();
  // CarnetController.instance.deserializeCarnet("aurelien");
  // portfolio.addCarnet(CarnetController.instance.carnet!);
  // portfolio.addCarnet(CarnetController.instance.carnet!);
  // portfolio.setDefaultCarnet("toto");
  // CarnetPortFolioController.instance.setCarnetPortfolio(portfolio);
  // CarnetPortFolioController.instance.serializeCarnetPortFolio();

  CarnetPortFolioProvider provider = CarnetPortFolioProvider();
  CarnetPortfolio? carnetPortfolio;
  try {
    carnetPortfolio = provider.deserializeCarnetPortFolio();
  } catch (e) {
    carnetPortfolio = CarnetPortfolio();
  }

  CarnetPortFolioController.instance.setCarnetPortfolio(carnetPortfolio);
}
