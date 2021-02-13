import 'package:floor/floor.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';

@dao
abstract class SultanCartDao {
  @insert
  Future<void> insertItemToCart(SultanCart sultanItem);
  @Query('Delete from SultanCart where name =:name')
  Future<void> deleteFromCart(String name);
  @Query('Select * from SultanCart where email =:email')
  Future<List<SultanCart>> selectAllItems(String email);
}
