import 'package:flutter/material.dart';

class FoodLogHistoryPage extends StatefulWidget {
  const FoodLogHistoryPage({super.key});
  
  @override
  State<FoodLogHistoryPage> createState() => _FoodLogHistoryPageState();
}

class _FoodLogHistoryPageState extends State<FoodLogHistoryPage> {
  DateTime _selectedDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Log History'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Calendar Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(
                                _selectedDate.year,
                                _selectedDate.month - 1,
                                _selectedDate.day,
                              );
                            });
                          },
                          icon: const Icon(Icons.chevron_left),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(
                                _selectedDate.year,
                                _selectedDate.month + 1,
                                _selectedDate.day,
                              );
                            });
                          },
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCalendarGrid(),
              ],
            ),
          ),
          
          // Daily Logs Section
          Expanded(
            child: _buildDailyLogs(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;
    
    return Column(
      children: [
        // Weekday headers
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        
        // Calendar days
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 2;
              
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const Expanded(child: SizedBox(height: 40));
              }
              
              final isToday = dayNumber == DateTime.now().day &&
                  _selectedDate.month == DateTime.now().month &&
                  _selectedDate.year == DateTime.now().year;
              
              final hasLog = _hasLogForDate(dayNumber);
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, dayNumber);
                    });
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isToday
                          ? Theme.of(context).colorScheme.primary
                          : hasLog
                              ? Theme.of(context).colorScheme.primaryContainer
                              : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        dayNumber.toString(),
                        style: TextStyle(
                          color: isToday
                              ? Theme.of(context).colorScheme.onPrimary
                              : hasLog
                                  ? Theme.of(context).colorScheme.onPrimaryContainer
                                  : null,
                          fontWeight: isToday ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
  
  Widget _buildDailyLogs() {
    final selectedDateStr = _formatDate(_selectedDate);
    final dayLogs = _getLogsForDate(_selectedDate);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Food Log - $selectedDateStr',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        if (dayLogs.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No food logged for this day',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start logging your meals to track your progress',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: dayLogs.length,
              itemBuilder: (context, index) {
                final log = dayLogs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        log['icon'] as IconData,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      log['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${log['calories']} cal • ${log['serving']}',
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          log['time'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          log['meal'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _showLogDetails(context, log);
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
  
  void _showLogDetails(BuildContext context, Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(log['name'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meal: ${log['meal']}'),
            Text('Time: ${log['time']}'),
            Text('Calories: ${log['calories']}'),
            Text('Serving: ${log['serving']}'),
            const SizedBox(height: 16),
            Text(
              'Nutritional Information:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Protein: ${log['protein']}g'),
            Text('Carbs: ${log['carbs']}g'),
            Text('Fat: ${log['fat']}g'),
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
  
  bool _hasLogForDate(int day) {
    // Simulate some days having logs
    return day % 3 == 0 || day % 5 == 0;
  }
  
  List<Map<String, dynamic>> _getLogsForDate(DateTime date) {
    // Return dummy data for demonstration
    if (_hasLogForDate(date.day)) {
      return [
        {
          'name': 'Oatmeal with Berries',
          'calories': 250,
          'serving': '1 bowl',
          'time': '8:00 AM',
          'meal': 'Breakfast',
          'icon': Icons.restaurant,
          'protein': 8,
          'carbs': 45,
          'fat': 5,
        },
        {
          'name': 'Grilled Chicken Salad',
          'calories': 320,
          'serving': '1 large',
          'time': '12:30 PM',
          'meal': 'Lunch',
          'icon': Icons.restaurant,
          'protein': 25,
          'carbs': 15,
          'fat': 12,
        },
        {
          'name': 'Greek Yogurt',
          'calories': 100,
          'serving': '1 cup',
          'time': '3:00 PM',
          'meal': 'Snack',
          'icon': Icons.local_drink,
          'protein': 17,
          'carbs': 6,
          'fat': 0.4,
        },
        {
          'name': 'Salmon with Vegetables',
          'calories': 380,
          'serving': '1 plate',
          'time': '7:00 PM',
          'meal': 'Dinner',
          'icon': Icons.restaurant,
          'protein': 30,
          'carbs': 20,
          'fat': 18,
        },
      ];
    }
    return [];
  }
  
  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }
  
  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
