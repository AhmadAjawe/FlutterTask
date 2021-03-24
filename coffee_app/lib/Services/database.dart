import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/Model/brew.dart';
import 'package:coffee_app/Model/user.dart';

class DatabaseService{
final String uid;
DatabaseService({this.uid});

  //collection reference

  final  CollectionReference bCollection= Firestore.instance.collection('brews');
  Future updateuserData(String sugars,String name,int strength) async {
    return await bCollection.document(uid).setData({
      'sugars' : sugars,
      'name': name,
      'strength': strength,
    });

  }
  //brew list from snapshot
List<Brew> _brewListFromsnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 100,
        sugars: doc.data['sugars'] ?? '0'
      );

    }).toList();
}

//user data  from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {

    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],

    );
  }

  //get users streams
Stream<List<Brew>> get brews{
    return bCollection.snapshots().map(_brewListFromsnapshot);


}

// get user doc stream
Stream<UserData> get  userData {
    return bCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

}