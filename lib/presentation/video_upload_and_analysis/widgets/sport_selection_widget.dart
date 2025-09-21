import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SportSelectionWidget extends StatefulWidget {
  final String selectedSport;
  final Function(String) onSportSelected;

  const SportSelectionWidget({
    Key? key,
    required this.selectedSport,
    required this.onSportSelected,
  }) : super(key: key);

  @override
  State<SportSelectionWidget> createState() => _SportSelectionWidgetState();
}

class _SportSelectionWidgetState extends State<SportSelectionWidget> {
  final List<Map<String, dynamic>> sports = [
    {
      "name": "Football",
      "icon": "sports_football",
      "color": AppTheme.primaryElectricBlue
    },
    {
      "name": "Basketball",
      "icon": "sports_basketball",
      "color": AppTheme.accentGold
    },
    {"name": "Soccer", "icon": "sports_soccer", "color": AppTheme.growthGreen},
    {"name": "Tennis", "icon": "sports_tennis", "color": AppTheme.victoryRed},
    {
      "name": "Baseball",
      "icon": "sports_baseball",
      "color": AppTheme.secondarySkyBlue
    },
    {
      "name": "Volleyball",
      "icon": "sports_volleyball",
      "color": AppTheme.championshipGold
    },
    {
      "name": "Track & Field",
      "icon": "directions_run",
      "color": AppTheme.freshGreen
    },
    {"name": "Swimming", "icon": "pool", "color": AppTheme.primaryElectricBlue},
    {"name": "Gymnastics", "icon": "fitness_center", "color": AppTheme.warmRed},
    {
      "name": "Wrestling",
      "icon": "sports_mma",
      "color": AppTheme.neutralCharcoal
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            'Select Your Sport',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.neutralCharcoal,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose the sport you\'ll be recording for optimal analysis',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisLight,
            ),
          ),
          SizedBox(height: 24),

          // Sports Grid
          Container(
            constraints: BoxConstraints(maxHeight: 50.h),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: sports.length,
              itemBuilder: (context, index) {
                final sport = sports[index];
                final isSelected = widget.selectedSport == sport["name"];

                return GestureDetector(
                  onTap: () => widget.onSportSelected(sport["name"]),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? sport["color"].withValues(alpha: 0.1)
                          : AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isSelected ? sport["color"] : AppTheme.dividerLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? sport["color"]
                                : sport["color"].withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: sport["icon"],
                            color: isSelected ? Colors.white : sport["color"],
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            sport["name"],
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? sport["color"]
                                  : AppTheme.neutralCharcoal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isSelected)
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: sport["color"],
                            size: 20,
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
