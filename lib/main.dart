import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:my_money1/screens/splash.dart';
import 'package:my_money1/screens/transactoins/add_transaction.dart';

import 'models/category/category_model.dart';
import 'models/transaction/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp( const MoneyManager());
}

class MoneyManager extends StatelessWidget {
  const MoneyManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        AddTransactions.routeName: (context) => const AddTransactions(),
      },
      theme: ThemeData(primarySwatch: Colors.deepOrange),
    );
  }
}
