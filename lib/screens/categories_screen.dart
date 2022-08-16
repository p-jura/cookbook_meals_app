// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../dummy_cat.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map imgUrl = Map.fromIterables(DUMMY_MEALS.map((meal) {
      return meal.categories!.first;
    }), DUMMY_MEALS.map((meals) {
      return meals.imageUrl;
    }));
    print(imgUrl);
    return GridView(
      padding: const EdgeInsets.all(25),
      children: [
        ...DUMMY_CATEGORIES
            .map(
              (catData) =>
                  CategoryItem(catData.id!, catData.title!, catData.color!, imgUrl[catData.id].toString()),
            )
            .toList(),
      ],
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
