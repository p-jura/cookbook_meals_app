// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/meal_detale_screen.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filter_screen.dart';
import './dummy_cat.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree!) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree!) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan!) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian!) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });

    }
  }
  bool _isMealFavorit(String id){
    return _favoriteMeals.any((element)=>element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(239, 86, 151, 191),
          onPrimary: Color.fromARGB(255, 201, 231, 242),
          secondary: Color.fromARGB(230, 242, 162, 92),
          onSecondary: Color.fromARGB(255, 115, 65, 36),
          background: Colors.white,
          surface: Color.fromARGB(255, 240, 240, 240),
          onSurface: Colors.black,
          onBackground: Colors.black,
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 249, 238, 238),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
              headline5: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
              ),
              headline4: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                color: Color.fromARGB(239, 86, 151, 191),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
              ),
              headline3: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 48,
              ),
              headline2: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 60,
              ),
              headline1: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300),
              subtitle1: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              subtitle2: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
              ),
            ),
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetalScreen.routName: (context) => MealDetalScreen(_toggleFavorite, _isMealFavorit),
        FilterScreen.routName: (context) => FilterScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/meal') {}
      //   return MaterialPageRoute(
      //     builder: (context) => CategoriesScreen(),
      //   );
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyMeals'),
      ),
      body: const Center(
        child: Text('DailyMeals!'),
      ),
    );
  }
}
