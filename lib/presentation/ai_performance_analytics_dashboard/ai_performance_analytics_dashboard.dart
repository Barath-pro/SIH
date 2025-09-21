import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/achievement_progress_widget.dart';
import './widgets/ai_insights_card.dart';
import './widgets/comparison_widget.dart';
import './widgets/injury_risk_widget.dart';
import './widgets/performance_chart_widget.dart';
import './widgets/performance_metric_card.dart';

class AiPerformanceAnalyticsDashboard extends StatefulWidget {
  const AiPerformanceAnalyticsDashboard({Key? key}) : super(key: key);

  @override
  State<AiPerformanceAnalyticsDashboard> createState() =>
      _AiPerformanceAnalyticsDashboardState();
}

class _AiPerformanceAnalyticsDashboardState
    extends State<AiPerformanceAnalyticsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedPeriod = 'Month';
  String selectedSport = 'Football';

  final List<String> periods = ['Week', 'Month', 'Year'];
  final List<String> sports = ['Football', 'Basketball', 'Tennis', 'Swimming'];

  // Mock data for performance metrics
  final List<Map<String, dynamic>> performanceMetrics = [
    {
      'title': 'Speed Average',
      'value': '24.8',
      'unit': 'km/h',
      'progress': 0.82,
      'progressColor': AppTheme.primaryElectricBlue,
      'trend': '+12% vs last month',
      'isPositiveTrend': true,
    },
    {
      'title': 'Accuracy Score',
      'value': '87.5',
      'unit': '%',
      'progress': 0.875,
      'progressColor': AppTheme.growthGreen,
      'trend': '+5.2% vs last month',
      'isPositiveTrend': true,
    },
    {
      'title': 'Technique Rating',
      'value': '8.4',
      'unit': '/10',
      'progress': 0.84,
      'progressColor': AppTheme.accentGold,
      'trend': '+0.8 vs last month',
      'isPositiveTrend': true,
    },
    {
      'title': 'Endurance Level',
      'value': '76.2',
      'unit': '%',
      'progress': 0.762,
      'progressColor': AppTheme.victoryRed,
      'trend': '-2.1% vs last month',
      'isPositiveTrend': false,
    },
  ];

  // Mock data for charts
  final List<Map<String, dynamic>> speedChartData = [
    {'label': 'Mon', 'value': 22.5},
    {'label': 'Tue', 'value': 24.1},
    {'label': 'Wed', 'value': 23.8},
    {'label': 'Thu', 'value': 25.2},
    {'label': 'Fri', 'value': 24.9},
    {'label': 'Sat', 'value': 26.1},
    {'label': 'Sun', 'value': 24.8},
  ];

  final List<Map<String, dynamic>> accuracyChartData = [
    {'label': 'W1', 'value': 82.5},
    {'label': 'W2', 'value': 85.1},
    {'label': 'W3', 'value': 86.8},
    {'label': 'W4', 'value': 87.5},
  ];

  // Mock data for AI insights
  final List<Map<String, dynamic>> aiInsights = [
    {
      'type': 'improvement',
      'title': 'Speed Performance Trending Up',
      'description':
          'Your speed has improved by 12% over the last month. This consistent improvement indicates excellent training adaptation.',
      'recommendations': [
        'Continue current sprint training regimen',
        'Add interval training twice per week',
        'Focus on proper warm-up routines'
      ],
    },
    {
      'type': 'warning',
      'title': 'Endurance Decline Detected',
      'description':
          'Your endurance levels have decreased by 2.1% this month. This could indicate overtraining or insufficient recovery.',
      'recommendations': [
        'Increase rest days between intense sessions',
        'Focus on aerobic base building',
        'Monitor sleep quality and duration'
      ],
    },
    {
      'type': 'achievement',
      'title': 'Technique Milestone Reached',
      'description':
          'Congratulations! You\'ve achieved an 8.4/10 technique rating, placing you in the top 15% of athletes in your category.',
      'recommendations': [
        'Maintain current technique focus',
        'Consider advanced skill workshops',
        'Share techniques with teammates'
      ],
    },
  ];

  // Mock data for comparison
  final List<Map<String, dynamic>> comparisonData = [
    {
      'metric': 'Speed (km/h)',
      'userValue': 24.8,
      'avgValue': 22.3,
      'unit': '',
    },
    {
      'metric': 'Accuracy (%)',
      'userValue': 87.5,
      'avgValue': 84.2,
      'unit': '',
    },
    {
      'metric': 'Training Hours/Week',
      'userValue': 12.5,
      'avgValue': 15.2,
      'unit': 'h',
    },
  ];

  // Mock data for achievements
  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Speed Demon',
      'description': 'Reach 25 km/h average speed',
      'icon': 'flash_on',
      'progress': 0.99,
      'estimatedTime': '2 days',
    },
    {
      'title': 'Accuracy Master',
      'description': 'Maintain 90% accuracy for a week',
      'icon': 'gps_fixed',
      'progress': 0.72,
      'estimatedTime': '1 week',
    },
    {
      'title': 'Consistency King',
      'description': 'Train 5 days a week for a month',
      'icon': 'event_repeat',
      'progress': 1.0,
      'estimatedTime': null,
    },
  ];

  // Mock data for injury risk
  final Map<String, dynamic> injuryRiskData = {
    'riskLevel': 'Low',
    'riskScore': 25.0,
    'factors': ['High training intensity', 'Previous ankle injury'],
    'recommendations': [
      'Maintain proper warm-up routine',
      'Focus on ankle strengthening exercises',
      'Monitor training load carefully',
      'Ensure adequate recovery time'
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Performance Analytics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showExportDialog,
            icon: CustomIconWidget(
              iconName: 'file_download',
              color: AppTheme.textHighEmphasisLight,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStickyHeader(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildDetailedMetricsTab(),
                _buildComparisonsTab(),
                _buildRecommendationsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildStickyHeader() {
    return Container(
      color: AppTheme.lightTheme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPeriodSelector(),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildSportFilter(),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppTheme.primaryElectricBlue,
            unselectedLabelColor: AppTheme.textMediumEmphasisLight,
            indicatorColor: AppTheme.primaryElectricBlue,
            labelStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
            unselectedLabelStyle:
                AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Detailed Metrics'),
              Tab(text: 'Comparisons'),
              Tab(text: 'Recommendations'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: AppTheme.dividerLight),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPeriod,
          isExpanded: true,
          icon: CustomIconWidget(
            iconName: 'keyboard_arrow_down',
            color: AppTheme.textMediumEmphasisLight,
            size: 5.w,
          ),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: AppTheme.textHighEmphasisLight,
          ),
          items: periods.map((String period) {
            return DropdownMenuItem<String>(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedPeriod = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSportFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: AppTheme.dividerLight),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedSport,
          isExpanded: true,
          icon: CustomIconWidget(
            iconName: 'keyboard_arrow_down',
            color: AppTheme.textMediumEmphasisLight,
            size: 5.w,
          ),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 12.sp,
            color: AppTheme.textHighEmphasisLight,
          ),
          items: sports.map((String sport) {
            return DropdownMenuItem<String>(
              value: sport,
              child: Text(sport),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedSport = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Performance Indicators',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppTheme.textHighEmphasisLight,
              ),
            ),
            SizedBox(height: 2.h),
            Wrap(
              spacing: 3.w,
              runSpacing: 2.h,
              children: performanceMetrics.map((metric) {
                return PerformanceMetricCard(
                  title: metric['title'] as String,
                  value: metric['value'] as String,
                  unit: metric['unit'] as String,
                  progress: metric['progress'] as double,
                  progressColor: metric['progressColor'] as Color,
                  trend: metric['trend'] as String,
                  isPositiveTrend: metric['isPositiveTrend'] as bool,
                );
              }).toList(),
            ),
            SizedBox(height: 3.h),
            PerformanceChartWidget(
              title: 'Speed Trend (Last 7 Days)',
              chartData: speedChartData,
              chartType: 'line',
            ),
            SizedBox(height: 2.h),
            AiInsightsCard(insights: aiInsights.take(2).toList()),
            SizedBox(height: 2.h),
            InjuryRiskWidget(riskData: injuryRiskData),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PerformanceChartWidget(
            title: 'Speed Analysis',
            chartData: speedChartData,
            chartType: 'line',
          ),
          SizedBox(height: 2.h),
          PerformanceChartWidget(
            title: 'Accuracy Progress',
            chartData: accuracyChartData,
            chartType: 'bar',
          ),
          SizedBox(height: 2.h),
          Text(
            'Detailed Metrics',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppTheme.textHighEmphasisLight,
            ),
          ),
          SizedBox(height: 2.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.2,
            children: performanceMetrics.map((metric) {
              return PerformanceMetricCard(
                title: metric['title'] as String,
                value: metric['value'] as String,
                unit: metric['unit'] as String,
                progress: metric['progress'] as double,
                progressColor: metric['progressColor'] as Color,
                trend: metric['trend'] as String,
                isPositiveTrend: metric['isPositiveTrend'] as bool,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComparisonWidget(comparisonData: comparisonData),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.cardColor,
              borderRadius: BorderRadius.circular(3.w),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ranking Position',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppTheme.textHighEmphasisLight,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRankingItem('Local', '12', 'of 156'),
                    _buildRankingItem('Regional', '45', 'of 892'),
                    _buildRankingItem('National', '234', 'of 5,432'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(String category, String rank, String total) {
    return Column(
      children: [
        Text(
          category,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontSize: 10.sp,
            color: AppTheme.textMediumEmphasisLight,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          '#$rank',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: AppTheme.primaryElectricBlue,
          ),
        ),
        Text(
          total,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontSize: 9.sp,
            color: AppTheme.textMediumEmphasisLight,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AiInsightsCard(insights: aiInsights),
          SizedBox(height: 2.h),
          AchievementProgressWidget(achievements: achievements),
          SizedBox(height: 2.h),
          InjuryRiskWidget(riskData: injuryRiskData),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('home', 'Feed', '/talent-discovery-feed'),
              _buildNavItem('person', 'Profile', '/athlete-profile'),
              _buildNavItem('videocam', 'Upload', '/video-upload-and-analysis'),
              _buildNavItem('analytics', 'Analytics',
                  '/ai-performance-analytics-dashboard',
                  isActive: true),
              _buildNavItem(
                  'people', 'Network', '/scout-network-and-connections'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconName, String label, String route,
      {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: isActive
                ? AppTheme.primaryElectricBlue
                : AppTheme.textMediumEmphasisLight,
            size: 6.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 9.sp,
              color: isActive
                  ? AppTheme.primaryElectricBlue
                  : AppTheme.textMediumEmphasisLight,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh data here
    });
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Export Report',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Generate a PDF report of your performance analytics?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMediumEmphasisLight,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _exportReport();
              },
              child: const Text('Export'),
            ),
          ],
        );
      },
    );
  }

  void _exportReport() {
    // Simulate PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Performance report exported successfully!'),
        backgroundColor: AppTheme.growthGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
