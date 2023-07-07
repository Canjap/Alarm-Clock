import 'package:alarm_clock_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {

  bool isVisible = false; 

  void changeOpacity(bool isVisible) {
    setState(() {
      this.isVisible = !isVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final player = AudioPlayer();

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("New Alarms",),
          ),
          for (var selectedTime in appState.alarmTimes)
            Card(
              shadowColor: Colors.black38,
              elevation: 10.0,
              child: Row(
                children: [
                  Text("$selectedTime"),
                  Expanded(child: ElevatedButton(
                    onPressed: () async {
                      await player.play(AssetSource("alarm_sound.wav"));
                    },
                    child: Text("alarm"),
                    )
                  )
                ],
              ),
            ),
            Stack(
              children: [
                AddAlarm(changeOpacity),
                EnterAlarm(),
              ],
            )
        ],
      ),
    );
  }
}

class AddAlarm extends StatefulWidget {

  late final Function(bool) callback; //function saved as var: a "bridge" for functions to get one from widget to another

  AddAlarm(this.callback); 
  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {

  bool isVisible = false;

  void click() {
    widget.callback(isVisible); //accesses the addAlarm widget and gets the callback var (which is a function)
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => click(), 
    icon: Icon(Icons.add),
    );
  }
}

class EnterAlarm extends StatefulWidget {
  const EnterAlarm({super.key});

  @override
  State<EnterAlarm> createState() => _EnterAlarmState();
}

class _EnterAlarmState extends State<EnterAlarm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: Colors.blueAccent
    );
    var appState = context.watch<MyAppState>();
    var selectedTime = appState.selectedTime;

    return Card(
        elevation: 10,
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ButtonTheme(
            minWidth: 100,
            height: 100,
            child: ElevatedButton(
              onPressed: () async {
                final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context, 
                  initialTime: selectedTime,
                  initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                      print(selectedTime);
                      appState.toggleAlarmsList(selectedTime);
                      print(appState.alarmTimes);
                    });
                  }
              },
              child: Text("set alarm", style: style,),
            ),
          ),
        ),
      );
  }
}
