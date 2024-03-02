import 'Database/emotion_event_entity.dart';
import 'package:flutter/material.dart';
import 'shared_count.dart';
import 'package:provider/provider.dart';
import 'Database/emotion_event_dao.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


enum emojis
{
  smile('😃', '😃'), happy( '😆', '😆'), laugh('😂', '😂'), eyeroll('🙄','🙄'),
  shy('☺️', '☺️'), love('😍', '😍'), hearts('🥰', '🥰'), silly('🤪','🤪'),
  sus('🤨', '🤨'), nerd('🤓', '🤓'), smirk('😏','😏'), dissapointed('😔','😔'),
  annoyed('😒', '😒'), uneasy('😕', '😕'), cry('😭','😭'), angry('😠','😠'),
  unhappy('😩','😩'), explode('🤯','🤯'), scared('😱','😱'), cold('🥶','🥶'),
  sick('🤒','🤒'), hurt('🤕','🤕'), think('🤔','🤔'), shocked('😟️','😟️') ;

  const emojis(this.value, this.label);
  final String value;
  final String label;
}

class EmotionEventForm extends StatefulWidget {
  final bool _useCupertinoStyle;
  final EmotionEventDao _emotiondao;
  const EmotionEventForm(this._emotiondao,this._useCupertinoStyle, {super.key});

  @override
  createState() => _EmotionEventFormState();
}

class _EmotionEventFormState extends State<EmotionEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emojiController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // a callback method to handle user input
  void _onSavePressed() async {
    print('User tried to save data');
    if(_formKey.currentState?.validate() ?? false) {
      final random = Random();
      final id = random.nextInt(1000000);
      final event = EmotionEventEntity(id: id, emotion: _emojiController.text,
          occurredOn: int.parse(_dateController.text));
      widget._emotiondao.insertEmotionEvent(event);
      setState(() {});
      _formKey.currentState!.reset();
      context.read<SharedCount>().updateCount(DateTime.now(), 'Emotion event');
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
                  Text(AppLocalizations.of(context)!.addEmotion, style: TextStyle(fontSize: 40)),
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
                  Text(AppLocalizations.of(context)!.emotionDropDown),
                  widget._useCupertinoStyle
                      ? CupertinoButton(
                    onPressed: _emojiPicker,
                    child: Text('${AppLocalizations.of(context)!.selectEmotion}'
                        '${_emojiController.text}'),
                  )
                      : DropdownMenu(
                    dropdownMenuEntries: emojis.values
                        .map<DropdownMenuEntry<emojis>>(
                          (emojis emoji) {
                        return DropdownMenuEntry<emojis>(
                          value: emoji,
                          label: emoji.label,
                        );
                      },
                    ).toList(),
                    controller: _emojiController,
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

  void _emojiPicker() {
    int selectedIndex = emojis.values
        .indexWhere((emoji) => emoji.value == _emojiController.text);
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
              _emojiController.text = emojis.values.elementAt(index).value;
            });
          },
          children: emojis.values.map((emoji) => Center(
            child: Text(emoji.label),
          )).toList(),
        ),
      ),
    );
  }
}
