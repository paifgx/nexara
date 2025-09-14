import 'package:flutter/material.dart';

/// Texts screen for managing custom reminder texts.
class TextsScreen extends StatelessWidget {
  const TextsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Sample reminder texts
    final texts = [
      'How\'s it going? Productive or just busy?',
      'Quick check: Are you making progress or spinning wheels?',
      'Time to reflect: Productive work or busywork?',
      'Pause and think: Is this moving the needle?',
      'Check-in time: Creating value or just staying busy?',
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Texts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add new text
            },
            tooltip: 'Add new text',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Info Card
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Customize the reminder texts that appear in your notifications',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Text Categories
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (value) {},
                ),
                FilterChip(
                  label: const Text('Morning'),
                  selected: false,
                  onSelected: (value) {},
                ),
                FilterChip(
                  label: const Text('Afternoon'),
                  selected: false,
                  onSelected: (value) {},
                ),
                FilterChip(
                  label: const Text('Evening'),
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Reminder Texts List
            ...texts.map((text) => _buildTextItem(context, text)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new text
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTextItem(BuildContext context, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.format_quote),
        title: Text(text),
        subtitle: const Text('Used 3 times • Morning'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            // TODO: Handle menu action
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'favorite',
              child: Text('Mark as Favorite'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
