import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/data/toast_provider.dart';

import 'theme/theme_config.dart';

class MoreThingsPage extends StatefulWidget {
  const MoreThingsPage({Key? key, int? data}) : super(key: key);

  @override
  _MoreThingsPageState createState() => _MoreThingsPageState();
}

class _MoreThingsPageState extends State<MoreThingsPage> {
  int _keepCounts = 0;
  int _keepDays = 1;
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
    int x=prefs.getInt("itemCount") ?? 0;
    for(int i=0;i<x;i++){
      if((prefs.getStringList(i.toString()) ?? ["0", "0", "no data"][1])!='0'){
        _keepCounts++;
      }
    }

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
                    //color: Provider.of<ThemeProvider>(context).background,
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
                          color: Provider.of<ThemeProvider>(context).outerSide,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Icon(
                            Icons.stacked_bar_chart,
                            size: 25,
                            //color: Provider.of<ThemeProvider>(context).outer,
                          )),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "统计",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
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
          height: 80,
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
          height: 40,
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
                    padding: EdgeInsets.all(5.0),
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
                                      hintText: "金额",
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
                                    if (textFieldController.text.isEmpty)
                                      x = _gdsz;
                                    else
                                      x = int.parse(textFieldController.text);
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
              color: Color(0x0C000000),
              shape: BoxShape.circle,
              border: new Border.all(
                //边框颜色
                color: Color(0xFFA1A1A1),
              ),
            ),
            child: Icon(Icons.person,
            size: 35,
            color: Colors.black54,),
            height: 200,
            width: 50,
          ),

          ///用户名
          Text(
            prefs.getStringList('user')![1],
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.black38),
          ),

          ///退出登录
          IconButton(
            onPressed: () {
              ToastProvider.success("退出登录成功");
              Navigator.pushNamed(context, "/loginInPage");
            },
            icon: Icon(Icons.logout),
            iconSize: 40,
            color: Colors.black,
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
      SizedBox(height: 30)
    ]);
  }

  Widget gridViewPage() {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(70.0)),
                        border: new Border.all(
                          width: 1,
                          color: Colors.white24,
                        ),
                        //color: Provider.of<ThemeProvider>(context).background,
                      ),
                      child: skinPage(),
                    ),
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: new Border.all(
                          width: 1,
                          color: Colors.white24,
                        ),
                        //color: Provider.of<ThemeProvider>(context).background,
                      ),
                      child: fixedPage(),
                    ),
                  ]),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: new Border.all(
                      width: 1,
                      color: Colors.white24,
                    ),
                    // color: Provider.of<ThemeProvider>(context).background,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     offset: Offset(0.0, 0.0), //阴影x轴偏移量
                    //     blurRadius: 4, //阴影模糊程度
                    //   )
                    // ],
                  ),
                  child: AddPage(),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: new Border.all(
                      width: 1,
                      color: Colors.white24,
                    ),
                    //color: Provider.of<ThemeProvider>(context).background,
                  ),

                ),

              ])
            ]));
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
            // color: Provider.of<ThemeProvider>(context).mainFont
          ),
        ),
        Text(
          "记账天数",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            // color: Provider.of<ThemeProvider>(context).assistFont
          ),
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
            //color: Provider.of<ThemeProvider>(context).mainFont
          ),
        ),
        Text(
          "记账笔数",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            // color: Provider.of<ThemeProvider>(context).assistFont,
          ),
        )
      ],
    ));
  }

  Widget skinPage() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape:RoundedRectangleBorder(

          borderRadius:BorderRadius.circular(20),

        ),
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
              // color: Provider.of<ThemeProvider>(context).background,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '个性装扮',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                // color: Provider.of<ThemeProvider>(context).background
              ),
            ),
          ]),
    );
  }

  Widget fixedPage() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape:RoundedRectangleBorder(

            borderRadius:BorderRadius.circular(20),

          ),),
        onPressed: () {
          setState(() {
            _offstage = !_offstage;
          });
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.library_books,
                size: 40,
                // color: Provider.of<ThemeProvider>(context).assistFont,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '固定收支',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  // color: Provider.of<ThemeProvider>(context).mainFont
                ),
              ),
            ]));
  }

  Widget AddPage() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape:RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20),

          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  content: Text('更多自定义功能敬请期待！',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                );
              });
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 40,
                // color: Provider.of<ThemeProvider>(context).assistFont,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '更多功能',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  // color: Provider.of<ThemeProvider>(context).mainFont
                ),
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).moreBackground,
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
                          color: Provider.of<ThemeProvider>(context).outer,
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
                              Icons.library_books,
                              size: 30,
                              //color:
                              // Provider.of<ThemeProvider>(context).mainFont,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "明\n细",
                            style: TextStyle(
                                fontSize: 20,
                                // color: Provider.of<ThemeProvider>(context)
                                //     .mainFont,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
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
