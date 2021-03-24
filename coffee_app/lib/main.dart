import 'package:coffee_app/Screens/wrapper.dart';
import 'package:coffee_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/Model/user.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
          home: wrapper(),
        ),
    );
  }
}