import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PerformanceTypeWidget extends StatefulWidget {
  final String selectedType;
  final Function(String) onTypeSelected;
  final String selectedSport;

  const PerformanceTypeWidget({
    Key? key,
    required this.selectedType,
    required this.onTypeSelected,
    required this.selectedSport,
  }) : super(key: key);

  @override
  State<PerformanceTypeWidget> createState() => _PerformanceTypeWidgetState();
}

class _PerformanceTypeWidgetState extends State<PerformanceTypeWidget> {
  Map<String, List<Map<String, dynamic>>> getPerformanceTypes() {
    return {
      "Football": [
        {
          "name": "Passing",
          "icon": "sports_football",
          "description": "Throwing accuracy and distance"
        },
        {
          "name": "Running",
          "icon": "directions_run",
          "description": "Speed and agility drills"
        },
        {
          "name": "Catching",
          "icon": "sports_handball",
          "description": "Reception skills"
        },
        {
          "name": "Kicking",
          "icon": "sports_football",
          "description": "Field goals and punts"
        },
      ],
      "Basketball": [
        {
          "name": "Shooting",
          "icon": "sports_basketball",
          "description": "Free throws and field goals"
        },
        {
          "name": "Dribbling",
          "icon": "sports_basketball",
          "description": "Ball handling skills"
        },
        {
          "name": "Defense",
          "icon": "security",
          "description": "Defensive positioning"
        },
        {
          "name": "Rebounding",
          "icon": "sports_basketball",
          "description": "Board control"
        },
      ],
      "Soccer": [
        {
          "name": "Shooting",
          "icon": "sports_soccer",
          "description": "Goal scoring accuracy"
        },
        {
          "name": "Passing",
          "icon": "sports_soccer",
          "description": "Ball distribution"
        },
        {
          "name": "Dribbling",
          "icon": "sports_soccer",
          "description": "Ball control skills"
        },
        {
          "name": "Defending",
          "icon": "security",
          "description": "Defensive techniques"
        },
      ],
      "Tennis": [
        {
          "name": "Serve",
          "icon": "sports_tennis",
          "description": "Service technique and power"
        },
        {
          "name": "Forehand",
          "icon": "sports_tennis",
          "description": "Forehand stroke"
        },
        {
          "name": "Backhand",
          "icon": "sports_tennis",
          "description": "Backhand technique"
        },
        {
          "name": "Volley",
          "icon": "sports_tennis",
          "description": "Net play skills"
        },
      ],
      "Default": [
        {
          "name": "Technique",
          "icon": "fitness_center",
          "description": "Form and technique analysis"
        },
        {"name": "Speed", "icon": "speed", "description": "Speed and timing"},
        {
          "name": "Strength",
          "icon": "fitness_center",
          "description": "Power and strength"
        },
        {
          "name": "Endurance",
          "icon": "timer",
          "description": "Stamina and endurance"
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final performanceTypes = getPerformanceTypes();
    final types =
        performanceTypes[widget.selectedSport] ?? performanceTypes["Default"]!;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Title
          Text(
            'Performance Type',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.neutralCharcoal,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select the specific skill you want to analyze for ${widget.selectedSport}',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisLight,
            ),
          ),
          SizedBox(height: 24),

          // Performance Types List
          Container(
            constraints: BoxConstraints(maxHeight: 40.h),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: types.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                final type = types[index];
                final isSelected = widget.selectedType == type["name"];

                return GestureDetector(
                  onTap: () => widget.onTypeSelected(type["name"]),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryElectricBlue.withValues(alpha: 0.1)
                          : AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryElectricBlue
                            : AppTheme.dividerLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primaryElectricBlue
                                : AppTheme.primaryElectricBlue
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomIconWidget(
                            iconName: type["icon"],
                            color: isSelected
                                ? Colors.white
                                : AppTheme.primaryElectricBlue,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type["name"],
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppTheme.primaryElectricBlue
                                      : AppTheme.neutralCharcoal,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                type["description"],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textMediumEmphasisLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.primaryElectricBlue,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
