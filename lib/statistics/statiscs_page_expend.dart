import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/statistics/pie_expend.dart';
import 'package:twt_account/statistics/sales.dart';
import 'line_expend.dart';

class StatisExpendPage extends StatefulWidget {
  const StatisExpendPage({Key? key}) : super(key: key);

  @override
  _StatisExpendPageState createState() => _StatisExpendPageState();
}

SharedPreferences prefs = GlobalData.getPref()!;
DateTime now = new DateTime.now();
double _monthExpend = (getMonth(now.month.toString(), 5) +
        getMonth(now.month.toString(), 6) +
        getMonth(now.month.toString(), 7) +
        getMonth(now.month.toString(), 8)) ??
    0;
int counts = getExpendCounts(now.month.toString());

class _StatisExpendPageState extends State<StatisExpendPage> {
  double width = 0.0;
  double height = 0.0;
  String date1OnTop = "加载错误！";
  String date2OnTop = "加载错误！";
  bool flag = false;

  Widget top(context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 50,
        height: 50,
        child: IconButton(
          icon: Icon(Icons.library_books),
          onPressed: () {
            Navigator.pushNamed(context, "/detailMessagePage");
          },
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/moreThingsPage");
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.black,
                )),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "我的",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget right(context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '$date1OnTop年$date2OnTop月',
            style: TextStyle(
              fontSize: 35,
              // color: Provider.of<ThemeProvider>(context).mainFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(children: [
            Expanded(
              child: SizedBox(),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.zero,
                  //  elevation: 5.0,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/statisPage");
                },
                child: Text(
                  '收入',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2F2E41),
                  padding: EdgeInsets.zero,
                  elevation: 5.0,
                ),
                onPressed: () {},
                child: Text(
                  '支出',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
          ]),
          SizedBox(
            child: card(),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
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

            child: SizedBox(
              width: 400,
              height: 170,
              child: getLine_e(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              '收入类别图',
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
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),

            child: Container(
              width: 400,
              height: 170,
              alignment: Alignment.center,
              child: getPie_e(),
            ),
          ),
        ],
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
            alignment: Alignment(-1, -1),
            child: Column(children: <Widget>[
              Text(
                '本月支出$counts笔，合计',
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
                "¥$_monthExpend",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600, //字体大小
                ),
              ),
            ])));
    return card;
  }

  Widget getPie_e() {
    List<Piesales> dataPie = [
      Piesales(1, getMonth(now.month.toString(), 5),
          Provider.of<ThemeProvider>(context).pieColor[0], "学习"),
      Piesales(2, getMonth(now.month.toString(), 6),
          Provider.of<ThemeProvider>(context).pieColor[1], "娱乐"),
      Piesales(3, getMonth(now.month.toString(), 7),
          Provider.of<ThemeProvider>(context).pieColor[2], "交通"),
      Piesales(4, getMonth(now.month.toString(), 8),
          Provider.of<ThemeProvider>(context).pieColor[3], "工资"),
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
    );
    return Pie;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    if (!flag) {
      date2OnTop = DateTime.now().toString().substring(5, 7);
      date1OnTop = DateTime.now().toString().substring(0, 4);
    }
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).outerSide,
      body:SafeArea(
        child: Column(children: [
          top(context),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/myPage");
                    },
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.home,
                              size: 30,
                              color:
                              Provider.of<ThemeProvider>(context).mainFont,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "首\n页",
                            style: TextStyle(
                                fontSize: 20,
                                color: Provider.of<ThemeProvider>(context)
                                    .mainFont,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: right(context),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Card card() {
  var card = Card(
      color: Colors.white,
      shadowColor: Colors.grey.shade800,
      // 阴影颜色
      //elevation: 10, // 阴影高度
      borderOnForeground: false,
      // 是否在 child 前绘制 border，默认为 true
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      // 外边距

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: Container(
          alignment: Alignment(-1, -1),
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Text(
              '本月支出$counts笔，合计',
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
              "¥$_monthExpend",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600, //字体大小
              ),
            ),
          ])));
  return card;
}