import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/data/toast_provider.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';

class MoreThingsPage extends StatefulWidget {
  const MoreThingsPage({Key? key, int? data}) : super(key: key);

  @override
  _MoreThingsPageState createState() => _MoreThingsPageState();
}

class _MoreThingsPageState extends State<MoreThingsPage> {
  int _keepCounts = 0;
  int _keepDays = 0;
  int _todayExpenditure = 0;
  int _monthExpenditure = 0;
  int _gdsz = 0; //固定收支
  bool _typeOfGdsz = true; //收入还是支出，true为收入，false为支出
  int _value1 = 1; //收入还是支出，下拉选项框参数
  int _value2 = 1; //具体来源或者用途，下拉选项框参数
  bool _offstage = false;
  var textFieldMoney;
  double width = 0.0;
  double height = 0.0;
  SharedPreferences prefs = GlobalData.getPref()!;
  TextEditingController textFieldController = new TextEditingController();

  @override
  void initState() {
    _todayExpenditure = prefs.getInt('todayExpenditure') ?? 0;
    _monthExpenditure = prefs.getInt('monthExpenditure') ?? 0;
    _gdsz = prefs.getInt('gdsz') ?? 0;
    _typeOfGdsz = prefs.getBool('typeOfGdsz') ?? true;
    super.initState();
  }

  bool isNumber(String str) {
    //检查一个金额输入的是否全部是数字
    final reg = RegExp(r'^-?[0-9]+');
    return reg.hasMatch(str);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  Widget bottom(context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, "/myPage");
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.home,
                    size: 25,
                    color: Provider.of<ThemeProvider>(context).color2,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/askingPricePage");
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Provider.of<ThemeProvider>(context).color1,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
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
                            "统计",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Provider.of<ThemeProvider>(context).color2,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    )),
              ),
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
          height: 100,
        ),
        Card(
          color: Colors.white,
          shadowColor: Colors.grey.shade800,
          // 阴影颜色
          //elevation: 10, // 阴影高度
          borderOnForeground: false,
          // 是否在 child 前绘制 border，默认为 true
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          // 外边距
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          child: getCardTop(),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Container(
              child: Stack(
            children: [
              Offstage(offstage: _offstage, child: gridViewPage()),
              Offstage(
                offstage: !_offstage,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            DropdownButton(
                              value: _value1,
                              items: [
                                DropdownMenuItem(
                                  child: Text("收入"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("支出"),
                                  value: 2,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value1 = value as int;
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            DropdownButton(
                              value: _value2,
                              items: [
                                DropdownMenuItem(
                                  child: Text("学习"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("娱乐"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("生活"),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text("餐饮"),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text("理财"),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text("工资"),
                                  value: 6,
                                ),
                                DropdownMenuItem(
                                  child: Text("生活费"),
                                  value: 7,
                                ),
                                DropdownMenuItem(
                                  child: Text("其他"),
                                  value: 8,
                                ),
                              ],
                              onChanged: (v) {
                                setState(() {
                                  //print(v);
                                  _value2 = v as int;
                                  print(_value2);
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    border: Border.all(
                                        color: Colors.black12, width: 2)),
                                child: TextField(
                                  controller: textFieldController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "金额(默认为0)",
                                      hintStyle: TextStyle(fontSize: 18)),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    border: Border.all(
                                        color: Colors.black12, width: 2)),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "备注",
                                      hintStyle: TextStyle(fontSize: 18)),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                  onPressed: () {
                                    int x;
                                    if(textFieldController.text.isEmpty)x=0;
                                    else x = int.parse(textFieldController.text);
                                    prefs.setInt('gdsz', x);
                                    print(_gdsz);
                                    if (_typeOfGdsz) {
                                      //_todayExpenditure+=_gdsz;
                                      _monthExpenditure += _gdsz;
                                    } else {
                                      //_todayExpenditure-=_gdsz;
                                      _monthExpenditure -= _gdsz;
                                    }

                                    if (_value1 == 2) {
                                      prefs.setBool('typeOfGdsz', false);
                                      //_todayExpenditure+=x;
                                      _monthExpenditure += x;
                                    } else {
                                      prefs.setBool('typeOfGdsz', true);
                                      //_todayExpenditure-=x;
                                      _monthExpenditure -= x;
                                    }
                                    //prefs.setInt('todayExpenditure', _todayExpenditure);
                                    prefs.setInt(
                                        'monthExpenditure', _monthExpenditure);

                                    print('固定收支设置为${prefs.getInt('gdsz')}');
                                    setState(() {
                                      _offstage = !_offstage;
                                    });
                                  },
                                  icon: Icon(Icons.check, size: 30)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget getCardTop() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ///圆形头像框
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            height: 200,
            width: 70,
          ),

          ///用户名
          Text(
            '用户名',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Provider.of<ThemeProvider>(context).color2),
          ),
          SizedBox(
            width: 60,
          ),

          ///退出登录
          IconButton(
            onPressed: () {
              ToastProvider.success("退出登录成功");
              Navigator.pushNamed(context, "/loginInPage");
            },
            icon: Icon(Icons.logout),
            iconSize: 40,
            color: Provider.of<ThemeProvider>(context).color2,
          ),
        ]),
      ),
      Row(
        children: [
          SizedBox(
            width: 50,
          ),
          Container(
            child: daysPage(),
          ),
          Expanded(child: SizedBox()),
          cntPage(),
          SizedBox(
            width: 50,
          )
        ],
      ),
    ]);
  }

  Widget gridViewPage() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 135,
            height: 135,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: new Border.all(
                width: 1,
                color: Colors.white24,
              ),
              color: Provider.of<ThemeProvider>(context).color1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0), //阴影x轴偏移量
                  blurRadius: 4, //阴影模糊程度
                )
              ],
            ),
            child: skinPage(),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 135,
            height: 135,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: new Border.all(
                width: 1,
                color: Colors.white24,
              ),
              color: Provider.of<ThemeProvider>(context).color1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0), //阴影x轴偏移量
                  blurRadius: 4, //阴影模糊程度
                )
              ],
            ),
            child: fixedPage(),
          ),
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Provider.of<ThemeProvider>(context).color1,
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/skinPage");
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.style_outlined,
              size: 40,
              color: Provider.of<ThemeProvider>(context).color2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '个性装扮',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Provider.of<ThemeProvider>(context).color6),
            ),
          ]),
    );
  }

  Widget fixedPage() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Provider.of<ThemeProvider>(context).color1,
        ),
        onPressed: () {
          setState(() {
            _offstage=!_offstage;
          });
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.library_books,
                size: 40,
                color: Provider.of<ThemeProvider>(context).color2,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '固定收支',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).color6),
              ),
            ]));
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
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/detailMessagePage");
                    },
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          color: Provider.of<ThemeProvider>(context).color1,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                color:
                                    Provider.of<ThemeProvider>(context).color2,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: mainPage(),
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
