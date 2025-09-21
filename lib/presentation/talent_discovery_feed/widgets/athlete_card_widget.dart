import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AthleteCardWidget extends StatelessWidget {
  final Map<String, dynamic> athlete;
  final VoidCallback? onTap;
  final VoidCallback? onInterested;
  final VoidCallback? onConnect;
  final VoidCallback? onPass;

  const AthleteCardWidget({
    Key? key,
    required this.athlete,
    this.onTap,
    this.onInterested,
    this.onConnect,
    this.onPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onInterested,
      child: Dismissible(
        key: Key(athlete['id'].toString()),
        background: _buildSwipeBackground(true),
        secondaryBackground: _buildSwipeBackground(false),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            onConnect?.call();
          } else {
            onPass?.call();
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(16),
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
              _buildVideoThumbnail(),
              _buildAthleteInfo(),
              _buildPerformanceMetrics(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(bool isConnect) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isConnect ? AppTheme.growthGreen : AppTheme.victoryRed,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: isConnect ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: isConnect ? 'connect_without_contact' : 'close',
                color: Colors.white,
                size: 32,
              ),
              SizedBox(height: 1.h),
              Text(
                isConnect ? 'Connect' : 'Pass',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: CustomImageWidget(
            imageUrl: athlete['videoThumbnail'] ?? '',
            width: double.infinity,
            height: 25.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 2.h,
          right: 4.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'play_arrow',
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  athlete['videoDuration'] ?? '0:30',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 2.h,
          left: 4.w,
          child: _buildTalentScore(),
        ),
      ],
    );
  }

  Widget _buildTalentScore() {
    final score = athlete['talentScore'] ?? 0;
    Color scoreColor;
    String scoreLabel;

    if (score >= 90) {
      scoreColor = AppTheme.championshipGold;
      scoreLabel = 'Elite';
    } else if (score >= 80) {
      scoreColor = AppTheme.growthGreen;
      scoreLabel = 'Excellent';
    } else if (score >= 70) {
      scoreColor = AppTheme.primaryElectricBlue;
      scoreLabel = 'Good';
    } else {
      scoreColor = AppTheme.accentGold;
      scoreLabel = 'Promising';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: scoreColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: 'star',
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 1.w),
          Text(
            '$score',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            scoreLabel,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAthleteInfo() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CustomImageWidget(
              imageUrl: athlete['profileImage'] ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        athlete['name'] ?? 'Unknown Athlete',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (athlete['isVerified'] == true)
                      CustomIconWidget(
                        iconName: 'verified',
                        color: AppTheme.primaryElectricBlue,
                        size: 20,
                      ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'sports_soccer',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      athlete['sport'] ?? 'Unknown Sport',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    CustomIconWidget(
                      iconName: 'location_on',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Text(
                        athlete['location'] ?? 'Unknown Location',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    final achievements = (athlete['achievements'] as List?) ?? [];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (achievements.isNotEmpty) ...[
            Text(
              'Recent Achievements',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              height: 4.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: achievements.length > 3 ? 3 : achievements.length,
                separatorBuilder: (context, index) => SizedBox(width: 2.w),
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.championshipGold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.championshipGold,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'emoji_events',
                          color: AppTheme.championshipGold,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          achievement['title'] ?? '',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.championshipGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
          ],
          Row(
            children: [
              _buildMetricChip('Speed', athlete['topSpeed'] ?? '0', 'km/h'),
              SizedBox(width: 2.w),
              _buildMetricChip(
                  'Goals', athlete['goals']?.toString() ?? '0', ''),
              SizedBox(width: 2.w),
              _buildMetricChip(
                  'Matches', athlete['matches']?.toString() ?? '0', ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(String label, String value, String unit) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              '$value$unit',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryElectricBlue,
              ),
            ),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onConnect,
              icon: CustomIconWidget(
                iconName: 'connect_without_contact',
                color: AppTheme.primaryElectricBlue,
                size: 20,
              ),
              label: Text('Connect'),
              style: AppTheme.lightTheme.outlinedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 1.5.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onInterested,
              icon: CustomIconWidget(
                iconName: 'favorite',
                color: Colors.white,
                size: 20,
              ),
              label: Text('Interested'),
              style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 1.5.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
