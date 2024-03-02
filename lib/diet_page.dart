import 'package:flutter/material.dart';
import './diet_history.dart';
import './diet_event_form.dart';
import 'Database/diet_event_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DietPage extends StatefulWidget{
  final DietEventDao _dietdao;
  const DietPage(this._dietdao, {super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
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
          child: Text('Food Page',
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
          DietEventForm(widget._dietdao, _useCupertinoStyle),
          SizedBox(height: 15),
          SizedBox(height: 15),
          _useCupertinoStyle
              ? CupertinoButton.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DietHistory(widget._dietdao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.foodHistoryButton),
          )
              : ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DietHistory(widget._dietdao),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.foodHistoryButton),
          ),
        ],
      ),
    );
  }
}
