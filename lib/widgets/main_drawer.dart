import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _BuildListTile(
      BuildContext context, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.onPrimary,
            child: Text(
              'Lets Cook the meal',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 26),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _BuildListTile(
            context,
            'Meal',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _BuildListTile(
            context,
            'Filter',
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(FilterScreen.routName);
            },
          ),
        ],
      ),
    );
  }
}
