import 'package:floor/floor.dart';

@Entity(tableName: "DietEventEntity")
class DietEventEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;

  String food;
  int servings;

  DietEventEntity({required this.id, required this.food, required this.servings});

  set setFood(String value) {
    this.food = value;
  }

  set setServings(int value) {
    this.servings = value;
  }
}