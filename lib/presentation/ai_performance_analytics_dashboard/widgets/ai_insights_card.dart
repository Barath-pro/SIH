import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiInsightsCard extends StatefulWidget {
  final List<Map<String, dynamic>> insights;

  const AiInsightsCard({
    Key? key,
    required this.insights,
  }) : super(key: key);

  @override
  State<AiInsightsCard> createState() => _AiInsightsCardState();
}

class _AiInsightsCardState extends State<AiInsightsCard> {
  int expandedIndex = -1;

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
                  color: AppTheme.primaryElectricBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.primaryElectricBlue,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'AI Performance Insights',
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
            itemCount: widget.insights.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final insight = widget.insights[index];
              final isExpanded = expandedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? -1 : index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: _getInsightColor(insight['type'] as String)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                      color: _getInsightColor(insight['type'] as String)
                          .withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName:
                                _getInsightIcon(insight['type'] as String),
                            color: _getInsightColor(insight['type'] as String),
                            size: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              insight['title'] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: AppTheme.textHighEmphasisLight,
                              ),
                              maxLines: isExpanded ? null : 1,
                              overflow:
                                  isExpanded ? null : TextOverflow.ellipsis,
                            ),
                          ),
                          CustomIconWidget(
                            iconName:
                                isExpanded ? 'expand_less' : 'expand_more',
                            color: AppTheme.textMediumEmphasisLight,
                            size: 4.w,
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        SizedBox(height: 2.h),
                        Text(
                          insight['description'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: AppTheme.textMediumEmphasisLight,
                            height: 1.4,
                          ),
                        ),
                        if (insight['recommendations'] != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            'Recommendations:',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                              color: AppTheme.textHighEmphasisLight,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          ...(insight['recommendations'] as List)
                              .map((rec) => Padding(
                                    padding: EdgeInsets.only(
                                        left: 3.w, bottom: 0.5.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '• ',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontSize: 11.sp,
                                            color: _getInsightColor(
                                                insight['type'] as String),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            rec as String,
                                            style: AppTheme
                                                .lightTheme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontSize: 10.sp,
                                              color: AppTheme
                                                  .textMediumEmphasisLight,
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
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getInsightColor(String type) {
    switch (type) {
      case 'improvement':
        return AppTheme.growthGreen;
      case 'warning':
        return AppTheme.accentGold;
      case 'critical':
        return AppTheme.victoryRed;
      case 'achievement':
        return AppTheme.championshipGold;
      default:
        return AppTheme.primaryElectricBlue;
    }
  }

  String _getInsightIcon(String type) {
    switch (type) {
      case 'improvement':
        return 'trending_up';
      case 'warning':
        return 'warning';
      case 'critical':
        return 'error';
      case 'achievement':
        return 'emoji_events';
      default:
        return 'lightbulb';
    }
  }
}
