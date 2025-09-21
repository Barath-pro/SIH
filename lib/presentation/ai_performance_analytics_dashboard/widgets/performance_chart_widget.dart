import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PerformanceChartWidget extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> chartData;
  final String chartType;

  const PerformanceChartWidget({
    Key? key,
    required this.title,
    required this.chartData,
    required this.chartType,
  }) : super(key: key);

  @override
  State<PerformanceChartWidget> createState() => _PerformanceChartWidgetState();
}

class _PerformanceChartWidgetState extends State<PerformanceChartWidget> {
  int touchedIndex = -1;

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
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppTheme.textHighEmphasisLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomIconWidget(
                iconName: 'more_vert',
                color: AppTheme.textMediumEmphasisLight,
                size: 5.w,
              ),
            ],
          ),
          SizedBox(height: 3.h),

          /// Chart Section
          SizedBox(
            height: 25.h,
            child: widget.chartType == 'line'
                ? _buildLineChart()
                : _buildBarChart(),
          ),
        ],
      ),
    );
  }

  /// LINE CHART
  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppTheme.lightGray,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value.toInt() < widget.chartData.length) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 4,
                    child: Text(
                      widget.chartData[value.toInt()]['label'] as String,
                      style:
                          AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 8.sp,
                        color: AppTheme.textMediumEmphasisLight,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(
                    value.toInt().toString(),
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 8.sp,
                      color: AppTheme.textMediumEmphasisLight,
                    ),
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (widget.chartData.length - 1).toDouble(),
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: widget.chartData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(),
                  (entry.value['value'] as num).toDouble());
            }).toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryElectricBlue,
                AppTheme.secondarySkyBlue,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryElectricBlue.withOpacity(0.3),
                  AppTheme.secondarySkyBlue.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// BAR CHART
  Widget _buildBarChart() {
  return BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 100,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '${widget.chartData[group.x]['label']}\n',
              AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: rod.toY.round().toString(),
                  style: AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (value.toInt() < widget.chartData.length) {
                return SideTitleWidget(
                  meta: meta,
                  space: 4,
                  child: Text(
                    widget.chartData[value.toInt()]['label'] as String,
                    style:
                        AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 8.sp,
                      color: AppTheme.textMediumEmphasisLight,
                    ),
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 20,
            getTitlesWidget: (double value, TitleMeta meta) {
              return SideTitleWidget(
                meta: meta,
                space: 4,
                child: Text(
                  value.toInt().toString(),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    fontSize: 8.sp,
                    color: AppTheme.textMediumEmphasisLight,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: widget.chartData.asMap().entries.map((entry) {
        return BarChartGroupData(
          x: entry.key,
          barRods: [
            BarChartRodData(
              toY: (entry.value['value'] as num).toDouble(),
              gradient: LinearGradient(
                colors: touchedIndex == entry.key
                    ? [AppTheme.accentGold, AppTheme.championshipGold]
                    : [
                        AppTheme.primaryElectricBlue,
                        AppTheme.secondarySkyBlue
                      ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 4.w,
              borderRadius: BorderRadius.circular(1.w),
            ),
          ],
        );
      }).toList(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.lightGray,
            strokeWidth: 1,
          );
        },
      ),
    ),
  );
}

}
