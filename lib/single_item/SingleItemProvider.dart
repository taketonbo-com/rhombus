
import 'package:flutter/material.dart';
import 'package:rhombus/category/category_items_bloc.dart';
import 'package:rhombus/Api/api.dart';
import 'package:rhombus/items/food_items_bloc.dart';
import 'package:rhombus/single_item/single_items_bloc.dart';

class SingleItemProvider extends InheritedWidget {
  final SingleItemsBloc itemBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SingleItemsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SingleItemProvider) as SingleItemProvider)
          .itemBloc;

  SingleItemProvider({Key key, SingleItemsBloc itemBloc, Widget child,int id,String apiKey})
      : this.itemBloc = itemBloc ?? SingleItemsBloc(Api(),id,apiKey),
        super(child: child, key: key);

}