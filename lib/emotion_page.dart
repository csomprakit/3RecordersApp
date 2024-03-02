import 'package:flutter/material.dart';
import './emotion_history.dart';
import './emotion_event_form.dart';
import 'Database/emotion_event_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmotionPage extends StatefulWidget{
  final EmotionEventDao _emotiondao;
  const EmotionPage(this._emotiondao, {super.key});

  @override
  State<EmotionPage> createState() => _EmotionPageState();
}

class _EmotionPageState extends State<EmotionPage> {
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
          child: Text('Emotion Page',
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
          EmotionEventForm(widget._emotiondao, _useCupertinoStyle),
          SizedBox(height: 15),
          _useCupertinoStyle
              ? CupertinoButton.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmotionHistory(widget._emotiondao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.emotionHistoryButton),
          )
              : ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmotionHistory(widget._emotiondao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.emotionHistoryButton),
          ),
        ],
      ),
    );
  }
}
