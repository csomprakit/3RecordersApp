import 'Database/workout_event_entity.dart';
import 'package:flutter/material.dart';
import 'shared_count.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Database/workout_event_dao.dart';
import 'dart:math';


enum exercises
{
  upper1('Bicep Curl', 'Bicep Curl'), upper2( 'Lateral Raise', 'Lateral Raise'),
  upper3('Shoulder Press', 'Shoulder Press'), upper4('Pull up', 'Pull up'),
  upper5('Bench Press','Bench Press'), lower1('Squat', 'Squat'),
  lower2('Lunges', 'Lunges'), lower3('Romanian Dead Lift','Romanian Dead Lift'),
  lower4('Glute Bridge', 'Glute Bridge'), lower5('Calf Raises', 'Calf Raises');

  const exercises(this.value, this.label);
  final String value;
  final String label;
}

class WorkoutEventForm extends StatefulWidget {
  final bool _useCupertinoStyle;
  final WorkoutEventDao _workoutdao;
  const WorkoutEventForm(this._workoutdao, this._useCupertinoStyle, {super.key});

  @override
  createState() => _WorkoutEventFormState();
}

class _WorkoutEventFormState extends State<WorkoutEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _workoutTypeController = TextEditingController();
  TextEditingController _setsController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  // a callback method to handle user input
  void _onSavePressed() {
    print('User tried to save data');
    if(_formKey.currentState?.validate() ?? false) {
      final random = Random();
      final id = random.nextInt(1000000);
      final event = WorkoutEventEntity(id: id, occuredOn: int.parse(_dateController.text),
          workoutType: _workoutTypeController.text,
          sets: int.parse(_setsController.text));
      widget._workoutdao.insertWorkoutEvent(event);
      _formKey.currentState!.reset();
      context.read<SharedCount>().updateCount(DateTime.now(), 'Workout event');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: SafeArea(
            child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(AppLocalizations.of(context)!.addWorkoutEvent,
                      style: TextStyle(fontSize: 40)),
                  Text(AppLocalizations.of(context)!.addDate),
                  widget._useCupertinoStyle
                      ? CupertinoTextField(
                    keyboardType: TextInputType.datetime,
                    controller: _dateController,
                  )
                      : TextField(
                    keyboardType: TextInputType.datetime,
                    controller: _dateController,
                  ),
                  SizedBox(height: 15),
                  Text(AppLocalizations.of(context)!.exerciseType),
                  widget._useCupertinoStyle
                      ? CupertinoButton(
                    onPressed: _exercisePicker,
                    child: Text('${AppLocalizations.of(context)!.selectWorkout}  '
                        '${_workoutTypeController.text}'),
                  )
                      : DropdownMenu(
                    dropdownMenuEntries: exercises.values.map<DropdownMenuEntry<exercises>>
                      ((exercises exercise){
                      return DropdownMenuEntry<exercises>(
                        value: exercise,
                        label: exercise.label,
                      );
                    }).toList(),
                    controller: _workoutTypeController,
                  ),
                  SizedBox(height: 15),
                  Text(AppLocalizations.of(context)!.addSet),
                  widget._useCupertinoStyle
                      ? CupertinoTextField(
                    controller: _setsController,
                    keyboardType: TextInputType.number,
                  )
                      : TextField(
                    controller: _setsController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  widget._useCupertinoStyle
                      ? CupertinoButton.filled(
                    onPressed: _onSavePressed,
                    child: Text(AppLocalizations.of(context)!.saveButton),
                  )
                      : ElevatedButton(
                    onPressed: _onSavePressed,
                    child: Text(AppLocalizations.of(context)!.saveButton),
                  ),
                  SizedBox(height: 15),
                ]
            )
        )
    );
  }

  void _exercisePicker() {
    int selectedIndex = exercises.values
        .indexWhere((exercise) => exercise.value == _workoutTypeController.text);
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        color: Colors.white,
        height: 220,
        child: CupertinoPicker(
          itemExtent: 40.0,
          scrollController: FixedExtentScrollController(
            initialItem: selectedIndex != -1 ? selectedIndex : 0,
          ),
          onSelectedItemChanged: (int index) {
            setState(() {
              _workoutTypeController.text = exercises.values.elementAt(index).value;
            });
          },
          children: exercises.values.map((exercise) => Center(
            child: Text(exercise.label),
          )).toList(),
        ),
      ),
    );
  }
}
