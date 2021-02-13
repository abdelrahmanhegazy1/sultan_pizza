import 'package:floor/floor.dart';

@Entity(tableName: 'SultanCart')
class SultanCart {
  @PrimaryKey(autoGenerate: true)
  int id;
  final String name;
  //int quantity;
  final String email;
  int quantity;
  String image;
  int price;

  SultanCart(
      {this.id,
      this.name,
      this.email,
      this.quantity = 1,
      this.image,
      this.price});
}
