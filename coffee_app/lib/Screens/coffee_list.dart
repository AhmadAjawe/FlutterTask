import 'package:flutter/material.dart';
import 'package:coffee_app/Model/brew.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/Screens/brew_tile.dart';


class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final brews =Provider.of<List<Brew>>(context)??[];
     


    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context , index){
        return BrewTile(brew: brews[index]);


      },

    );
  }
}
