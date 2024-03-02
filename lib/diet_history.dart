import 'package:flutter/material.dart';
import 'Database/diet_event_dao.dart';
import 'Database/diet_event_entity.dart';

class DietHistory extends StatefulWidget {
  final DietEventDao _dietdao;
  const DietHistory(this._dietdao, {super.key});

  @override
  createState() => _DietHistoryState();
}

class _DietHistoryState extends State<DietHistory> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet History'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<DietEventEntity>>(
          future: widget._dietdao.getAllDietEvents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No diet events found.');
            }
            else {
              List<DietEventEntity> dietEvents = snapshot.data!.map((entity) =>
                  DietEventEntity(id:entity.id, food: entity.food,
                      servings: entity.servings)).toList();
              return SingleChildScrollView(
                child: Column(
                  children: dietEvents.map((event) => Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(event.food),
                          subtitle: Text('${event.servings} servings'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editFunction(context, event);
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            if(event.id != null)
                            {
                              DietEventEntity? deleteEvent =
                              await widget._dietdao.getDietEventById(event.id!);
                              if (deleteEvent != null)
                              {
                                await widget._dietdao.deleteDietEvent(deleteEvent);
                                setState(() {});
                              }
                            }
                          }
                      ),
                    ],
                  )).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _editFunction(BuildContext context, DietEventEntity event)
  {
    TextEditingController _foodController = TextEditingController(text: event.food);
    TextEditingController _servingsController =
    TextEditingController(text: event.servings.toString());

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.0),
                TextField(
                  controller: _foodController,
                  decoration: InputDecoration(labelText: 'Food'),
                ),
                TextField(
                  controller: _servingsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Servings'),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        event.food = _foodController.text;
                        event.servings = int.parse(_servingsController.text);
                        await widget._dietdao.updateDietEvent(event);
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ]
        );
      },
    );
  }
}
