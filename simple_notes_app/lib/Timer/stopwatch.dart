import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Timer/StopwatchProvider.dart';

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
                child: const Text("Start"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: !stopwatchProvider.isRunning &&
                        stopwatchProvider.elapsedTime == 0
                    ? null
                    : stopwatchProvider.stopStopwatch,
                child: const Text("Stop"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: stopwatchProvider.resetStopwatch,
                child: const Text("Reset"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: stopwatchProvider.isRunning
                ? stopwatchProvider.recordLap
                : null,
            child: const Text("Lap"),
          ),
          const SizedBox(height: 20),

          // List of laps
          ListView.builder(
            shrinkWrap: true, // Allow ListView to take only the necessary space
            physics:
                const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: stopwatchProvider.laps.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text("Lap ${index + 1}: ${stopwatchProvider.laps[index]}"),
                subtitle: Text(
                    "Lap Time: ${stopwatchProvider.lapDifferences[index]}"),
              );
            },
          ),
        ],
      ),
    );
  }
}
