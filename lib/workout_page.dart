import 'package:flutter/material.dart';
import './workout_event_form.dart';
import './workout_history.dart';
import 'Database/workout_event_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WorkoutPage extends StatefulWidget{
  final WorkoutEventDao _workoutdao;
  const WorkoutPage(this._workoutdao, {super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  bool _useCupertinoStyle = false;
  void _switchStyle() {
    setState(() {
      _useCupertinoStyle = !_useCupertinoStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text('Workout Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          _useCupertinoStyle
              ? CupertinoButton.filled(
            onPressed: _switchStyle,
            child: Text(AppLocalizations.of(context)!.switchStyle),
          )
              : ElevatedButton(
            onPressed: _switchStyle,
            child: Text(AppLocalizations.of(context)!.switchStyle),
          ),
          WorkoutEventForm(widget._workoutdao, _useCupertinoStyle),
          SizedBox(height: 15),
          _useCupertinoStyle
              ? CupertinoButton.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutHistory(widget._workoutdao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.workoutHistoryButton),
          )
              : ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutHistory(widget._workoutdao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.workoutHistoryButton),
          ),
        ],
      ),
    );
  }
}
