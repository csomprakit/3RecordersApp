import 'package:floor/floor.dart';

@Entity(tableName: "WorkoutEventEntity")
class WorkoutEventEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final int occuredOn;
  final String workoutType;
  final int sets;

  WorkoutEventEntity({required this.id, required this.occuredOn,
    required this.workoutType, required this.sets});
}
