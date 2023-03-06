import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier {
  bool isLastPage = false;
  bool isSeen = true;

  void changeScreen (index){
    isLastPage =(index == 2);

    isSeen = (index !=2);
    notifyListeners();
  }
}