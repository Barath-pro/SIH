import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementProgressWidget extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const AchievementProgressWidget({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.championshipGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CustomIconWidget(
                  iconName: 'emoji_events',
                  color: AppTheme.championshipGold,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Achievement Progress',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppTheme.textHighEmphasisLight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: achievements.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              final progress = (achievement['progress'] as num).toDouble();
              final isCompleted = progress >= 1.0;

              return Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppTheme.championshipGold.withValues(alpha: 0.1)
                      : AppTheme.lightGray.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(
                    color: isCompleted
                        ? AppTheme.championshipGold.withValues(alpha: 0.3)
                        : AppTheme.dividerLight,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1.5.w),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppTheme.championshipGold
                                : AppTheme.textMediumEmphasisLight,
                            borderRadius: BorderRadius.circular(1.5.w),
                          ),
                          child: CustomIconWidget(
                            iconName: achievement['icon'] as String,
                            color: isCompleted
                                ? AppTheme.neutralCharcoal
                                : Colors.white,
                            size: 4.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievement['title'] as String,
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppTheme.textHighEmphasisLight,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                achievement['description'] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  fontSize: 10.sp,
                                  color: AppTheme.textMediumEmphasisLight,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (isCompleted)
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.growthGreen,
                            size: 5.w,
                          ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            color: AppTheme.textMediumEmphasisLight,
                          ),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: isCompleted
                                ? AppTheme.growthGreen
                                : AppTheme.primaryElectricBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Stack(
                      children: [
                        Container(
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: AppTheme.lightGray,
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                        ),
                        Container(
                          height: 1.h,
                          width: progress * 100.w * 0.8,
                          decoration: BoxDecoration(
                            gradient: isCompleted
                                ? appTheme.getVictoryGradient()
                                : appTheme.getActionGradient(),
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                        ),
                      ],
                    ),
                    if (achievement['estimatedTime'] != null &&
                        !isCompleted) ...[
                      SizedBox(height: 1.h),
                      Text(
                        'Est. completion: ${achievement['estimatedTime']}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 9.sp,
                          color: AppTheme.textMediumEmphasisLight,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
