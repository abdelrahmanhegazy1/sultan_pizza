import 'package:floor/floor.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';
import 'package:sultan_pizza/service/database/dao/sultan_cart_dao.dart';
import 'package:sultan_pizza/service/database/dao/sultan_dao.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart'; //generate code

@Database(version: 3, entities: [Sultan, SultanCart])
abstract class SultanDatabase extends FloorDatabase {
  // final SultanDao sultanDao=;
  //final SultanCartDao sultanCartDao;

  SultanDao get sultanDao;
  SultanCartDao get sultanCartDao;
}
