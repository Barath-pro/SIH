import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PerformanceMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final double progress;
  final Color progressColor;
  final String trend;
  final bool isPositiveTrend;

  const PerformanceMetricCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.progress,
    required this.progressColor,
    required this.trend,
    required this.isPositiveTrend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMediumEmphasisLight,
                    fontSize: 10.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomIconWidget(
                iconName: isPositiveTrend ? 'trending_up' : 'trending_down',
                color: isPositiveTrend
                    ? AppTheme.growthGreen
                    : AppTheme.victoryRed,
                size: 4.w,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppTheme.textHighEmphasisLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                unit,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMediumEmphasisLight,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
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
                width: (progress * 100).clamp(0, 100).w * 0.42,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(0.5.h),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            trend,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color:
                  isPositiveTrend ? AppTheme.growthGreen : AppTheme.victoryRed,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
