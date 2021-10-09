import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/statistics/sales.dart';
import 'package:twt_account/data/global_data.dart';


SharedPreferences prefs = GlobalData.getPref()!;
DateTime now = new DateTime.now();
List<List<String>> _detailList = [];


Widget getPie() {
  List<Piesales> dataPie = [
    Piesales(1, getMonth(now.month.toString(), 1), Colors.grey,"学习"),
    Piesales(2, getMonth(now.month.toString(), 2), Colors.blueGrey,"娱乐"),
    Piesales(3, getMonth(now.month.toString(), 3), Colors.blue,"交通"),
    Piesales(4, getMonth(now.month.toString(), 4), Colors.lightBlue,"工资"),
  ];

  var seriesPie = [
    charts.Series<Piesales, int>(
      data: dataPie,
      domainFn: (Piesales sales, _) => sales.type,
      measureFn: (Piesales sales, _) => sales.income,
      colorFn: (Piesales sales, _) => sales.color,
      id: "Sales",
      labelAccessorFn: (Piesales row, _) => '${row.what}',
    )
  ];
  Widget Pie = charts.PieChart(
    seriesPie,
    animate: true,
    // defaultRenderer:
    // charts.ArcRendererConfig(arcRendererDecorators: [
    //   charts.ArcLabelDecorator(
    //       labelPosition: charts.ArcLabelPosition.outside)
    // ])
  );
  return Pie;
}

///得到当前月份的收入
double getMonth(String month,int type){
  int x = prefs.getInt("itemCount") ?? 0;
  for (int i = 0; i < x; i++) {
    _detailList.add(prefs.getStringList(i.toString())??["no data"]);
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
