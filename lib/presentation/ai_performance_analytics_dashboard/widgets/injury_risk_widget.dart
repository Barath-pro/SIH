import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InjuryRiskWidget extends StatelessWidget {
  final Map<String, dynamic> riskData;

  const InjuryRiskWidget({
    Key? key,
    required this.riskData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riskLevel = riskData['riskLevel'] as String;
    final riskScore = (riskData['riskScore'] as num).toDouble();
    final riskColor = _getRiskColor(riskLevel);

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
                  color: riskColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CustomIconWidget(
                  iconName: 'health_and_safety',
                  color: riskColor,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Injury Risk Assessment',
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
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: riskColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Risk Level',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: AppTheme.textMediumEmphasisLight,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: riskColor,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Text(
                        riskLevel.toUpperCase(),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 1.5.h,
                            decoration: BoxDecoration(
                              color: AppTheme.lightGray,
                              borderRadius: BorderRadius.circular(0.75.h),
                            ),
                          ),
                          Container(
                            height: 1.5.h,
                            width: (riskScore / 100) * 100.w * 0.7,
                            decoration: BoxDecoration(
                              color: riskColor,
                              borderRadius: BorderRadius.circular(0.75.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${riskScore.toInt()}%',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: riskColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          if (riskData['factors'] != null) ...[
            Text(
              'Risk Factors',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppTheme.textHighEmphasisLight,
              ),
            ),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: (riskData['factors'] as List).map((factor) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGray,
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Text(
                    factor as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 9.sp,
                      color: AppTheme.textMediumEmphasisLight,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 2.h),
          ],
          if (riskData['recommendations'] != null) ...[
            Text(
              'Prevention Tips',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppTheme.textHighEmphasisLight,
              ),
            ),
            SizedBox(height: 1.h),
            ...(riskData['recommendations'] as List)
                .map((tip) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h),
                            width: 1.w,
                            height: 1.w,
                            decoration: BoxDecoration(
                              color: AppTheme.growthGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              tip as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontSize: 10.sp,
                                color: AppTheme.textMediumEmphasisLight,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ],
      ),
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return AppTheme.growthGreen;
      case 'medium':
        return AppTheme.accentGold;
      case 'high':
        return AppTheme.victoryRed;
      default:
        return AppTheme.textMediumEmphasisLight;
    }
  }
}
