import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Today screen showing daily productivity summary and check-ins.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Manual check-in
            },
            tooltip: 'Manual check-in',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        '67%',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ).animate().fadeIn().scale(),
                      const SizedBox(height: 8),
                      Text(
                        'Productive',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatChip(
                            context,
                            icon: Icons.check_circle,
                            label: '2/3',
                            color: theme.colorScheme.secondary,
                          ),
                          _buildStatChip(
                            context,
                            icon: Icons.local_fire_department,
                            label: '5 day streak',
                            color: theme.colorScheme.tertiary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
              
              const SizedBox(height: 24),
              
              // Today's Check-ins
              Text(
                'Today\'s Check-ins',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // Placeholder check-in items
              _buildCheckInItem(
                context,
                time: '09:30 AM',
                status: 'Productive',
                isProductive: true,
                note: 'Working on Flutter project',
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
              
              _buildCheckInItem(
                context,
                time: '01:15 PM',
                status: 'Just Busy',
                isProductive: false,
                note: 'Too many meetings',
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
              
              _buildCheckInItem(
                context,
                time: '04:45 PM',
                status: 'Pending',
                isProductive: null,
                note: null,
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
    );
  }

  Widget _buildCheckInItem(
    BuildContext context, {
    required String time,
    required String status,
    required bool? isProductive,
    String? note,
  }) {
    final theme = Theme.of(context);
    final color = isProductive == null 
        ? theme.colorScheme.outline
        : isProductive 
            ? theme.colorScheme.secondary
            : theme.colorScheme.tertiary;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            isProductive == null 
                ? Icons.schedule
                : isProductive 
                    ? Icons.trending_up
                    : Icons.trending_flat,
            color: color,
          ),
        ),
        title: Text(time),
        subtitle: note != null ? Text(note) : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
