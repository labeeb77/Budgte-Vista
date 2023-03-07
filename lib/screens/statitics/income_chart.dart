import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';

class IncomeChart extends StatelessWidget {
   const IncomeChart({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TransactionProvider>(
        
        builder: (context, value, child) {
          var incomeData = value.overViewGraphtransaction
              .where((element) => element.category.type == CategoryType.income)
              .toList();
          return value.overViewGraphtransaction.isEmpty
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
                  
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                          dataSource: incomeData,
                          xValueMapper: (TransactionModel data, _) =>
                              data.category.name,
                          yValueMapper: (TransactionModel data, _) =>
                              data.amount,
                         
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
