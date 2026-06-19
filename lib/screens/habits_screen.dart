import 'package:flutter/material.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final List<Map<String, dynamic>> habits = [
    {
      'title': 'Exercise',
      'completed': false,
    },
    {
      'title': 'Read 20 Pages',
      'completed': true,
    },
    {
      'title': 'Coding Practice',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final completedCount =
        habits.where((habit) => habit['completed'] == true).length;

    final progress = completedCount / habits.length;

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
                    title: Text(habits[index]['title']),
                    value: habits[index]['completed'],

                    onChanged: (value) {
                      setState(() {
                        habits[index]['completed'] = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}