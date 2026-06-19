import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/skill.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  List<Skill> skills = [];

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    final data = await DatabaseHelper.instance.getAllSkills();

    setState(() {
      skills = data.map((e) => Skill.fromMap(e)).toList();
    });
  }

  Future<void> addSkill() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Skill'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Skill Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await DatabaseHelper.instance.insertSkill(
                  Skill(
                    name: controller.text.trim(),
                  ).toMap(),
                );

                Navigator.pop(context);
                await loadSkills();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> addXp(Skill skill, int amount) async {
    skill.xp += amount;

    await DatabaseHelper.instance.updateSkill(
      skill.toMap(),
    );

    await loadSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: skills.isEmpty
          ? const Center(
              child: Text('No skills yet'),
            )
          : ListView.builder(
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];

                final currentLevelXp = skill.xp % 100;
                final progress = currentLevelXp / 100;

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Level ${skill.level}',
                        ),

                        Text(
                          'XP: ${skill.xp}',
                        ),

                        const SizedBox(height: 8),

                        LinearProgressIndicator(
                          value: progress,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  addXp(skill, 10),
                              child: const Text('+10 XP'),
                            ),

                            const SizedBox(width: 8),

                            ElevatedButton(
                              onPressed: () =>
                                  addXp(skill, 50),
                              child: const Text('+50 XP'),
                            ),

                            const Spacer(),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await DatabaseHelper
                                    .instance
                                    .deleteSkill(
                                      skill.id!,
                                    );

                                await loadSkills();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSkill,
        child: const Icon(Icons.add),
      ),
    );
  }
}