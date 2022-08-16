import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favoriteMeal;
  Favorites(this.favoriteMeal);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text('You have no favorites.'),
      );
    } else {
      return Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: favoriteMeal[index].id!,
                title: favoriteMeal[index].title!,
                imageSorce: favoriteMeal[index].imageUrl!,
                duration: favoriteMeal[index].duration!,
                complexity: favoriteMeal[index].complexity!,
                affordability: favoriteMeal[index].affordability!,
              );
            },
            itemCount: favoriteMeal.length,
          ),
        ),
      );
    }
  }
}
