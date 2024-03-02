import 'package:floor/floor.dart';

@Entity(tableName: "EmotionEventEntity")
class EmotionEventEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String emotion;
  final int occurredOn;

  EmotionEventEntity({required this.id, required this.emotion, required this.occurredOn});
}