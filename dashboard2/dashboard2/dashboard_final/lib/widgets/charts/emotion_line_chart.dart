import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class EmotionLineChart extends StatelessWidget {
  const EmotionLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(

          gridData: const FlGridData(show: false),

          borderData: FlBorderData(show: false),

          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),

          lineBarsData: [

            LineChartBarData(

              spots: const [
                FlSpot(0, 2),
                FlSpot(1, 3),
                FlSpot(2, 5),
                FlSpot(3, 4),
                FlSpot(4, 6),
                FlSpot(5, 7),
              ],

              isCurved: true,

              color: AppColors.primary,

              barWidth: 5,

              dotData: const FlDotData(show: true),

              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}