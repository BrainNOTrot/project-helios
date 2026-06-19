import 'package:flutter/material.dart';
import '../models/mission.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  final List<Mission> missions = [
    Mission(title: 'Build Helios MVP', progress: 0.4),
    Mission(title: 'Learn Flutter', progress: 0.6),
    Mission(title: 'Improve Fitness', progress: 0.2),
  ];

  void increaseProgress(int index) {
    setState(() {
      missions[index].progress += 0.1;

      if (missions[index].progress > 1.0) {
        missions[index].progress = 1.0;
      }
    });
  }

  void decreaseProgress(int index) {
    setState(() {
      missions[index].progress -= 0.1;

      if (missions[index].progress < 0.0) {
        missions[index].progress = 0.0;
      }
    });
  }

 
  void addMission() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Mission'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter mission title',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = controller.text.trim();

                if (title.isNotEmpty) {
                  setState(() {
                    missions.add(
                      Mission(title: title),
                    );
                  });
                }

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void deleteMission(int index) {
    setState(() {
      missions.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addMission,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: missions.length,
        itemBuilder: (context, index) {
          final mission = missions[index];
          final percent = (mission.progress * 100).toInt();

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mission.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () => deleteMission(index),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: mission.progress,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => decreaseProgress(index),
                        icon: const Icon(Icons.remove_circle),
                      ),

                      Text(
                        '$percent%',
                        style: const TextStyle(fontSize: 16),
                      ),

                      IconButton(
                        onPressed: () => increaseProgress(index),
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