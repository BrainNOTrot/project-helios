import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../database/database_helper.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  List<Habit> habits = [];

  @override
  Widget build(BuildContext context) {
    final completedCount =
        habits.where((habit) => habit.completed == true).length;

    final progress =
      habits.isEmpty ? 0.0 : completedCount / habits.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Engine'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              '$completedCount / ${habits.length} Habits Completed',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: progress,
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: habits.length,

                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(habits[index].title),
                    value: habits[index].completed,

                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await DatabaseHelper.instance.deleteHabit(
                          habits[index].id!,
                        );

                        await loadHabits();
                      },
                    ),

                    onChanged: (value) async {
                      setState(() {
                        habits[index].completed = value ?? false;
                      });

                      await DatabaseHelper.instance.updateHabit(
                        habits[index].toMap(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();

          final title = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Habit'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Habit name',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        controller.text.trim(),
                      );
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );

          if (title != null && title.isNotEmpty) {
            await DatabaseHelper.instance.insertHabit({
              'title': title,
              'completed': 0,
            });

            await loadHabits();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final data = await DatabaseHelper.instance.getAllHabits();

    setState(() {
      habits = data.map((e) => Habit.fromMap(e)).toList();
    });
  }
}