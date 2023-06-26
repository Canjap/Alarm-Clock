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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          displayCard(timeNow: timeNow),
        ],
      ),
    );
  }
}


class displayCard extends Card {
  const displayCard({
    super.key,
    required this.timeNow
  });

  final DateTime timeNow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,  
    );
    return Center(
      child: Card(
        elevation: 20.0,
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("$timeNow", style:style),
        ),
      ),
    );
  }
}