import 'package:flutter/material.dart';
import '../models/mission.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  final List<Mission> missions = [
    Mission(
      title: 'Build Helios MVP',
      progress: 0.40,
    ),
    Mission(
      title: 'Learn Flutter',
      progress: 0.65,
    ),
    Mission(
      title: 'Improve Fitness',
      progress: 0.25,
    ),
  ];

  void increaseProgress(int index) {
    setState(() {
      missions[index].progress += 0.10;

      if (missions[index].progress > 1.0) {
        missions[index].progress = 1.0;
      }
    });
  }

  void decreaseProgress(int index) {
    setState(() {
      missions[index].progress -= 0.10;

      if (missions[index].progress < 0.0) {
        missions[index].progress = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission Control'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: missions.length,
        itemBuilder: (context, index) {
          final mission = missions[index];

          final percent = (mission.progress * 100).toInt();

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    mission.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: mission.progress,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        onPressed: () {
                          decreaseProgress(index);
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),

                      Text(
                        '$percent%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          increaseProgress(index);
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}