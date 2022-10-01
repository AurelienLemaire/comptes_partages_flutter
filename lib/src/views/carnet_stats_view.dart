// ignore_for_file: prefer_const_constructors

import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:flutter/material.dart';

/// Displays a list of SampleItems.
class CarnetStatsView extends StatefulWidget {
  const CarnetStatsView({super.key});
  static const routeName = '/carnet_stats';

  @override
  State<CarnetStatsView> createState() => _CarnetStatsViewState();
}

class _CarnetStatsViewState extends State<CarnetStatsView> {
  late Map<String, double> amountByUser;

  _CarnetStatsViewState() {
    amountByUser = CarnetController.instance.carnet!.getAmountByUser();
  }
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (CarnetController.instance.carnet == null) throw Exception();
    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ComptesPartagesWidgetHelpers.appBarBackgroundColor,
          title: Text("Carnet : ${CarnetController.instance.carnet!.name()}"),
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: Card(
            margin: EdgeInsets.all(10),
            //color: Colors.transparent,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  tileColor: Colors.transparent,
                  title: Text(
                    "Dépenses",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  itemCount: amountByUser.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(amountByUser.keys.elementAt(index)),
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      leading: Icon(Icons.euro, color: Colors.green, size: 20),
                      trailing: Text(
                        "${amountByUser[amountByUser.keys.elementAt(index)]} €",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
