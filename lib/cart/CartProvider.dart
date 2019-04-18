
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rhombus/cart/cart_bloc.dart';

import 'package:rhombus/Api/api.dart';

class CartProvider extends InheritedWidget {
  final CartBloc itemBloc;


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CartBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(CartProvider) as CartProvider)
          .itemBloc;

  CartProvider({Key key, CartBloc itemBloc, Widget child,String apiKey})
      : this.itemBloc = itemBloc ?? CartBloc(Api(),apiKey),

        super(child: child, key: key);

}