
import 'package:flutter/material.dart';
import 'package:rhombus/category/category_items_bloc.dart';
import 'package:rhombus/Api/api.dart';
import 'package:rhombus/items/food_items_bloc.dart';

class FoodItemProvider extends InheritedWidget {
  final FoodItemsBloc itemBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static FoodItemsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(FoodItemProvider) as FoodItemProvider)
          .itemBloc;

  FoodItemProvider({Key key, FoodItemsBloc itemBloc, Widget child})
      : this.itemBloc = itemBloc ?? FoodItemsBloc(Api()),
        super(child: child, key: key);

}