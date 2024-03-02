import 'Database/emotion_event_entity.dart';
import 'package:flutter/material.dart';
import 'Database/emotion_event_dao.dart';

class EmotionHistory extends StatefulWidget {
  final EmotionEventDao _emotiondao;
  const EmotionHistory(this._emotiondao, {super.key});

  @override
  State<EmotionHistory> createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotion History'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<EmotionEventEntity>>(
          future: widget._emotiondao.getAllEmotionEvents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No emotion events found.');
            } else {
              List<EmotionEventEntity> emotionEvents = snapshot.data!
                  .map((entity) => EmotionEventEntity(id: entity.id,
                  emotion: entity.emotion, occurredOn: entity.occurredOn))
                  .toList();
              return Column(
                children: emotionEvents.map((event) => Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(event.emotion),
                        trailing: Text('${event.occurredOn}'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        if (event.id != null)
                        {
                          EmotionEventEntity? deleteEvent =
                          await widget._emotiondao.getEmotionEventById(event.id!);
                          if (deleteEvent != null)
                          {
                            await widget._emotiondao.deleteEmotionEvent(deleteEvent);
                            setState(() {});
                          }
                        }
                      },
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

