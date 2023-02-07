import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../database/transaction/transaction_db.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';
import '../sort_income,expense/sorted.dart';

ValueNotifier<List<TransactionModel>> overviewChartList = ValueNotifier(TransactionsDB.instance.transactionListNotfier.value);
  
class OverviewChart extends StatefulWidget {
  const OverviewChart({super.key});

  @override
  State<OverviewChart> createState() => _OverviewChartState();
}

class _OverviewChartState extends State<OverviewChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: overviewChartList,
        builder: (BuildContext context, List<TransactionModel>newList, Widget?_)  {
          Map incomeMap = {"name": "Income", "amount": incomeTotal.value};
          Map expenseMap = {"name": "Expense", "amount": expenseTotal.value};
          List<Map> chartList = [incomeMap, expenseMap];
          return overviewChartList.value.isEmpty
              ?  Center(
                  child: Text('No data',style: GoogleFonts.quicksand(color: ThemeColor.themeColors)),
                )
              : Padding(
                padding: const EdgeInsets.all(25.0),
                child: SfCircularChart(
                  backgroundColor: Colors.white,
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<Map, String>(
                      dataSource: chartList,
                      xValueMapper: (Map data, _) => data['name'],
                      yValueMapper: (Map data, _) => data['amount'],
                      enableTooltip: true,
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
