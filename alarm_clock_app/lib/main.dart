
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var time = DateTime.now();
  
  void getTime() {
    time  = DateTime.now();
    notifyListeners();
  }

  var alarmTimes = <DateTime>[];

  void addAlarm() {
    if (alarmTimes.contains(time)){
      alarmTimes.remove(time);
    }
    else {
      alarmTimes.add(time);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  var timeRN = context.watch<MyAppState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: timeNow(timeRN: timeRN,)
      ),
    );
  }
}

class timeNow extends StatelessWidget {
  const timeNow({
    super.key,
    required this.timeRN,
  });

  final DateTime timeRN;

  @override
  Widget build(BuildContext context) {


    return Card(
      child: Padding(
        padding: const EdgeInsets.all(202),
        child: Text(
          "$timeRN",
        ),
      ),
    );
  }
}