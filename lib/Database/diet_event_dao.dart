import 'package:floor/floor.dart';
import 'diet_event_entity.dart';

@dao
abstract class DietEventDao {
  @Query('SELECT * FROM DietEventEntity')
  Future<List<DietEventEntity>> getAllDietEvents();


  @Query('SELECT * FROM DietEventEntity WHERE id = :id')
  Future<DietEventEntity?> getDietEventById(int id);

  @insert
  Future<void> insertDietEvent(DietEventEntity dietEvent);

  @update
  Future<void> updateDietEvent(DietEventEntity dietEvent);

  @delete
  Future<void> deleteDietEvent(DietEventEntity dietEvent);
}