import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              AddAlarm(changeOpacity), //changeOp function used as arg so that the addAlarm widget can then use it
              Visibility(visible: isVisible, child: EnterAlarm(),)
        ]
        ),
      ),
    );
  }
}

class AddAlarm extends StatefulWidget {

  late Function(bool) callback; //function saved as var: a "bridge" for functions to get one from widget to another

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
    TimeOfDay selectedTime = TimeOfDay.now();

    return Card(
        elevation: 20.0,
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
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
                  });
                }
            },
            child: Text("set alarm", style: style,),
          ),
        ),
      );
  }
}