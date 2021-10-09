import 'package:flutter/cupertino.dart';

class Global with ChangeNotifier {
  int _itemCount = 1;
  int _monthBudget = 0;
  int _todayExpenditure = 0;
  int _monthExpenditure = 0;

  int get countGet => _itemCount;

  int get budgetGet => _monthBudget;

  int get todayExpenditureGet => _todayExpenditure;

  int get monthExpenditureGet => _monthExpenditure;

  void setBudget(int value) {
    this._monthBudget = value;
    notifyListeners();
  }

  void setTodayExpenditure(int value) {
    _todayExpenditure += value;
    notifyListeners();
  }

  void setMonthExpenditure(int value) {
    _monthExpenditure += value;
    notifyListeners();
  }

  void setItemCount(int value){
    _itemCount=value;
    notifyListeners();
  }
  void itemAdd() {
    _itemCount++;
    notifyListeners();
  }
}
