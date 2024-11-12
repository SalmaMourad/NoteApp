import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/TimerProvider_Screen.dart';
import 'package:simple_notes_app/Timer/StopwatchProvider.dart';
import 'package:simple_notes_app/Timer/Stopwatch.dart';
import 'package:simple_notes_app/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StopwatchProvider(),
          child: CustomizableStopwatch(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ToggleWidgetsScreen(),
      ),
    );
  }
}

class ToggleWidgetsScreen extends StatefulWidget {
  @override
  _ToggleWidgetsScreenState createState() => _ToggleWidgetsScreenState();
}

class _ToggleWidgetsScreenState extends State<ToggleWidgetsScreen> {
  bool isWidget1Selected = true;

  void toggleWidgets() {
    setState(() {
      isWidget1Selected = !isWidget1Selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 110,
              ),
              ElevatedButton(
                onPressed: toggleWidgets,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWidget1Selected
                      ? kprimarycolorpink
                      : Colors.grey.shade50,
                ),
                child: const Text('Timer'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: toggleWidgets,
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isWidget1Selected
                      ? kprimarycolorpink
                      : Colors.grey.shade50,
                ),
                child: const Text('Stop Watch'),
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Conditional Rendering of Widgets
              isWidget1Selected ? TimerScreen() : CustomizableStopwatch(),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
