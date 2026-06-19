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

                  const SizedBox(height: 8),

                  Text(
                    '${(mission.progress * 100).toInt()}%',
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