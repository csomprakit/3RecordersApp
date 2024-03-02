import 'package:floor/floor.dart';
import 'emotion_event_entity.dart';

@dao
abstract class EmotionEventDao {
  @Query('SELECT * FROM EmotionEventEntity')
  Future<List<EmotionEventEntity>> getAllEmotionEvents();

  @Query('SELECT * FROM EmotionEventEntity WHERE id = :id')
  Future<EmotionEventEntity?> getEmotionEventById(int id);

  @insert
  Future<void> insertEmotionEvent(EmotionEventEntity emotionEvent);

  @update
  Future<void> updateEmotionEvent(EmotionEventEntity emotionEvent);

  @delete
  Future<void> deleteEmotionEvent(EmotionEventEntity emotionEvent);
}