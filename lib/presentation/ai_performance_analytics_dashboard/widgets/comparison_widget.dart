import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ComparisonWidget extends StatelessWidget {
  final List<Map<String, dynamic>> comparisonData;

  const ComparisonWidget({
    Key? key,
    required this.comparisonData,
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
              CustomIconWidget(
                iconName: 'compare_arrows',
                color: AppTheme.primaryElectricBlue,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Performance Comparison',
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
            itemCount: comparisonData.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final data = comparisonData[index];
              final userValue = (data['userValue'] as num).toDouble();
              final avgValue = (data['avgValue'] as num).toDouble();
              final maxValue =
                  [userValue, avgValue].reduce((a, b) => a > b ? a : b) * 1.2;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['metric'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: AppTheme.textHighEmphasisLight,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'You',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppTheme.textMediumEmphasisLight,
                                  ),
                                ),
                                Text(
                                  '${userValue.toStringAsFixed(1)}${data['unit'] ?? ''}',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryElectricBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Stack(
                              children: [
                                Container(
                                  height: 0.8.h,
                                  decoration: BoxDecoration(
                                    color: AppTheme.lightGray,
                                    borderRadius: BorderRadius.circular(0.4.h),
                                  ),
                                ),
                                Container(
                                  height: 0.8.h,
                                  width: (userValue / maxValue) * 100.w * 0.8,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryElectricBlue,
                                    borderRadius: BorderRadius.circular(0.4.h),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Average',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppTheme.textMediumEmphasisLight,
                                  ),
                                ),
                                Text(
                                  '${avgValue.toStringAsFixed(1)}${data['unit'] ?? ''}',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textMediumEmphasisLight,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Stack(
                              children: [
                                Container(
                                  height: 0.8.h,
                                  decoration: BoxDecoration(
                                    color: AppTheme.lightGray,
                                    borderRadius: BorderRadius.circular(0.4.h),
                                  ),
                                ),
                                Container(
                                  height: 0.8.h,
                                  width: (avgValue / maxValue) * 100.w * 0.8,
                                  decoration: BoxDecoration(
                                    color: AppTheme.textMediumEmphasisLight,
                                    borderRadius: BorderRadius.circular(0.4.h),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: userValue > avgValue
                          ? AppTheme.growthGreen.withValues(alpha: 0.1)
                          : AppTheme.accentGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: userValue > avgValue
                              ? 'trending_up'
                              : 'trending_down',
                          color: userValue > avgValue
                              ? AppTheme.growthGreen
                              : AppTheme.accentGold,
                          size: 3.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          userValue > avgValue
                              ? '${((userValue - avgValue) / avgValue * 100).toStringAsFixed(1)}% above average'
                              : '${((avgValue - userValue) / avgValue * 100).toStringAsFixed(1)}% below average',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: userValue > avgValue
                                ? AppTheme.growthGreen
                                : AppTheme.accentGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
