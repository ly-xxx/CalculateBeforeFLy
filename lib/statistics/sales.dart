import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Linesales {
  DateTime time;
  int sale;
  charts.Color color;
  Linesales(this.time, this.sale,Color color)
  :this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class Piesales {
  int type;
  double income;
  charts.Color color;
  String what;
  Piesales(this.type, this.income, Color color,this.what)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
