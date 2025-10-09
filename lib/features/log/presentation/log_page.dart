import 'package:flutter/material.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Log'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyFoods.length,
        itemBuilder: (context, index) {
          final food = _dummyFoods[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.restaurant,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(
                food['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${food['calories']} cal • ${food['serving']}',
              ),
              trailing: Text(
                food['time'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              onTap: () {
                _showFoodDetails(context, food);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddFoodDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Log Food'),
      ),
    );
  }
  
  void _showFoodDetails(BuildContext context, Map<String, dynamic> food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(food['name'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calories: ${food['calories']}'),
            Text('Serving: ${food['serving']}'),
            Text('Time: ${food['time']}'),
            const SizedBox(height: 16),
            Text(
              'Nutritional Information:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Protein: ${food['protein']}g'),
            Text('Carbs: ${food['carbs']}g'),
            Text('Fat: ${food['fat']}g'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Placeholder for edit functionality
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
  
  void _showAddFoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Food'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Calories',
                border: OutlineInputBorder(),
                suffixText: 'cal',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Serving Size',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Food added successfully!'),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// Dummy data for food logs
final List<Map<String, dynamic>> _dummyFoods = [
  {
    'name': 'Grilled Chicken Breast',
    'calories': 165,
    'serving': '100g',
    'time': '12:30 PM',
    'protein': 31,
    'carbs': 0,
    'fat': 3.6,
  },
  {
    'name': 'Brown Rice',
    'calories': 112,
    'serving': '1 cup',
    'time': '12:30 PM',
    'protein': 2.6,
    'carbs': 22,
    'fat': 0.9,
  },
  {
    'name': 'Mixed Vegetables',
    'calories': 25,
    'serving': '1 cup',
    'time': '12:30 PM',
    'protein': 1.1,
    'carbs': 5.4,
    'fat': 0.2,
  },
  {
    'name': 'Greek Yogurt',
    'calories': 100,
    'serving': '1 cup',
    'time': '3:00 PM',
    'protein': 17,
    'carbs': 6,
    'fat': 0.4,
  },
  {
    'name': 'Apple',
    'calories': 95,
    'serving': '1 medium',
    'time': '4:30 PM',
    'protein': 0.5,
    'carbs': 25,
    'fat': 0.3,
  },
  {
    'name': 'Salmon Fillet',
    'calories': 206,
    'serving': '100g',
    'time': '7:00 PM',
    'protein': 22,
    'carbs': 0,
    'fat': 12,
  },
  {
    'name': 'Quinoa',
    'calories': 120,
    'serving': '1/2 cup',
    'time': '7:00 PM',
    'protein': 4.4,
    'carbs': 22,
    'fat': 1.9,
  },
];
