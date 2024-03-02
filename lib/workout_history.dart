import 'Database/workout_event_entity.dart';
import 'package:flutter/material.dart';
import 'Database/workout_event_dao.dart';


class WorkoutHistory extends StatefulWidget {
  final WorkoutEventDao _workoutdao;
  const WorkoutHistory(this._workoutdao, {super.key});

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout History"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<WorkoutEventEntity>>(
          future: widget._workoutdao.getAllWorkoutEvents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No workout events found.');
            }
            else {
              List<WorkoutEventEntity> workoutEvents = snapshot.data!
                  .map((entity) => WorkoutEventEntity(id: entity.id,
                  occuredOn: entity.occuredOn, workoutType: entity.workoutType,
                  sets: entity.sets) ).toList();
              return Column(
                children: workoutEvents.map((event) => Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(event.workoutType),
                        subtitle: Text('${event.sets} sets'),
                        trailing: Text('${event.occuredOn}'),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async{
                          if(event.id != null)
                          {
                            WorkoutEventEntity? deleteEvent =
                            await widget._workoutdao.getWorkoutEventById(event.id!);
                            if (deleteEvent != null)
                            {
                              await widget._workoutdao.deleteWorkoutEvent(deleteEvent);
                              setState(() {});
                            }
                          }
                        }
                    ),
                  ],
                )).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}


