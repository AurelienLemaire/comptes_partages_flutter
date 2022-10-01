// ignore_for_file: prefer_const_constructors

import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_controller.dart';
import 'package:comptes_partages_flutter/src/settings/settings_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_form_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_portfolio_view.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:flutter/material.dart';

/// Displays a list of SampleItems.
class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});
  static const routeName = '/';

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  _WelcomeViewState() {}

  ListTile getCarnetButton() {
    if (CarnetPortFolioController.instance.carnetPortfolio!.carnets.isEmpty) {
      return firstCarnetButton();
    } else {
      return carnetListButton();
    }
  }

  ListTile firstCarnetButton() {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text('Créer un carnet'),
      onTap: () {
        Navigator.restorablePushNamed(
          context,
          CarnetFormView.routeName,
        );
      },
    );
  }

  ListTile carnetListButton() {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text('Mes carnets'),
      onTap: () {
        Navigator.restorablePushNamed(
          context,
          CarnetPortfolioView.routeName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: Card(
            margin: EdgeInsets.all(10),
            color: Colors.transparent,
            //color: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    width: 180.0,
                    height: 180.0,
                    opacity: const AlwaysStoppedAnimation<double>(0.9),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Text("Comptes\npartagés",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        getCarnetButton(),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profil'),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        Center(
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Paramètres'),
                            onTap: () => {
                              Navigator.restorablePushNamed(
                                  context, SettingsView.routeName)
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
