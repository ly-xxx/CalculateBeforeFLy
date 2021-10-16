import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/statistics/sales.dart';
import 'package:twt_account/data/global_data.dart';

SharedPreferences prefs = GlobalData.getPref()!;
DateTime now = new DateTime.now();

var d1 = now.add(new Duration(days: -5));
var d2 = now.add(new Duration(days: -4));
var d3 = now.add(new Duration(days: -3));
var d4 = now.add(new Duration(days: -2));
var d5 = now.add(new Duration(days: -1));

List<List<String>> _detailList = [];

Widget getLine_e() {
  List<Linesales> dataLine = [
    Linesales(d1, getDay(d1.month.toString(), d1.day.toString()),Color(0xFF2F2E41)), //日期，当日总收支
    Linesales(d2, getDay(d2.month.toString(), d2.day.toString()),Color(0xFF2F2E41)),
    Linesales(d3, getDay(d3.month.toString(), d3.day.toString()),Color(0xFF2F2E41)),
    Linesales(d4, getDay(d4.month.toString(), d4.day.toString()),Color(0xFF2F2E41)),
    Linesales(d5, getDay(d5.month.toString(), d5.day.toString()),Color(0xFF2F2E41)),
    Linesales(now, getDay(now.month.toString(), now.day.toString()),Color(0xFF2F2E41)),
  ];

  var seriesLine = [
    charts.Series<Linesales, DateTime>(
      data: dataLine,
      domainFn: (Linesales lines, _) => lines.time,
      measureFn: (Linesales lines, _) => lines.sale,
      colorFn: (Linesales lines, _) =>lines.color,
      id: "Lines",
    )
  ];
  //是TimeSeriesChart，而不是LineChart,因为x轴是DataTime类
  Widget line = charts.TimeSeriesChart(seriesLine,
      defaultRenderer: charts.LineRendererConfig(
        // 圆点大小
        radiusPx: 5.0,
        stacked: false,
        // 线的宽度
        strokeWidthPx: 2.0,
        // 是否显示线
        includeLine: true,
        // 是否显示圆点
        includePoints: true,
        // 是否显示包含区域
        includeArea: true,
        // 区域颜色透明度 0.0-1.0
        areaOpacity: 0.2,
      ));
  //line = charts.LineChart(series);
  return line;
}

///得到当前日收支

int getDay(String month, String day){
  int x = prefs.getInt("itemCount") ?? 0;

  for (int i = 0; i < x; i++) {
    _detailList.add(prefs.getStringList(i.toString())??["no data"]);
  }

  List<List<String>> result = [];

  RegExp exp =RegExp(r"2021年"+month+"月"+day);

  RegExp exp2 = RegExp(r"2021年" + month + "月0" + day);

  if (int.parse(day)<10){
    for (int i = 0; i < x; i++) {
      if (exp2.hasMatch(_detailList[i][2])) {
        result.add(_detailList[i]);
      }
    }
  }else{
    for (int i = 0; i < x; i++) {
      if (exp.hasMatch(_detailList[i][2])) {
        result.add(_detailList[i]);
      }
    }

  }
  int sum=0;
  for (int i = 0; i < result.length; i++) {
    if(int.parse(result[i][1])>4)//收入
      sum+=int.parse(result[i][0]);
  }
  return sum;
}

