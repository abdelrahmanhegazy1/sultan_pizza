import 'package:floor/floor.dart';

@Entity(tableName: 'Sultan')
class Sultan {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  @ignore
  List<String> ingredients;
  int price;
  String englishName;
  String url;
  String type;
  Sultan(this.name, this.price, this.englishName, this.url, this.type,
      {this.id});
  Sultan.details(this.name, this.ingredients, this.price, this.englishName,
      this.url, this.type,
      {this.id});
}
