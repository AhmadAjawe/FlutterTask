import 'package:coffee_app/Services/auth.dart';
import 'package:coffee_app/Shared/design.dart';
import 'package:coffee_app/Shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  @override
  final Function toggleView;
  SignIn({this.toggleView});
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
   final AuthService _auth=AuthService();
   final _formKey= GlobalKey<FormState>();
   bool loading= false;
   String email='';
   String password='';
   String error='';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Coffee_App'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();

            },
          )
        ],
    ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(

                  decoration: textinputdecration.copyWith(hintText: 'email'),


                  validator: (val) => val.isEmpty ?'Enter an Email':null,
              onChanged: (val){
                    setState(() => email=val);

                    }

              ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textinputdecration.copyWith(hintText: 'password'),
                    validator: (val) => val.length < 6 ?'Enter a password 6+ char long':null,
                    obscureText: true,
                    onChanged:  (val)
                {
                  setState(() => password=val);
                }
                ),
              SizedBox(height: 20.0),

              ElevatedButton(

                child: Text('Sign in',style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.SignInwithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Email is not in use';
                        loading= false;
                      });
                    }
                  }
                }
              ),
          SizedBox(height: 12.0),
          Text(
            error,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.0,
            ),
          ),
          ],
          ),
        ),
          ),
        );

  }
}
