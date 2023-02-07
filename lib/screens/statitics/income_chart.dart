import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';
import 'overview_chart.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: overviewChartList,
        builder: (context, chartData, child) {
          var incomeData = chartData
              .where((element) => element.category.type == CategoryType.income)
              .toList();
          return incomeData.isEmpty
              ?  Center(
                  child: Text('No data',style: GoogleFonts.quicksand(color: ThemeColor.themeColors)),
                )
              : Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SfCircularChart(
                    backgroundColor: Colors.white,
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                        alignment: ChartAlignment.center),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                          dataSource: incomeData,
                          xValueMapper: (TransactionModel data, _) =>
                              data.category.name,
                          yValueMapper: (TransactionModel data, _) =>
                              data.amount,
                          enableTooltip: true,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ],
                  ),
                );
        },
      ),
    );
  }
}
