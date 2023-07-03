import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alarms_page.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white30),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentDateTime = DateTime.now();
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex){
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = AlarmsPage();
        break;
      default:
      throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var dateTimeNow = appState.currentDateTime;
    var dayNow = DateFormat('EEEE, d MMM, yyyy').format(dateTimeNow);
    var timeNow = DateFormat("jm").format(dateTimeNow);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DisplayDay(dayNow: dayNow),
          DisplayTime(timeNow: timeNow),
        ],
      ),
    );
  }
}


class DisplayDay extends Card {
  const DisplayDay({
    super.key,
    required this.dayNow
  });

  final String dayNow;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: Colors.black,  
    );
    return Center(
      child: Card(
        elevation: 20.0,
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(dayNow, style: style,),
        ),
      ),
    );
  }
}

class DisplayTime extends StatelessWidget {
  const DisplayTime({
    super.key,
    required this.timeNow,
  });

  final String timeNow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: Colors.amber,  
    );

    return Center(
      child: Card(
        color: theme.colorScheme.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(timeNow, style: style,),
        ),
      ),
    );
  }
}

