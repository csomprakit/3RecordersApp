import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'workout_event_entity.dart';
import 'workout_event_dao.dart';

part 'workout_database.g.dart';

@Database(version: 1, entities: [WorkoutEventEntity])
abstract class WorkoutDatabase extends FloorDatabase {
  WorkoutEventDao get workoutEventDao;
}
