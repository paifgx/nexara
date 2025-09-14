import 'package:flutter/material.dart';

/// Week screen showing weekly productivity overview and trends.
class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week Overview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // TODO: Date picker
            },
            tooltip: 'Select week',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Week Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This Week',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMetric(context, '72%', 'Productive', theme.colorScheme.secondary),
                          _buildMetric(context, '15/21', 'Check-ins', theme.colorScheme.primary),
                          _buildMetric(context, '5', 'Streak', theme.colorScheme.tertiary),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Productivity Heatmap
              Text(
                'Productivity Heatmap',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 60),
                          Expanded(child: Center(child: Text('Morning', style: theme.textTheme.labelSmall))),
                          Expanded(child: Center(child: Text('Afternoon', style: theme.textTheme.labelSmall))),
                          Expanded(child: Center(child: Text('Evening', style: theme.textTheme.labelSmall))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) => 
                        _buildHeatmapRow(context, day),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Achievements
              Text(
                'Achievements',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildAchievementBadge(context, Icons.local_fire_department, '5 Day Streak'),
                  _buildAchievementBadge(context, Icons.star, 'First Week'),
                  _buildAchievementBadge(context, Icons.trending_up, '80% Productive'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, String value, String label, Color color) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildHeatmapRow(BuildContext context, String day) {
    final theme = Theme.of(context);
    final random = [0.3, 0.7, 0.9, 0.5, 0.8, 0.4, 0.6]; // Placeholder data
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(day, style: theme.textTheme.bodySmall),
          ),
          ...List.generate(3, (index) => 
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(
                        random[day.length % random.length] * (index + 1) / 3,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: theme.colorScheme.primaryContainer,
    );
  }
}
