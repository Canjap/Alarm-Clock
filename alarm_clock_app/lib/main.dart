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
        title: "Alarm Clock App",
        theme: ThemeData(
          useMaterial3: true, 
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black26),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentTime = DateTime.now();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var timeNow = appState.currentTime;
    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text("$timeNow"),
        ],
      ),
    );
  }
}
