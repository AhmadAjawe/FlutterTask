import 'package:coffee_app/Model/user.dart';
import 'package:coffee_app/Screens/signIn.dart';
import 'package:coffee_app/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create  user object based on firebase user

  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
//Auth change user stream

    Stream<User> get user{
    return  _auth.onAuthStateChanged //.map((FirebaseUser)=>_userFromFirebase(user));
    .map(_userFromFirebase);
  }
  //sign in anon
    Future signInAnon() async {
      try{
      AuthResult result= await _auth.signInAnonymously();
          FirebaseUser user = result.user;
          return _userFromFirebase(user);
      }catch(e)
      {
        print(e.toString());
        return null;

      }

    }

  //Register with email & pass
  Future RegisterwithEmailAndPassword(String email,String password) async
  {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create   a new document   for the user with the uid
      await DatabaseService(uid: user.uid).updateuserData('0',"new user", 100);
      return _userFromFirebase(user);

    } catch(e)
    {
      print(e.toString());
      return null;
    }


}


  //sign in email and pass

  Future SignInwithEmailAndPassword(String email,String password) async
  {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);

    } catch(e)
    {
      print(e.toString());
      return null;
    }


  }

  //Sign out

Future signOut() async {
    try{
      return await _auth.signOut();

    } catch(e)
  {
    print(e.toString());
    return null;

  }
}




}