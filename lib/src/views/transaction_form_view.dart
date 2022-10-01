// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/transaction.dart';
import 'package:comptes_partages_flutter/src/carnet/transaction_controller.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:comptes_partages_flutter/src/views/transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TransactionFormView extends StatefulWidget {
  const TransactionFormView({super.key});
  static const routeName = '/sample_item';

  @override
  State<TransactionFormView> createState() => _TransactionFormViewState();
}

class _TransactionFormViewState extends State<TransactionFormView> {
  final _formKey = GlobalKey<FormState>();

  final transactionController = TransactionController.instance;

  String description = '';
  DateTime date = DateTime.now();

  String? who = CarnetController().carnet?.getUsers().first;
  double amount = 0.0;
  String what = "";

  _TransactionFormViewState() {
    loadFromTransactionController();
  }

  void loadFromTransactionController() {
    if (transactionController.transaction == null) {
      //cas ou la transaction est créée
      who = CarnetController.instance.carnet?.getUsers().first;
      what = "Nouvel achat";
      amount = 0.0;
    } else {
      //si c'est un carnet modifié
      who = transactionController.transaction!.who;
      what = transactionController.transaction!.what;
      amount = transactionController.transaction!.amount;
    }
  }

  void saveToController() {
    if (transactionController.transaction == null) {
      //cas ou la transaction est créée
      Transaction t = Transaction(who!, amount, what);
      TransactionController.instance.setTransaction(t);
      CarnetController.instance.carnet?.addTransactionList([t]);
    } else {
      //cas ou la transaction est modifiée
      transactionController.transaction!.who = who!;
      transactionController.transaction!.what = what;
      transactionController.transaction!.amount = amount;
    }

    Navigator.restorablePushNamed(
      context,
      TransactionListView.routeName,
    );
  }

  List<DropdownMenuItem<String>> buildUsersDropdown() {
    return CarnetController.instance.carnet!
        .getUsers()
        .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ComptesPartagesWidgetHelpers.appBarBackgroundColor,
          title: Text(what),
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
                            initialValue: this.what,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: this.what,
                              labelText: 'quoi',
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.what = value;
                              });
                            },
                          ),
                          DropdownButtonFormField<String>(
                            value: this.who,
                            decoration: const InputDecoration(
                              filled: true,
                              labelText: 'qui',
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                this.who = value!;
                              });
                            },
                            items: buildUsersDropdown(),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: 'Entrez une description...',
                              labelText: 'Description',
                            ),
                            onChanged: (value) {
                              description = value;
                            },
                            maxLines: 5,
                          ),
                          _FormDatePicker(
                            date: date,
                            onChanged: (value) {
                              setState(() {
                                date = value;
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue: amount.toString(),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: amount.toString(),
                                  labelText: '€',
                                ),
                                onChanged: (value) {
                                  amount = double.parse(value);
                                },
                              ),
                            ],
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
                                    saveToController();
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

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        ),
      ],
    );
  }
}
