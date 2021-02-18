import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/model/history_order.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
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
      'age': account.age,
      'phoneNumber': account.number
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
    account.number = documentSnapshot.get('phoneNumber');
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

  @override
  Future<void> writeOrderDetails(
      List<SultanCart> orders, String address, int price) async {
    Map<String, Object> map = Map<String, Object>();
    //map['orders'] = orders;
    for (int i = 0; i < orders.length; i++) {
      map['itemName${i + 1}'] = orders[i].name;
      map['itemImage${i + 1}'] = orders[i].image;
      map['itemQuantity${i + 1}'] = orders[i].quantity;
      map['itemPrice${i + 1}'] = orders[i].price;
    }
    map['address'] = address;
    map['price'] = price;
    map['currentTime'] = DateTime.now().toString();
    map['numoffood'] = orders.length;
    await database
        .collection('users')
        .doc(mAuth.currentUser.email)
        .collection('orders')
        .doc()
        .set(map);
  }

  @override
  Future<List<SultanCart>> getOrdersHistory() async {
    List<SultanCart> historyOrders = List<SultanCart>();
    QuerySnapshot allDocuments = await database
        .collection('users')
        .doc(mAuth.currentUser.email)
        .collection('orders')
        .get();
    for (QueryDocumentSnapshot document in allDocuments.docs) {
      int i = 1;
      while (true) {
        if (document.get('itemName$i') != null) {
          SultanCart sultanCart = SultanCart();
          sultanCart.name = document.get('itemName$i');
          sultanCart.quantity = document.get('itemQuantity$i');
          sultanCart.name = document.get('itemImage$i');

          historyOrders.add(sultanCart);
        } else
          break;
      }
    }
    return historyOrders;
  }

  @override
  Future<List<HistoryOrder>> getOldHistory() async {
    List<HistoryOrder> oldOrders = List<HistoryOrder>();
    QuerySnapshot querySnapshot = await database
        .collection('users')
        .doc(mAuth.currentUser.email)
        .collection('orders')
        .orderBy('currentTime')
        .get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      HistoryOrder oldHistory = HistoryOrder();
      List<SultanCart> allfood = List<SultanCart>();

      oldHistory.address = document.get('address');
      oldHistory.price = document.get('price').toString();
      oldHistory.time = document.get('currentTime');

      int i = document.get('numoffood');
      for (int x = 0; x < i; x++) {
        SultanCart sultanCart = SultanCart();
        sultanCart.name = document.get('itemName${x + 1}');
        sultanCart.quantity = document.get('itemQuantity${x + 1}');
        sultanCart.image = document.get('itemImage${x + 1}');
        sultanCart.price = document.get('itemPrice${x + 1}');
        allfood.add(sultanCart);
      }
      oldHistory.foodList = allfood;
      oldOrders.add(oldHistory);
    }

    return oldOrders;
  }
}
