import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HELIOS"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Mission Control",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              _sectionCard(
                title: "Mission Status",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Overall Completion"),

                    const SizedBox(height: 12),

                    const LinearProgressIndicator(
                      value: 0.60,
                    ),

                    const SizedBox(height: 8),

                    const Text("60%"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _sectionCard(
                title: "Today's Focus",
                child: const Text(
                  "Build Helios Dashboard",
                ),
              ),

              const SizedBox(height: 16),

              _sectionCard(
                title: "Active Missions",
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• Learn Flutter"),
                    Text("• Build Helios MVP"),
                    Text("• Improve Fitness"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _sectionCard(
                title: "Daily Objectives",
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("✓ Read Flutter Docs"),
                    Text("✓ Remove Counter App"),
                    Text("□ Build Dashboard Layout"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            child,
          ],
        ),
      ),
    );
  }
}
