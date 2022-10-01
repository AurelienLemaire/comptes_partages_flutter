// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:comptes_partages_flutter/src/carnet/carnet.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_controller.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:comptes_partages_flutter/src/views/transaction_list_view.dart';
import 'package:flutter/material.dart';

class CarnetFormView extends StatefulWidget {
  const CarnetFormView({super.key});
  static const routeName = '/carnet_form';

  @override
  State<CarnetFormView> createState() => _CarnetFormViewState();
}

class _CarnetFormViewState extends State<CarnetFormView> {
  final _formKey = GlobalKey<FormState>();

  final carnetController = CarnetController.instance;

  String name = '';

  _CarnetFormViewState() {
    loadFromCarnetController();
  }

  void loadFromCarnetController() {
    if (carnetController.carnet == null) {
      //si c'est un carnet créé
      name = "Nouveau carnet";
    } else {
      //si c'est un carnet modifié
      name = carnetController.carnet!.name();
    }
  }

  void saveCarnet() {
    if (carnetController.carnet == null) {
      //si c'est un carnet créé
      Carnet t = Carnet(name);
      t.addUser("aurelien");
      CarnetController.instance.setCarnet(t);
      CarnetPortFolioController.instance.addCarnet(t);
      CarnetPortFolioController.instance.carnetPortfolio!
          .setDefaultCarnet(t.name());
    } else {
      //si c'est un carnet modifié
      carnetController.carnet!.setName(name);
    }
    Navigator.restorablePushNamed(
      context,
      TransactionListView.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ComptesPartagesWidgetHelpers.appBarBackgroundColor,
          title: Text(name),
        ),
        body: Form(
          key: _formKey,
          child: Scrollbar(
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 10,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...[
                          TextFormField(
                            initialValue: this.name,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: this.name,
                              labelText: 'titre',
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.name = value;
                              });
                            },
                          ),
                          ButtonBar(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                  child: const Text('Annuler'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              TextButton(
                                  child: const Text('Valider'),
                                  onPressed: () {
                                    saveCarnet();
                                  }),
                            ],
                          ),
                        ].expand(
                          (widget) => [
                            widget,
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
