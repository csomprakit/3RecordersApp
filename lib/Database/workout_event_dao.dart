import 'package:floor/floor.dart';
import 'workout_event_entity.dart';

@dao
abstract class WorkoutEventDao {
  @Query('SELECT * FROM WorkoutEventEntity')
  Future<List<WorkoutEventEntity>> getAllWorkoutEvents();

  @Query('SELECT * FROM WorkoutEventEntity WHERE id = :id')
  Future<WorkoutEventEntity?> getWorkoutEventById(int id);

  @insert
  Future<void> insertWorkoutEvent(WorkoutEventEntity workoutEvent);

  @update
  Future<void> updateWorkoutEvent(WorkoutEventEntity workoutEvent);

  @delete
  Future<void> deleteWorkoutEvent(WorkoutEventEntity workoutEvent);
}