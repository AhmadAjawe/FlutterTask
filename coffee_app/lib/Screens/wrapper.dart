import 'package:coffee_app/Screens/Home.dart';
import 'package:coffee_app/Screens/authenticatation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/Model/user.dart';



class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    print(user);

    if (user == null)
      return Authenticate();
      else
        return Home();

    //reuturn home or authenticate
  }
}
