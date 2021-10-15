import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/details/detail_message.dart';
import 'package:twt_account/statistics/sales.dart';
import 'package:twt_account/data/global_data.dart';

SharedPreferences prefs = GlobalData.getPref()!;
DateTime now = new DateTime.now();


List<List<String>> _detailList = [];




///得到当前月份的收入
double getMonth(String month,int type){
  int x = prefs.getInt("itemCount") ?? 0;
  for (int i = 0; i < x; i++) {
    _detailList.add(prefs.getStringList(i.toString())??["0","0","no data"]);
  }

  List<List<String>> result = [];
  RegExp exp =RegExp(r"2021年"+month);

  for (int i = 0; i < x; i++) {
    if (exp.hasMatch(_detailList[i][2])) {
      result.add(_detailList[i]);
    }
  }
  double sum=0;
  for (int i = 0; i < result.length; i++) {
    if (int.parse(_detailList[i][1])==type) {
      sum += int.parse(_detailList[i][0]);
    }
  }
  return sum;
}
int getExpendCounts(String month){
  int x = prefs.getInt("itemCount") ?? 0;
  for (int i = 0; i < x; i++) {
    _detailList.add(prefs.getStringList(i.toString())??["0","0","no data"]);
  }

  List<List<String>> result = [];
  RegExp exp =RegExp(r"2021年"+month);

  for (int i = 0; i < x; i++) {
    if (exp.hasMatch(_detailList[i][2])) {
      result.add(_detailList[i]);
    }
  }
  int sum=0;
  for (int i = 0; i < result.length; i++) {
    if (int.parse(_detailList[i][1])>4) {
      sum += 1;
    }
  }
  return sum;
}
