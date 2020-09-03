import 'package:Joya_Italiano/Models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  Future<void> updateUserData(
      String name, bool admin, String date, String time, int number) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'admin': admin,
      'date': date,
      'time': time,
      'number': number,
    });
  }

  Future<void> deleteUserData() async {
    return await userCollection.document(uid).delete();
  }

  List<UserData> userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        name: doc.data['name'] ?? ' ',
        admin: doc.data[false] ?? false,
        date: doc.data['date'] ?? '00-00-00',
        time: doc.data['time'] ?? '00:00',
        number: doc.data['number'] ?? 0,
      );
    }).toList();
  }

  // get brews stream
  Stream<List<UserData>> get users {
    return userCollection.snapshots().map(userDataFromSnapshot);
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        date: snapshot.data['date'],
        time: snapshot.data['time'],
        number: snapshot.data['number']);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
