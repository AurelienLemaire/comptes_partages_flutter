import 'package:comptes_partages_flutter/src/settings/settings_view.dart';
import 'package:comptes_partages_flutter/src/views/carnet_portfolio_view.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Mes carnets',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Mes carnets'),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                CarnetPortfolioView.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () => {
              Navigator.restorablePushNamed(context, SettingsView.routeName)
            },
          ),
        ],
      ),
    );
  }
}
