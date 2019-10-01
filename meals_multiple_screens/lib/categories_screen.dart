import 'package:flutter/material.dart';
import 'package:meals_multiple_screens/dummy_data.dart';

import './models/category.dart';
import './category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DeliMeal'),
        ),
        body: GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map((catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  ))
              .toList(),
          // slivers in flutter are scrollable areas on the screen
          // grid delgate == structuring layout in the grid
          // WithMaxCrossAxisExtent = preconfigured class which allows to define a maxinum width for each grid item
          // each item will fill up the container constraints, creating columns/rows if needed
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 /
                2, // this means each child will have 200px width, 300px height
            crossAxisSpacing: 20,
            mainAxisSpacing: 20, // like grid-gap in css grids
          ),
        ));
  }
}
