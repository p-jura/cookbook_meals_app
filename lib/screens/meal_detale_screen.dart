import 'package:flutter/material.dart';
import '../dummy_cat.dart';

class MealDetalScreen extends StatelessWidget {
  static const routName = '/meal-detal-screen';
  final Function toggleFavorites;
  final Function isMealFavorite;

  MealDetalScreen(this.toggleFavorites, this.isMealFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildConteiner(BuildContext context, Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiary, width: 2),
        ),
        height: 150,
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                selectedMeal.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildConteiner(
              context,
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  color: Theme.of(context).colorScheme.secondary,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      selectedMeal.ingredients![index],
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients!.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildConteiner(
              context,
              ListView.builder(
                itemCount: selectedMeal.steps!.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Text(
                          '# ${index + 1}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      title: Text(
                        selectedMeal.steps![index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorites(mealId),
        // () {
        //   toggleFavorites();
        //   //Navigator.of(context).pop(mealId);
        // },
      ),
    );
  }
}
