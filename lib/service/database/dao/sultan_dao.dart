import 'package:floor/floor.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';

@dao
abstract class SultanDao {
  @insert
  Future<void> insertCachedMenu(List<Sultan> allMenu);
  @Query('Select * FROM Sultan')
  Future<List<Sultan>> getCachedMenu();
  @Query('Select * From Sultan Where name=:name')
  Future<Sultan> getSultanPizzaInfo(String name);
}
