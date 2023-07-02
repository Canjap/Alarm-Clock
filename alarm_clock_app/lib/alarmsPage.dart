import 'package:flutter/material.dart';

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: addAlarm()
          ),
      ]
      ),
    );
  }
}



class addAlarm extends StatelessWidget {

  var initialTime;
  @override
  Widget build(BuildContext context) {
    return IconButton(
    onPressed: () {
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        child: ElevatedButton(
          child: Text("Choose time"),
          onPressed: () async {
            final TimeOfDay? timeOfDay = await showTimePicker(
              context: context, 
              initialTime: initialTime);
          },),
        );
    }, 
    icon: Icon(Icons.add),
    );
  }
}

