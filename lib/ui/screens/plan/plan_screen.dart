import 'package:flutter/material.dart';

/// Plan screen for configuring schedule and notification settings.
class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Plan'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Daily Settings
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Settings',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.notifications_active),
                      title: const Text('Daily Reminders'),
                      subtitle: const Text('3 per day'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.do_not_disturb),
                      title: const Text('Quiet Hours'),
                      subtitle: const Text('12:00 PM - 1:00 PM'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Week Schedule
            Text(
              'Weekly Schedule',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            ...['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                .map((day) => _buildDayScheduleCard(context, day)),
          ],
        ),
      ),
    );
  }

  Widget _buildDayScheduleCard(BuildContext context, String day) {
    final isWeekend = day == 'Saturday' || day == 'Sunday';
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isWeekend 
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.primaryContainer,
          child: Text(
            day.substring(0, 3),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isWeekend 
                  ? theme.colorScheme.onSurfaceVariant
                  : theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(day),
        subtitle: Text(isWeekend ? 'No reminders' : '9:00 AM - 6:00 PM'),
        trailing: Switch(
          value: !isWeekend,
          onChanged: (value) {},
        ),
        onTap: () {},
      ),
    );
  }
}
