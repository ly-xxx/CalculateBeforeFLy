import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/statistics/pie.dart';
import 'package:twt_account/statistics/sales.dart';

import 'line.dart';

class StatisPage extends StatefulWidget {
  const StatisPage({Key? key}) : super(key: key);

  @override
  _StatisPageState createState() => _StatisPageState();
}

class _StatisPageState extends State<StatisPage> {
  int _todayExpenditure = 0;
  int _monthExpenditure = 0;
  int _averageDailyConsumption = 0;
  int _budget = 0; //
  int valueTransfer = 0;
  int tallyMoney = 0; //金额
  double _monthExpenditureBudgetPercentage = 0;
  SharedPreferences prefs = GlobalData.getPref()!;

  double width = 0.0;
  double height = 0.0;
  int addingFuckInWhat = 0;

  Widget top(context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/detailMessagePage");
                  },
                  child: Icon(
                    Icons.menu_open,
                    size: 20,
                    color: Provider.of<ThemeProvider>(context).color2,
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeProvider>(context).color1,
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/moreThingsPage");
                  },
                  child: Container(
                    width: width - 84,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Icon(
                          Icons.account_tree_outlined,
                          size: 25,
                          color: Provider.of<ThemeProvider>(context).color2,
                        )),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "更多",
                          style: TextStyle(
                              fontSize: 20,
                              color: Provider.of<ThemeProvider>(context).color2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget left(context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Provider.of<ThemeProvider>(context).color1,
                      padding: EdgeInsets.zero,
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/myPage");
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.contacts,
                            size: 30,
                            color: Provider.of<ThemeProvider>(context).color2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "我",
                          style: TextStyle(
                              fontSize: 20,
                              color: Provider.of<ThemeProvider>(context).color2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget right(context) {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Provider.of<ThemeProvider>(context).color1,
                padding: EdgeInsets.zero,
                elevation: 5.0,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/staticsExpendPage");
              },
              child: Text(
                '看看支出',
                style: TextStyle(
                    fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).color2,
                    fontWeight: FontWeight.w500),
              )),
          SizedBox(
            height: 100,
            width: 400,
            child: card(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment(-1, -1),
            child: const Text(
              '收入趋势图',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900, //字体大小
              ),
            ),
          ),
          Card(
            color: Colors.white,
            shadowColor: Colors.grey.shade800, // 阴影颜色
            // elevation: 10, // 阴影高度
            borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
            margin: EdgeInsets.fromLTRB(10, 0, 0, 30), // 外边距

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),

            child: Container(
              width: 400,
              height: 200,
              alignment: Alignment.center,
              child: getLine(),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            alignment: Alignment(-1, -1),
            child: const Text(
              '收入类别图',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900, //字体大小
              ),
            ),
          ),
          Card(
            color: Colors.white,
            shadowColor: Colors.grey.shade800, // 阴影颜色
            //elevation: 10, // 阴影高度
            borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
            margin: EdgeInsets.fromLTRB(10, 0, 0, 30), // 外边距

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),

            child: Container(
              width: 400,
              height: 200,
              alignment: Alignment.center,
              child: getPie(),
            ),
          ),
        ],
      ),
    );
  }



Card card() {
  var card = Card(
      color: Colors.white,
      shadowColor: Colors.grey.shade800, // 阴影颜色
      //elevation: 10, // 阴影高度
      borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
      margin: EdgeInsets.fromLTRB(10, 0, 0, 10), // 外边距

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
          alignment: Alignment(-1, -1),
          child: Column(children: const <Widget>[
            
            Text(
              '本月收入合计',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15.0,
                //  fontWeight: FontWeight.w900, //字体大小
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '¥344',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900, //字体大小
              ),
            ),
          ])));
  return card;
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).color3,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          top(context),
          left(context),
          right(context),
        ],
      ),
    );
  }
}
