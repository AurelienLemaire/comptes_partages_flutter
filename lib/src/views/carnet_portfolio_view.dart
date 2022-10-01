import 'package:comptes_partages_flutter/src/carnet/carnet.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_controller.dart';
import 'package:comptes_partages_flutter/src/carnet/carnet_portfolio_controller.dart';
import 'carnet_form_view.dart';
import 'compte_partages_widget_helpers.dart';
import 'navdrawer.dart';
import 'transaction_list_view.dart';
import 'package:flutter/material.dart';

/// Displays a list of Canets.
class CarnetPortfolioView extends StatefulWidget {
  CarnetPortfolioView({super.key});

  final State<CarnetPortfolioView> state = _CarnetPortfolioViewState();

  @override
  State<CarnetPortfolioView> createState() => state;
  State<CarnetPortfolioView> getState() => state;

  static const routeName = '/CarnetListView';
}

class _CarnetPortfolioViewState extends State<CarnetPortfolioView> {
  void update() {
    setState(() {});
  }

  Carnet getCarnet(index) {
    return CarnetPortFolioController.instance.carnetPortfolio!
        .getCarnetsList()[index];
  }

  void editCarnetAction(int index) {
    CarnetController.instance.setCarnet(getCarnet(index));
    Navigator.restorablePushNamed(
      context,
      CarnetFormView.routeName,
    );
  }

  void deleteCarnetAction(int index) {
    Carnet c = getCarnet(index);
    CarnetPortFolioController.instance.carnetPortfolio!.removeCarnet(c);
    setState(() {});
  }

  void viewCarnetAction(int index) {
    CarnetController.instance.setCarnet(getCarnet(index));

    Navigator.pushNamed(
      context,
      TransactionListView.routeName,
    );
  }

  void addCarnetAction() {
    CarnetController.instance.deleteCarnet();

    Navigator.restorablePushNamed(
      context,
      CarnetFormView.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ComptesPartagesWidgetHelpers.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: NavDrawer(),
        appBar: AppBar(
            backgroundColor: ComptesPartagesWidgetHelpers.appBarBackgroundColor,
            title: Text("Carnets")),
        body: ListView.builder(
          restorationId: 'sampleItemListView',
          itemCount: CarnetPortFolioController
              .instance.carnetPortfolio!.carnets.length,
          itemBuilder: (BuildContext context, int index) {
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
                                        title: Text(getCarnet(index).name()),
                                        trailing: IconButton(
                                            onPressed: () {
                                              deleteCarnetAction(index);
                                            },
                                            icon: const Icon(Icons.delete)),
                                        onTap: () {
                                          viewCarnetAction(index);
                                        },
                                      )
                                    ]))))));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addCarnetAction();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
