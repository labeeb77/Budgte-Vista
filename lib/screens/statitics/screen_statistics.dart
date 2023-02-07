import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../database/transaction/transaction_db.dart';
import '../home/widgets/colors.dart';
import '../transactoins/transaction_list.dart';
import 'expense_chart.dart';
import 'income_chart.dart';
import 'overview_chart.dart';

class ScreenStatitics extends StatefulWidget {
  const ScreenStatitics({super.key});

  @override
  State<ScreenStatitics> createState() => _ScreenStatiticsState();
}

class _ScreenStatiticsState extends State<ScreenStatitics>
    with SingleTickerProviderStateMixin {
  late TabController tabsController;
  String filterTitle = 'All';

  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);

    overViewNotifier.value =
        TransactionsDB.instance.transactionListNotfier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeColor.themeColors,
        title:  Text('Statistics', style: GoogleFonts.quicksand(color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: const Color.fromARGB(255, 231, 231, 231),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 50,
                      width: 320,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),

                        //.......... popupmenu...........//

                        child: Row(
                          children: [
                            Text(
                              filterTitle,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            PopupMenuButton<int>(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: 25,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: const Text('All'),
                                  onTap: () {

                                    overviewChartList.value = TransactionsDB
                                        .instance.transactionListNotfier.value;
                                    setState(
                                      () {
                                        filterTitle = 'All';
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: const Text('Today'),
                                  onTap: () {
                                    overviewChartList.value = TransactionsDB
                                        .instance.transactionListNotfier.value;
                                    overviewChartList.value = overViewNotifier
                                        .value
                                        .where((element) =>
                                            element.date.day ==
                                                DateTime.now().day &&
                                            element.date.month ==
                                                DateTime.now().month &&
                                            element.date.year ==
                                                DateTime.now().year)
                                        .toList();
                                    setState(
                                      () {
                                        filterTitle = 'Today';
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: const Text('Yesterday'),
                                  onTap: () {
                                    overviewChartList.value = TransactionsDB
                                        .instance.transactionListNotfier.value
                                        .where((element) =>
                                            element.date.day ==
                                                DateTime.now().day - 1 &&
                                            element.date.month ==
                                                DateTime.now().month &&
                                            element.date.year ==
                                                DateTime.now().year)
                                        .toList();
                                    setState(
                                      () {
                                        filterTitle = 'Yesterday';
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: const Text('Month'),
                                  onTap: () {
                                    overviewChartList.value = TransactionsDB
                                        .instance.transactionListNotfier.value
                                        .where((element) =>
                                            element.date.month ==
                                                DateTime.now().month &&
                                            element.date.year ==
                                                DateTime.now().year)
                                        .toList();
                                    setState(
                                      () {
                                        filterTitle = 'Month';
                                      },
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              //..........Tab bar...........//

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  controller: tabsController,
                  unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
        
                    color: ThemeColor.themeColors,
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Overview",
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Income",
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Expense",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
              
                  child: TabBarView(
                      controller: tabsController,
                      children: const [
                    OverviewChart(),
                    IncomeChart(),
                    ExpenseChart()
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
