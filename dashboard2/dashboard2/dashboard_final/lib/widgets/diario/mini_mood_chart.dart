import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniMoodChart
    extends StatelessWidget {

  const MiniMoodChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 260,

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Theme.of(context)
            .cardColor,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: LineChart(

        LineChartData(

          gridData:
              const FlGridData(
            show: false,
          ),

          borderData:
              FlBorderData(
            show: false,
          ),

          lineBarsData: [

            LineChartBarData(

              isCurved: true,

              color:
                  const Color(
                0xFF8B5CF6,
              ),

              barWidth: 4,

              spots: const [

                FlSpot(0, 3),
                FlSpot(1, 5),
                FlSpot(2, 4),
                FlSpot(3, 6),
                FlSpot(4, 5),
                FlSpot(5, 7),
                FlSpot(6, 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}