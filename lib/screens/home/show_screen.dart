import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:my_money1/screens/home/widgets/colors.dart';
import 'package:provider/provider.dart';




import '../transactoins/add_transaction.dart';
import '../transactoins/recent_transaction.dart';

import '../viewall/view_all.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack( 
      children: [
        Scaffold(    
         
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Color.fromARGB(255, 138, 31, 12),
              Color.fromARGB(255, 248, 134, 4)
            ])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     Text('  Budget Vista',style: GoogleFonts.philosopher(fontSize: 20,color: const Color.fromARGB(255, 216, 207, 207),fontWeight: FontWeight.bold),),
                  const Padding(
                     padding:  EdgeInsets.only(right: 10),
                     child:  Icon(Icons.wallet,size: 26,color: Colors.white,),
                   )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 125,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, top: 2, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Transactions',
                                  style: GoogleFonts.quicksand(
                                      color: const Color.fromARGB(
                                          255, 117, 52, 52),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const History(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      ThemeColor.themeColors,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'View all',
                                    style: GoogleFonts.quicksand(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: RecentTransaction(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ThemeColor.themeColors,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  AddTransactions(),
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 245, 239, 239),
            ),
          ),
        ),
        myCard()
      ],
    );
  }
}
//...............CARD...............//

Positioned myCard() {
  return Positioned(
    right: 21,
    top: 75,
    left: 21,
    child: Card(
      color: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        width: double.infinity,
        height: 195,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Consumer<TransactionProvider>(
                      
                      builder: (cntext, value, Widget? _) {
                        return Text(
                          value.balanceTotal < 0 ? "LOSS" : 'Available Balance',
                          style: GoogleFonts.quicksand(
                              color: value.balanceTotal < 0 ? const Color.fromARGB(255, 207, 36, 36)
                            .withOpacity(0.8) : const Color.fromARGB(255, 62, 155, 82)
                            .withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        );
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<TransactionProvider>(
                    builder: (context, value, child) {
                      var tbalance = value.balanceTotal;
                      tbalance = tbalance < 0 ? tbalance * -1 : tbalance;
                      return Text(
                        '₹ $tbalance',
                        style: GoogleFonts.quicksand(
                          fontSize: 28,
                          color: ThemeColor.themeColors,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  Image.asset(
                    'assets/images/wallet.png',
                    height: 40,
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Income',
                    style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 62, 155, 82)
                            .withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Expense',
                    style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 207, 36, 36)
                            .withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<TransactionProvider>(
                    
                    builder: (context, value, child) {
                      return Text('₹ ${value.incomeTotal}',
                          style: GoogleFonts.quicksand(
                            fontSize: 26,
                            color: ThemeColor.themeColors,
                            fontWeight: FontWeight.w500,
                          ));
                    },
                  ),
                  Consumer<TransactionProvider>(
                    
                    builder: (context, value, child) {
                      return Text(
                        '₹ ${value.expenseTotal}',
                        style: GoogleFonts.quicksand(
                            fontSize: 26,
                            color: ThemeColor.themeColors,
                            fontWeight: FontWeight.w500),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
