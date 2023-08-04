import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../home/widgets/colors.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) {
          Map incomeMap = {"name": "Income", "amount": value.incomeTotal};
          Map expenseMap = {"name": "Expense", "amount": value.expenseTotal};
          List<Map> chartList = [incomeMap, expenseMap];
          return value.overViewGraphtransaction.isEmpty
              ? Center(
                  child: Text('No data',
                      style:
                          GoogleFonts.quicksand(color: ThemeColor.themeColors)),
                )
              : Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SfCircularChart(
                    backgroundColor: Colors.white,
                    legend: const Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll),
                    series: <CircularSeries>[
                      PieSeries<Map, String>(
                        dataSource: chartList,
                        xValueMapper: (Map data, _) => data['name'],
                        yValueMapper: (Map data, _) => data['amount'],
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
