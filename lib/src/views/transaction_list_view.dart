import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_provider.dart';
import 'package:comptes_partages_flutter/src/carnet/transaction_controller.dart';
import 'package:comptes_partages_flutter/src/views/carnet_form_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_stats_view.dart';
import 'package:comptes_partages_flutter/src/views/compte_partages_widget_helpers.dart';
import 'package:comptes_partages_flutter/src/views/navdrawer.dart';
import 'package:comptes_partages_flutter/src/views/transaction_form_view.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class TransactionListView extends StatefulWidget {
  TransactionListView({super.key});

  final State<TransactionListView> state = _TransactionListViewState();

  @override
  State<TransactionListView> createState() => state;
  State<TransactionListView> getState() => state;
  static const routeName = '/transaction_list';
}

class _TransactionListViewState extends State<TransactionListView> {
  void update() {
    setState(() {});
  }

  void editCarnetAction() {
    Navigator.restorablePushNamed(
      context,
      CarnetFormView.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (CarnetController.instance.carnet == null) throw Exception();

    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: ComptesPartagesWidgetHelpers.appBarBackgroundColor,
          title: Text("Carnet : ${CarnetController.instance.carnet!.name()}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editCarnetAction();
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: ListView.builder(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'sampleItemListView',

          itemCount: CarnetController.instance.carnet!.transactions.length,
          itemBuilder: (BuildContext context, int index) {
            //transaction = CarnetController.instance.carnet!.transactions[index];

            return Scrollbar(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                        elevation: 10,
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.all(5),
                            child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 400),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        title: Text(CarnetController.instance
                                            .carnet!.transactions[index].what),
                                        subtitle: Text(CarnetController.instance
                                            .carnet!.transactions[index].who),
                                        leading: Text(
                                          "${CarnetController.instance.carnet!.transactions[index].amount} €",
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan),
                                        ),

                                        // CircleAvatar(
                                        //   radius: 24,
                                        //   backgroundColor: Colors.cyan,
                                        //   child: const Icon(Icons.euro,
                                        //       color: Colors.white, size: 30),
                                        // ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              CarnetController
                                                  .instance.carnet!.transactions
                                                  .removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete)),
                                        onTap: () {
                                          TransactionController.instance
                                              .setTransaction(CarnetController
                                                  .instance
                                                  .carnet!
                                                  .transactions[index]);
                                          // Navigate to the details page. If the user leaves and returns to
                                          // the app after it has been killed while running in the
                                          // background, the navigation stack is restored.
                                          Navigator.restorablePushNamed(
                                            context,
                                            TransactionFormView.routeName,
                                          );
                                        },
                                      )
                                    ]))))));
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TransactionController.instance.deleteTransaction();
            // Navigate to the details page. If the user leaves and returns to
            // the app after it has been killed while running in the
            // background, the navigation stack is restored.
            Navigator.restorablePushNamed(
              context,
              TransactionFormView.routeName,
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_down),
              label: "Enregistrer",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.area_chart_sharp),
              label: "Stats",
            )
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      CarnetProvider provider = CarnetProvider();
      provider.serializeCarnetSync(CarnetController.instance.carnet!);
    }
    if (index == 1) {
      Navigator.restorablePushNamed(
        context,
        CarnetStatsView.routeName,
      );
    }
  }
}
