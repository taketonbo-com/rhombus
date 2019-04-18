import 'package:flutter/material.dart';
import 'package:rhombus/Api/api.dart';
import 'package:rhombus/cart/CartProvider.dart';
import 'package:rhombus/cart/cart_bloc.dart';
import 'package:rhombus/cart/cart_item_count.dart';
import 'package:rhombus/cart/shopping_cart.dart';
import 'package:rhombus/category/CategoryItemProvider.dart';

import 'package:rhombus/category/Today_menu.dart';
import 'package:rhombus/category/category_items_bloc.dart';
import 'package:rhombus/category/category_scroller.dart';
import 'package:rhombus/items/FoodItemProvider.dart';
import 'package:rhombus/items/food_items_bloc.dart';
import 'package:rhombus/utils/cart_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {


  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  String apiKey;
  _loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apiKey = prefs.getString('api_key');
      print(apiKey);
    });
  }
  @override
  initState()
  {
    super.initState();
    _loadApiKey();

  }
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final item = CartProvider.of(context);
    return new  Scaffold(
        appBar: new AppBar
          (
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title:     new Text(
              "foody",
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'christmas-cookies',
                  fontWeight: FontWeight.w600,
                  fontSize: 30.0
              )
          ),
          actions: <Widget>
          [
            StreamBuilder(
              stream: item.itemCount,
            //  initialData:,
              builder: (context, snapshot)
                {
                  if(snapshot.hasData)
                    {
                      CartItemCount cItem = snapshot.data;
                     return CartButton(
                        itemCount: cItem.total,
                        onPressed: () {

                          Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context)
                                =>   new CartProvider(
                                  itemBloc: new CartBloc(new Api(),apiKey),
                                  child: new ShoppingCart(),
                                  apiKey: apiKey,
                                )
                            ),
                            );


                        },
                      );
                    }
                 return CartButton(
                    itemCount: 0,
                    onPressed: () {
                      // Navigator.of(context).pushNamed(BlocCartPage.routeName);
                    },
                  );

                }
            )
          ],
        ),
        body: new ListView(
          children: <Widget>[
        AspectRatio(
        aspectRatio: 18.0 / 11.0,
          child:
           new GridTile(
             footer: new GridTileBar(
               backgroundColor: Colors.redAccent,
               title: new Center(
                 child: new Text("Dish Of The Day",style: new TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
               )
             ),
             child: new Image.asset("assets/images/b.jpg"),
           
           ),
        ),
            new CategoryItemProvider(
              itemBloc: new CategoryItemsBloc(Api()),
              child: new CategoryScroller(),
            ),
            new FoodItemProvider(
              itemBloc: new FoodItemsBloc(new Api()),
              child: new TodayMenu(),
            ),

          ],
        )

    );
  }
}
