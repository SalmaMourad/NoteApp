import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/StopwatchProvider.dart';
import 'package:simple_notes_app/constants.dart';

class CustomizableStopwatch extends StatelessWidget {
  const CustomizableStopwatch({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the StopwatchProvider
    var stopwatchProvider = Provider.of<StopwatchProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer display and buttons
          Text(
            stopwatchProvider.formatTime(stopwatchProvider.elapsedTime),
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: stopwatchProvider.isRunning
                    ? null
                    : stopwatchProvider.startStopwatch,
                child: Text(
                  "Start",
                  style: TextStyle(color: kprimarycolorpink),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: !stopwatchProvider.isRunning &&
                        stopwatchProvider.elapsedTime == 0
                    ? null
                    : stopwatchProvider.stopStopwatch,
                child: Text(
                  "Stop",
                  style: TextStyle(color: kprimarycolorpink),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: stopwatchProvider.resetStopwatch,
                child: Text(
                  "Reset",
                  style: TextStyle(color: kprimarycolorpink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: stopwatchProvider.isRunning
                ? stopwatchProvider.recordLap
                : null,
            child: Text(
              "Lap",
              style: TextStyle(color: kprimarycolorpink),
            ),
          ),
          // const SizedBox(height: 10),

          // List of laps
          ListView.builder(
            shrinkWrap: true, // Allow ListView to take only the necessary space
            physics:
                const AlwaysScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: stopwatchProvider.laps.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Lap ${index + 1}: ${stopwatchProvider.lapDifferences[index]}"),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("overall time: ${stopwatchProvider.laps[index]}"),
                ],
              );
              // ListTile(
              // title:/
              // Text("Lap ${index + 1}: ${stopwatchProvider.laps[index]}"),
              // subtitle: Text(
              // "Lap Time: ${stopwatchProvider.lapDifferences[index]}"),
              // );
            },
          ),
        ],
      ),
    );
  }
}
