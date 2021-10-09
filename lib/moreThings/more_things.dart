import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twt_account/data/toast_provider.dart';

import 'theme/theme_config.dart';

class MoreThingsPage extends StatefulWidget {
  const MoreThingsPage({Key? key, int? data}) : super(key: key);

  @override
  _MoreThingsPageState createState() => _MoreThingsPageState();
}

class _MoreThingsPageState extends State<MoreThingsPage> {
  int _keepCounts = 0;
  int _keepDays = 0;
  // double _todayExpenditure = 0;
  // double _monthExpenditure = 0;
  double width = 0.0;
  double height = 0.0;

  Widget bottom(context) {
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
                    Navigator.popAndPushNamed(context, "/myPage");
                  },
                  child: Icon(
                    Icons.contacts,
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
                    Navigator.popAndPushNamed(context, "/askingPricePage");
                  },
                  child: Container(
                    width: width - 84,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Icon(
                          Icons.attach_money,
                          size: 25,
                          color: Provider.of<ThemeProvider>(context).color2,
                        )),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "问价",
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

  Widget mainPage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
                border: new Border.all(
                  width: 1,
                  color: Colors.white70,
                ),
                image: new DecorationImage(
                  alignment: Alignment.centerRight,
                  image: new AssetImage('assets/images/furry.png'),
                ),
              ),
              height: 70,
              width: 70,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '付瑞',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Provider.of<ThemeProvider>(context).color2),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: new Border.all(
                  width: 1,
                  color: Colors.white24,
                ),
                color: Provider.of<ThemeProvider>(context).color1,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //阴影x轴偏移量
                      blurRadius: 2, //阴影模糊程度
                      spreadRadius: 2 //阴影扩散程度
                      )
                ],
              ),
              child: gridViewPage(),
            ),
          ),
        ),
      ],
    );
  }

  Widget gridViewPage() {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            child: daysPage(),
          ),
          Container(
            child: cntPage(),
          ),
          Container(
            child: skinPage(),
          ), //主题没法变色
          Container(
            child: fixedPage(),
          ),
          Container(
            child: Text(" "),
          ),
          Container(
            child: logOutPage(),
          ), //logout不显示？？？
        ],
      ),
    );
  }

  Widget daysPage() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$_keepDays",
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 55,
              color: Provider.of<ThemeProvider>(context).color2),
        ),
        Text(
          "记账天数",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: Provider.of<ThemeProvider>(context).color6),
        )
      ],
    ));
  }

  Widget cntPage() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$_keepCounts",
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 55,
              color: Provider.of<ThemeProvider>(context).color2),
        ),
        Text(
          "记账笔数",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Provider.of<ThemeProvider>(context).color6,
          ),
        )
      ],
    ));
  }

  Widget skinPage() {
    return Column(children: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/skinPage");
        },
        icon: Icon(Icons.style_outlined),
        iconSize: 30,
        color: Provider.of<ThemeProvider>(context).color2,
      ),
      Text(
        '皮肤',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Provider.of<ThemeProvider>(context).color6),
      ),
    ]);
  }

  Widget fixedPage() {
    return Column(children: <Widget>[
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.pan_tool_sharp,
            size: 25,
            color: Provider.of<ThemeProvider>(context).color2,
          )),
      Text(
        '固定收支',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Provider.of<ThemeProvider>(context).color6),
      ),
    ]);
  }

  Widget logOutPage() {
    return Column(children: [
      IconButton(
        onPressed: () {
          ToastProvider.success("退出登录成功");
          Navigator.pushNamed(context, "/loginInPage");
        },
        icon: Icon(Icons.person),
        iconSize: 35,
        color: Provider.of<ThemeProvider>(context).color2,
      ),
      Text(
        '退出登录',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Provider.of<ThemeProvider>(context).color6),
      )
    ]);
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
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Provider.of<ThemeProvider>(context).color1,
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/detailMessagePage");
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.menu_open,
                            size: 30,
                            color: Provider.of<ThemeProvider>(context).color2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "明\n细",
                          style: TextStyle(
                              fontSize: 20,
                              color: Provider.of<ThemeProvider>(context).color2,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: mainPage(),
                  flex: 9,
                ),
              ],
            ),
          ),
          bottom(context),
        ],
      ),
    );
  }
}
