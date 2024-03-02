import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'emotion_event_entity.dart';
import 'emotion_event_dao.dart';

part 'emotion_database.g.dart';

@Database(version: 1, entities: [EmotionEventEntity])
abstract class EmotionDatabase extends FloorDatabase {
  EmotionEventDao get emotionEventDao;
}

