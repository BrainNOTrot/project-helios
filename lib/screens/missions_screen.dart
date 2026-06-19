import 'package:flutter/material.dart';
import '../models/mission.dart';
import '../database/database_helper.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  final List<Mission> missions = [];

  Future<void> increaseProgress(int index) async {
    final mission = missions[index];

    if (mission.progress < 1.0) {
      mission.progress += 0.1;

      if (mission.progress > 1.0) {
        mission.progress = 1.0;
      }

      await DatabaseHelper.instance.updateMission(
        mission.toMap(),
      );

      setState(() {});
    }
  }

  Future<void> decreaseProgress(int index) async {
    final mission = missions[index];

    if (mission.progress > 0.0) {
      mission.progress -= 0.1;

      if (mission.progress < 0.0) {
        mission.progress = 0.0;
      }

      await DatabaseHelper.instance.updateMission(
        mission.toMap(),
      );

      setState(() {});
    }
  }

 
  Future<void> addMission() async {
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
              onPressed: () async {
                final title = controller.text.trim();

                if (title.isNotEmpty) {
                  final mission = Mission(
                    title: title,
                  );

                  final id = await DatabaseHelper.instance.insertMission(
                    mission.toMap(),
                  );

                  mission.id = id;

                  setState(() {
                    missions.add(mission);
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

  Future<void> deleteMission(int index) async {
    final mission = missions[index];

    if (mission.id != null) {
      await DatabaseHelper.instance.deleteMission(
        mission.id!,
      );
    }

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

  Future<void> loadMissions() async {
    final rows = await DatabaseHelper.instance.getAllMissions();

    setState(() {
      missions.clear();

      for (final row in rows) {
        missions.add(
          Mission.fromMap(row),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMissions();
  }
}