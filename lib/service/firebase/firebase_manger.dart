import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';
import 'package:sultan_pizza/service/firebase/firebase_operation.dart';

class FirebaseManger implements FirebaseOperation {
  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseStorage mStorage = FirebaseStorage.instance;
  @override
  Future<Account> loginAccount(String email, String password) async {
    try {
      await mAuth.signInWithEmailAndPassword(email: email, password: password);
      Account account = await getUserInformation(email);

      return account;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> registerAccount(Account account) async {
    bool isDone = false;
    Map<String, dynamic> map = {
      'username': account.username,
      'password': account.password,
      'email': account.email,
      'age': account.age
    };

    try {
      await mAuth.createUserWithEmailAndPassword(
          email: account.email, password: account.password);
      await database.collection('users').doc(account.email).set(map);
      isDone = true;
      return isDone;
    } catch (e) {
      return isDone;
    }
  }

  @override
  Future<Account> getUserInformation(String email) async {
    Account account = Account();
    DocumentSnapshot documentSnapshot =
        await database.collection('users').doc(email).get();
    account.age = documentSnapshot.get('age');
    account.email = documentSnapshot.get('email');
    account.password = documentSnapshot.get('password');
    account.username = documentSnapshot.get('username');
    return account;
  }

  @override
  Future<List<Sultan>> getSultanMenuOption(String type) async {
    List<Sultan> myMenu = List<Sultan>();
    QuerySnapshot querySnapshot = await database.collection(type).get();
    for (QueryDocumentSnapshot item in querySnapshot.docs) {
      String name = item.get('name');
      List<dynamic> ingredients = item.get('Ingredients');
      List<String> finalList = List<String>();
      for (int i = 0; i < ingredients.length; i++) {
        finalList.add(ingredients[i].toString());
      }
      int number = item.get('price');
      String url = await getPizzaPhoto(item.id, type);

      myMenu.add(Sultan.details(name, finalList, number, item.id, url, type));
    }
    return myMenu;
  }

  @override
  Future<String> getPizzaPhoto(String name, String type) async {
    String url = await mStorage.ref('$type/$name.jpg').getDownloadURL();
    return url;
  }
}
