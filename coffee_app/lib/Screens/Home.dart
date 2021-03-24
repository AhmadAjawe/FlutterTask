
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/Screens/settings.dart';
import 'package:coffee_app/Services/auth.dart';
import 'package:flutter/material.dart';
import  'package:coffee_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/Screens/coffee_list.dart';
import 'package:coffee_app/Model/brew.dart';




class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override

  Widget build(BuildContext context){

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),

        );
      }
      );


    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Coffee_App'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();

              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Setting'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: CoffeeList(),




      ),
    );

  }
}
