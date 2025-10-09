import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool showRemaining = true;
  int currentPage = 0;

  // Sample data for charts
  final List<FlSpot> expenditureData = [
    const FlSpot(0, 1650),
    const FlSpot(1, 1680),
    const FlSpot(2, 1620),
    const FlSpot(3, 1700),
    const FlSpot(4, 1675),
    const FlSpot(5, 1690),
    const FlSpot(6, 1665),
  ];

  final List<FlSpot> weightData = [
    const FlSpot(0, 85.2),
    const FlSpot(1, 85.0),
    const FlSpot(2, 84.8),
    const FlSpot(3, 84.6),
    const FlSpot(4, 84.4),
    const FlSpot(5, 84.2),
    const FlSpot(6, 84.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: const DashboardPageContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.secondaryDark,
        border: Border(
          top: BorderSide(color: AppTheme.textTertiary, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _buildNavItem(Icons.dashboard, 'Dashboard', true,
                    onTap: () {
                  // Already on dashboard
                }),
              ),
              Expanded(
                child: _buildNavItem(Icons.edit_note, 'Log', false, onTap: () {
                  context.push('/log');
                }),
              ),
              Expanded(
                child:
                    _buildNavItem(Icons.restaurant, 'Meals', false, onTap: () {
                  context.push('/meals');
                }),
              ),
              Expanded(
                child: _buildNavItem(Icons.person, 'Profile', false, onTap: () {
                  context.push('/profile');
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.textPrimary : AppTheme.textTertiary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      isActive ? AppTheme.textPrimary : AppTheme.textTertiary,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

class DashboardPageContent extends StatefulWidget {
  const DashboardPageContent({super.key});

  @override
  State<DashboardPageContent> createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<DashboardPageContent> {
  bool showRemaining = true;
  int currentPage = 0;

  // Sample data for charts
  final List<FlSpot> expenditureData = [
    const FlSpot(0, 1650),
    const FlSpot(1, 1680),
    const FlSpot(2, 1620),
    const FlSpot(3, 1700),
    const FlSpot(4, 1675),
    const FlSpot(5, 1690),
    const FlSpot(6, 1665),
  ];

  final List<FlSpot> weightData = [
    const FlSpot(0, 85.2),
    const FlSpot(1, 85.0),
    const FlSpot(2, 84.8),
    const FlSpot(3, 84.6),
    const FlSpot(4, 84.4),
    const FlSpot(5, 84.2),
    const FlSpot(6, 84.0),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildDailyNutrition(),
            const SizedBox(height: 32),
            _buildInsightsAndAnalytics(),
            const SizedBox(height: 32),
            _buildSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final now = DateTime.now();
    final dayName = _getDayName(now.weekday);
    final monthName = _getMonthName(now.month);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$dayName, $monthName ${now.day}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'DASHBOARD',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Daily Nutrition',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
        ),
      ],
    );
  }

  Widget _buildDailyNutrition() {
    return Column(
      children: [
        _buildCalorieSummary(),
        const SizedBox(height: 24),
        _buildMacronutrients(),
        const SizedBox(height: 24),
        _buildToggleButtons(),
        const SizedBox(height: 16),
        _buildPaginationDots(),
      ],
    );
  }

  Widget _buildCalorieSummary() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '0',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
              ),
              Text(
                'Consumed',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  children: [
                    // Background circle - larger and more subtle
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.textTertiary.withOpacity(0.2),
                          width: 12,
                        ),
                      ),
                    ),
                    // Progress circle - almost full blue arc
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 0.6),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return CircularProgressIndicator(
                              value: value,
                              strokeWidth: 8,
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeCap: StrokeCap.round,
                            );
                          },
                        ),
                      ),
                    ),
                    // Center content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1327',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: AppTheme.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Remaining',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.textSecondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '1327',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
              ),
              Text(
                'Target',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMacronutrients() {
    return Column(
      children: [
        _buildMacroRow('Protein', '134 / 134g', 1.0, Colors.orange),
        const SizedBox(height: 16),
        _buildMacroRow('Fat', '44 / 44g', 1.0, Colors.yellow),
        const SizedBox(height: 16),
        _buildMacroRow('Carbs', '98 / 98g', 1.0, Colors.green),
      ],
    );
  }

  Widget _buildMacroRow(
      String name, String value, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppTheme.textTertiary,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => showRemaining = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: showRemaining
                    ? AppTheme.secondaryDark
                    : AppTheme.textPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Consumed',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: showRemaining
                          ? AppTheme.textPrimary
                          : AppTheme.primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => showRemaining = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: showRemaining
                    ? AppTheme.textPrimary
                    : AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Remaining',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: showRemaining
                          ? AppTheme.primaryDark
                          : AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaginationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == currentPage
                ? AppTheme.textPrimary
                : AppTheme.textTertiary,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildInsightsAndAnalytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights & Analytics',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildChartCard(
                'Expenditure',
                'Last 7 Days',
                expenditureData,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildChartCard(
                'Weight Trend',
                'Last 7 Days',
                weightData,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartCard(
      String title, String subtitle, List<FlSpot> data, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: false,
                    color: color,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: color,
                          strokeWidth: 2,
                          strokeColor: AppTheme.textPrimary,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food Search - Coming Soon!')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search for a food',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Barcode Scanner - Coming Soon!')),
                );
              },
              child: const Icon(
                Icons.qr_code_scanner,
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('AI Food Recognition - Coming Soon!')),
                );
              },
              child: const Icon(
                Icons.auto_awesome,
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY'
    ];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'JANUARY',
      'FEBRUARY',
      'MARCH',
      'APRIL',
      'MAY',
      'JUNE',
      'JULY',
      'AUGUST',
      'SEPTEMBER',
      'OCTOBER',
      'NOVEMBER',
      'DECEMBER'
    ];
    return months[month - 1];
  }
}
