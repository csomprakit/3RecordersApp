import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math';
import './shared_count.dart';
import 'Database/diet_event_dao.dart';
import 'Database/diet_event_entity.dart';



class DietEventForm extends StatefulWidget {
  final bool _useCupertinoStyle;
  final DietEventDao _dao;
  const DietEventForm(this._dao, this._useCupertinoStyle,{super.key});

  @override
  createState() => _DietEventFormState();
}

class _DietEventFormState extends State<DietEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _foodController = TextEditingController();
  TextEditingController _servingController = TextEditingController();
  List<String> foods = [];

  @override
  void initState() {
    super.initState();
    getFoodList();
  }

  Future<void> getFoodList() async {
    final dietEvents = await widget._dao.getAllDietEvents();
    setState(() {
      foods = dietEvents.map((event) => event.food).toSet().toList();
    });
  }

  // a callback method to handle user input
  void _onSavePressed() async{
    print('User tried to save data');
    if(_formKey.currentState?.validate() ?? false) {
      final random = Random();
      final id = random.nextInt(1000000);
      final event = DietEventEntity(id:id, food: _foodController.text,
          servings: int.parse(_servingController.text));
      if(!foods.contains(_foodController.text))
        {
          foods.add(_foodController.text);
        }
      await widget._dao.insertDietEvent(event);
      getFoodList();
      _formKey.currentState!.reset();
      context.read<SharedCount>().updateCount(DateTime.now(), 'Diet event');
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
                  Text(AppLocalizations.of(context)!.addFood,
                      style: TextStyle(fontSize: 40)),
                  Text(AppLocalizations.of(context)!.foodDropDown),
                  widget._useCupertinoStyle
                      ? CupertinoTextField(
                    controller: _foodController,
                    keyboardType: TextInputType.text,
                  )
                      : TextField(
                    controller: _foodController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15),
                  widget._useCupertinoStyle
                      ? CupertinoButton(
                    onPressed: _dietPicker,
                    child: Text('${AppLocalizations.of(context)!.selectFood}'
                        '  ${_foodController.text}'),
                  )
                  : DropdownMenu(dropdownMenuEntries:
                  foods.map<DropdownMenuEntry<String>>
                    ((String food){
                    return DropdownMenuEntry<String>(
                      value: food,
                      label: food,
                    );
                  }).toList(),
                    controller: _foodController,
                  ),
                  SizedBox(height: 15),
                  Text(AppLocalizations.of(context)!.numServing),
                  widget._useCupertinoStyle
                      ? CupertinoTextField(
                    controller: _servingController,
                    keyboardType: TextInputType.number,
                  )
                      : TextField(
                    controller: _servingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText:AppLocalizations.
                    of(context)!.servingInput),
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
                ]
            )
        )
    );
  }
  void _dietPicker() {
    int selectedIndex = foods.indexOf(_foodController.text);
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 220,
        color: Colors.white,
        child: CupertinoPicker(
          itemExtent: 40.0,
          scrollController: FixedExtentScrollController(
            initialItem: selectedIndex,
          ),
          onSelectedItemChanged: (int index) {
            setState(() {
              _foodController.text = foods[index];
            });
          },
          children: foods.map((food) => Center(
            child: Text(food),
          )).toList(),
        ),
      ),
    );
  }
}

