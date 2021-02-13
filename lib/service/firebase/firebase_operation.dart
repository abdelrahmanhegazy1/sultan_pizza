import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';

abstract class FirebaseOperation {
  Future<Account> loginAccount(String username, String password);
  Future<bool> registerAccount(Account account);
  Future<Account> getUserInformation(String email);
  Future<List<Sultan>> getSultanMenuOption(String type);
  Future<String> getPizzaPhoto(String name, String type);
}
