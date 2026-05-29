import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
      ),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),

          gridData: const FlGridData(show: false),

          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {

                  final days = [
                    'L',
                    'M',
                    'M',
                    'J',
                    'V',
                    'S',
                    'D'
                  ];

                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),

          barGroups: [

            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 4,
                  color: AppColors.primary,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),

            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 7,
                  color: AppColors.secondary,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),

            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 5,
                  color: AppColors.accent,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),

            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 9,
                  color: AppColors.primary,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),

            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: 6,
                  color: AppColors.secondary,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),

            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  toY: 8,
                  color: AppColors.accent,
                  width: 18,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}