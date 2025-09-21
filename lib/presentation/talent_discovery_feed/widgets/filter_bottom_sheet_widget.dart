import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onFiltersApplied;

  const FilterBottomSheetWidget({
    Key? key,
    required this.currentFilters,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late Map<String, dynamic> _filters;

  final List<String> _sports = [
    'Football',
    'Basketball',
    'Tennis',
    'Cricket',
    'Baseball',
    'Volleyball',
    'Swimming',
    'Athletics',
    'Boxing',
    'Wrestling'
  ];

  final List<String> _locations = [
    'New York',
    'California',
    'Texas',
    'Florida',
    'Illinois',
    'Pennsylvania',
    'Ohio',
    'Georgia',
    'North Carolina',
    'Michigan'
  ];

  final List<String> _skillLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Professional',
    'Elite'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSportFilter(),
                  SizedBox(height: 3.h),
                  _buildLocationFilter(),
                  SizedBox(height: 3.h),
                  _buildSkillLevelFilter(),
                  SizedBox(height: 3.h),
                  _buildTalentScoreFilter(),
                  SizedBox(height: 3.h),
                  _buildAgeRangeFilter(),
                  SizedBox(height: 3.h),
                  _buildVerificationFilter(),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Filter Athletes',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _clearAllFilters,
            child: Text(
              'Clear All',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.victoryRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportFilter() {
    return _buildExpandableSection(
      title: 'Sport',
      isExpanded: _filters['sportExpanded'] ?? false,
      onToggle: () => setState(() =>
          _filters['sportExpanded'] = !(_filters['sportExpanded'] ?? false)),
      child: Wrap(
        spacing: 2.w,
        runSpacing: 1.h,
        children: _sports.map((sport) {
          final isSelected =
              (_filters['selectedSports'] as List?)?.contains(sport) ?? false;
          return GestureDetector(
            onTap: () => _toggleSportSelection(sport),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryElectricBlue
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryElectricBlue
                      : AppTheme.lightTheme.dividerColor,
                ),
              ),
              child: Text(
                sport,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationFilter() {
    return _buildExpandableSection(
      title: 'Location',
      isExpanded: _filters['locationExpanded'] ?? false,
      onToggle: () => setState(() => _filters['locationExpanded'] =
          !(_filters['locationExpanded'] ?? false)),
      child: Wrap(
        spacing: 2.w,
        runSpacing: 1.h,
        children: _locations.map((location) {
          final isSelected =
              (_filters['selectedLocations'] as List?)?.contains(location) ??
                  false;
          return GestureDetector(
            onTap: () => _toggleLocationSelection(location),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryElectricBlue
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryElectricBlue
                      : AppTheme.lightTheme.dividerColor,
                ),
              ),
              child: Text(
                location,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSkillLevelFilter() {
    return _buildExpandableSection(
      title: 'Skill Level',
      isExpanded: _filters['skillExpanded'] ?? false,
      onToggle: () => setState(() =>
          _filters['skillExpanded'] = !(_filters['skillExpanded'] ?? false)),
      child: Column(
        children: _skillLevels.map((level) {
          final isSelected = _filters['selectedSkillLevel'] == level;
          return GestureDetector(
            onTap: () => setState(() =>
                _filters['selectedSkillLevel'] = isSelected ? null : level),
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryElectricBlue.withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryElectricBlue
                      : AppTheme.lightTheme.dividerColor,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: isSelected
                        ? 'radio_button_checked'
                        : 'radio_button_unchecked',
                    color: isSelected
                        ? AppTheme.primaryElectricBlue
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    level,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.primaryElectricBlue
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTalentScoreFilter() {
    return _buildExpandableSection(
      title: 'Talent Score Range',
      isExpanded: _filters['scoreExpanded'] ?? false,
      onToggle: () => setState(() =>
          _filters['scoreExpanded'] = !(_filters['scoreExpanded'] ?? false)),
      child: Column(
        children: [
          RangeSlider(
            values: RangeValues(
              (_filters['minScore'] ?? 0).toDouble(),
              (_filters['maxScore'] ?? 100).toDouble(),
            ),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels(
              (_filters['minScore'] ?? 0).toString(),
              (_filters['maxScore'] ?? 100).toString(),
            ),
            onChanged: (values) {
              setState(() {
                _filters['minScore'] = values.start.round();
                _filters['maxScore'] = values.end.round();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${_filters['minScore'] ?? 0}',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              Text(
                'Max: ${_filters['maxScore'] ?? 100}',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeRangeFilter() {
    return _buildExpandableSection(
      title: 'Age Range',
      isExpanded: _filters['ageExpanded'] ?? false,
      onToggle: () => setState(
          () => _filters['ageExpanded'] = !(_filters['ageExpanded'] ?? false)),
      child: Column(
        children: [
          RangeSlider(
            values: RangeValues(
              (_filters['minAge'] ?? 16).toDouble(),
              (_filters['maxAge'] ?? 35).toDouble(),
            ),
            min: 16,
            max: 35,
            divisions: 19,
            labels: RangeLabels(
              '${_filters['minAge'] ?? 16}',
              '${_filters['maxAge'] ?? 35}',
            ),
            onChanged: (values) {
              setState(() {
                _filters['minAge'] = values.start.round();
                _filters['maxAge'] = values.end.round();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${_filters['minAge'] ?? 16} years',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              Text(
                'Max: ${_filters['maxAge'] ?? 35} years',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationFilter() {
    return _buildExpandableSection(
      title: 'Verification Status',
      isExpanded: _filters['verificationExpanded'] ?? false,
      onToggle: () => setState(() => _filters['verificationExpanded'] =
          !(_filters['verificationExpanded'] ?? false)),
      child: Column(
        children: [
          _buildCheckboxTile('Verified Athletes Only', 'verifiedOnly'),
          _buildCheckboxTile('Show Unverified Athletes', 'showUnverified'),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String title, String key) {
    final isSelected = _filters[key] ?? false;
    return GestureDetector(
      onTap: () => setState(() => _filters[key] = !isSelected),
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.lightTheme.dividerColor,
          ),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: isSelected ? 'check_box' : 'check_box_outline_blank',
              color: isSelected
                  ? AppTheme.primaryElectricBlue
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
            SizedBox(width: 3.w),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              CustomIconWidget(
                iconName: isExpanded ? 'expand_less' : 'expand_more',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          SizedBox(height: 2.h),
          child,
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                style: AppTheme.lightTheme.outlinedButtonTheme.style?.copyWith(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text('Apply Filters'),
                style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSportSelection(String sport) {
    setState(() {
      final selectedSports = (_filters['selectedSports'] as List?) ?? [];
      if (selectedSports.contains(sport)) {
        selectedSports.remove(sport);
      } else {
        selectedSports.add(sport);
      }
      _filters['selectedSports'] = selectedSports;
    });
  }

  void _toggleLocationSelection(String location) {
    setState(() {
      final selectedLocations = (_filters['selectedLocations'] as List?) ?? [];
      if (selectedLocations.contains(location)) {
        selectedLocations.remove(location);
      } else {
        selectedLocations.add(location);
      }
      _filters['selectedLocations'] = selectedLocations;
    });
  }

  void _clearAllFilters() {
    setState(() {
      _filters.clear();
    });
  }

  void _applyFilters() {
    widget.onFiltersApplied(_filters);
    Navigator.pop(context);
  }
}
