import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String? categoryTitle;
  late List<Meal> displaydMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      final categoryId = routArgs['id'];
      categoryTitle = routArgs['title'];
      displaydMeals = widget.availableMeals.where(
        (meal) {
          return meal.categories!.contains(categoryId);
        },
      ).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displaydMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('categoryTitle'),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: displaydMeals[index].id!,
                title: displaydMeals[index].title!,
                imageSorce: displaydMeals[index].imageUrl!,
                duration: displaydMeals[index].duration!,
                complexity: displaydMeals[index].complexity!,
                affordability: displaydMeals[index].affordability!,
               
              );
            },
            itemCount: displaydMeals.length,
          ),
        ),
      ),
    );
  }
}
