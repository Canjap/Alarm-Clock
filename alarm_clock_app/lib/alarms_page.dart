import 'package:alarm_clock_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {

  bool isVisible = false; 
  late Timer _timer;
  TimeOfDay timeRN = TimeOfDay.now();


  void changeOpacity(bool isVisible) {
    setState(() {
      this.isVisible = !isVisible;
    });
  }
  @override
  void initState() {
    super.initState();
    _timer =  Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    
  }

  void _update() {
    setState(() {  
      timeRN = TimeOfDay.now();
      print(timeRN);
    });
  }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("New Alarms",),
          ),
          for (var selectedTime in appState.alarmTimes)

            SwitchTileWithBool(selectedTime: selectedTime, timeRN: timeRN,),

            Stack(
              children: [
                AddAlarm(changeOpacity),
                EnterAlarm(startTime: timeRN,),
              ],
            ),
        ],
      ),
    );
  }
}

class SwitchTileWithBool extends StatefulWidget {
  const SwitchTileWithBool({
    super.key,
    required this.selectedTime,
    required this.timeRN, 
  });
  final TimeOfDay selectedTime;
  final TimeOfDay timeRN; 
  @override
  State<SwitchTileWithBool> createState() => _SwitchTileWithBoolState();
}

class _SwitchTileWithBoolState extends State<SwitchTileWithBool> {

  bool _toggled = false;
  int onOff =  0;




  int getMinutesDiff(TimeOfDay tod1, TimeOfDay tod2) {
    int difference = (tod1.hour * 60 + tod1.minute) - (tod2.hour * 60 + tod2.minute);
    if (difference < 0){
      return (tod1.hour * 60 + tod1.minute + 24*60) - (tod2.hour * 60 + tod2.minute);
    } 
    return difference;
  }


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SwitchListTile(
      value: _toggled, 
      activeColor: Colors.amber,
      onChanged: (bool value) {
        setState(() {
          _toggled = value;
          appState.onAlarms.add(widget.selectedTime);
          Future<int>.delayed(Duration(minutes: getMinutesDiff(widget.selectedTime, widget.timeRN)),
          () {return 100;},
          ).then((value) {
            onOff++;
            if(onOff % 2 == 1)
              {appState.alarmOn(widget.selectedTime);}
            else{
              appState.onAlarms.remove(widget.selectedTime);
            }
            print(appState.alarmTimes);
            print(appState.onAlarms);
          });
        });
      },
      title: Text("${Duration(minutes: getMinutesDiff(widget.selectedTime, widget.timeRN))}"),);
  }
}
//widget.selectedTime.toString()

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
  const EnterAlarm({
    super.key,
  required this.startTime, 
  });

  final TimeOfDay startTime;

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
                  initialTime: widget.startTime,
                  initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                      appState.toggleAlarmsList(selectedTime);
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
