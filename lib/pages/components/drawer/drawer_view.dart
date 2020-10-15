import 'package:flutter/material.dart';
import 'package:shopApp/utils/size_config.dart';

class DrawerView extends StatelessWidget {
  static const List<DrawerOption> drawerOptions = [
    DrawerOption(Icons.shopping_cart, 'Loja', '/'),
    DrawerOption(Icons.credit_card, 'Compras', 'orders'),
    DrawerOption(Icons.edit, 'Gerenciar produtos', 'products_list'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 20,
            width: double.maxFinite,
            child: Center(child: Text('Seja bem-vindo(a)')),
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 80,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: drawerOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(drawerOptions[index].icon),
                    title: Text(drawerOptions[index].title),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, drawerOptions[index].route),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class DrawerOption {
  final IconData icon;
  final String title;
  final String route;

  const DrawerOption(this.icon, this.title, this.route);
}
