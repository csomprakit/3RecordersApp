import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Database/diet_event_dao.dart';
import 'Database/diet_database.dart';
import 'Database/emotion_event_dao.dart';
import 'Database/emotion_database.dart';
import 'Database/workout_event_dao.dart';
import 'Database/workout_database.dart';
import './app_navigation.dart';
import './shared_count.dart';
import './l10n/l10n.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dietdatabase = await $FloorDietDatabase.databaseBuilder('diet.db').build();
  final _dietdao = dietdatabase.dietEventDao;
  final emotiondatabase = await $FloorEmotionDatabase.databaseBuilder('emotion.db').build();
  final _emotiondao = emotiondatabase.emotionEventDao;
  final workoutdatabase = await $FloorWorkoutDatabase.databaseBuilder('workout.db').build();
  final _workoutdao = workoutdatabase.workoutEventDao;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SharedCount(0, DateTime.now(), 1, 'None'),
        ),
      ],
      child: MyApp(_dietdao, _emotiondao, _workoutdao),
    ),
  );
}

class MyApp extends StatefulWidget {
  final DietEventDao _dietdao;
  final EmotionEventDao _emotiondao;
  final WorkoutEventDao _workoutdao;

  MyApp(this._dietdao, this._emotiondao,this._workoutdao,{super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BeamerDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      transitionDelegate: NoAnimationTransitionDelegate(),
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) => AppNavigationPage(widget._dietdao,
          widget._emotiondao, widget._workoutdao),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Homework4',
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}