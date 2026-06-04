import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BarChartWidget extends StatelessWidget {
  final Map<String, int> diariosPorDia;

  const BarChartWidget({super.key, required this.diariosPorDia});

  @override
  Widget build(BuildContext context) {
    final maxValor = diariosPorDia.values.isEmpty
        ? 1
        : diariosPorDia.values.reduce((a, b) => a > b ? a : b) + 1;

    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
      ),
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxValor.toDouble(),

          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),

          titlesData: FlTitlesData(
            topTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (value.toInt() >= diariosPorDia.length) {
        return const SizedBox();
      }

      final cantidad = diariosPorDia.values.elementAt(value.toInt());

      return Text(
        cantidad.toString(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  ),
),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final fechas = diariosPorDia.keys.toList();

                  if (value.toInt() >= fechas.length) {
                    return const SizedBox();
                  }

                  return Text(
                    fechas[value.toInt()].substring(5),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),

          barGroups: diariosPorDia.entries.toList().asMap().entries.map((
            entry,
          ) {
            final index = entry.key;
            final data = entry.value;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
           toY: data.value.toDouble(),
          color: AppColors.primary,
            width: 18,
            borderRadius: BorderRadius.circular(10),
            rodStackItems: [],
               ),
              ],
            );
          }).toList(),

        ),
      ),
    );
  }
}
//hola