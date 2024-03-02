import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './emotion_page.dart';
import './diet_page.dart';
import './workout_page.dart';
import './bottom_navigation.dart';
import './shared_count.dart';
import 'Database/diet_event_dao.dart';
import 'Database/emotion_event_dao.dart';
import 'Database/workout_event_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'user_page.dart';

class AppNavigationPage extends StatefulWidget {
  final DietEventDao _dietdao;
  final EmotionEventDao _emotiondao;
  final WorkoutEventDao _workoutdao;

  AppNavigationPage(this._dietdao, this._emotiondao, this._workoutdao,
      {Key? key,}) : super(key: key);

  @override
  State<AppNavigationPage> createState() => _AppNavigationPageState();
}

class _AppNavigationPageState extends State<AppNavigationPage> {
  final _beamerKey = GlobalKey<BeamerState>();
  late BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) => UserPage(),
          '/diet': (context, state, data) => BeamPage(
            key: ValueKey('diet'),
            type: BeamPageType.noTransition,
            child: DietPage(widget._dietdao),
          ),
          '/emotion': (context, state, data) => BeamPage(
            key: ValueKey('Emotion'),
            type: BeamPageType.noTransition,
            child: EmotionPage(widget._emotiondao),
          ),
          '/workout': (context, state, data) => BeamPage(
            key: ValueKey('workout'),
            type: BeamPageType.noTransition,
            child: WorkoutPage(widget._workoutdao),
          ),
          '/user': (context, state, data) => BeamPage(
            key: ValueKey('user'),
            type: BeamPageType.noTransition,
            child: UserPage(),
          ),
        },
      ),
    );
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = (context.currentBeamLocation.state as BeamState).uri.path
        == '/diet' ? 0 : (context.currentBeamLocation.state as BeamState).uri.path
        == '/emotion' ? 1 :
    (context.currentBeamLocation.state as BeamState).uri.path
        == '/workout' ? 2
    :3;

    return Scaffold(
      /***
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            '${AppLocalizations.of(context)!.dedicationLevel} '
                '${context.watch<SharedCount>().getDedicationLevel()} \n'
                '${AppLocalizations.of(context)!.lastInputTime} '
                '${context.watch<SharedCount>().getDate()}\t'
                '${AppLocalizations.of(context)!.category} '
                '${context.watch<SharedCount>().getCategory()}',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),***/
      body: Beamer(
        key: _beamerKey,
        routerDelegate: _beamerDelegate,
      ),
      bottomNavigationBar: BottomNavigation(
        beamerDelegate: _beamerDelegate,
        currentIndex: _currentIndex,
      ),
    );
  }
}
