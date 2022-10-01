import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_controller.dart';
import 'package:comptes_partages_flutter/src/settings/settings_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_form_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_portfolio_view.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome-screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _WelcomeScreenState() {}
  /*
  Widget routeButton(Color buttonColor, String title, Color textColor, BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: buttonColor,
        onPressed: () => context,
        child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor,),),
      ),
    );
  }
  */

  ElevatedButton getCarnetButton() {
    if (CarnetPortFolioController.instance.carnetPortfolio!.carnets.isEmpty) {
      return firstCarnetButton();
    } else {
      return carnetListButton();
    }
  }

  ElevatedButton carnetListButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.book),
      onPressed: () => Navigator.restorablePushNamed(
        context,
        CarnetPortfolioView.routeName,
      ),
      label: const Text(
        'Mes carnets',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  ElevatedButton firstCarnetButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.book),
      onPressed: () => Navigator.restorablePushNamed(
        context,
        CarnetFormView.routeName,
      ),
      label: const Text(
        'Créer un carnet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: [
                      const Text(
                        'Comptes partagés',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: getCarnetButton(),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person),
                        onPressed: () => Navigator.of(context).pop(),
                        label: const Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.settings),
                        onPressed: () => Navigator.restorablePushNamed(
                            context, SettingsView.routeName),
                        label: const Text(
                          'Paramètres',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
