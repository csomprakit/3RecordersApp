import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'diet_event_entity.dart';
import 'diet_event_dao.dart';

part 'diet_database.g.dart';

@Database(version: 1, entities: [DietEventEntity])
abstract class DietDatabase extends FloorDatabase {
  DietEventDao get dietEventDao;
}

