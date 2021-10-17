import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'package:twt_account/add_configure/adding_what_list.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';

class AddConfigure extends StatefulWidget {
  const AddConfigure({Key? key}) : super(key: key);

  @override
  _AddConfigureState createState() => _AddConfigureState();
}

class _AddConfigureState extends State<AddConfigure> {
  int tallyMoneyStable = 0;
  int addingWhatStable = 0;
  int tallyMoneyTemplate = 0;
  int tallyMoney = 0; //钱数
  int addingWhat = 0; //种类
  String ps = "无备注"; //备注
  String dateElse = "加载错误！"; //展示的天时分秒
  SharedPreferences prefs = GlobalData.getPref()!;
  int _itemCount = 0;
  int _itemCount2 = 0;

  String addingWhatShow = '载入失败';
  bool flag = false;
  bool _isShow = true;
  bool _1isShow = true;
  bool _2isShow = true;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    _itemCount = prefs.getInt('itemCount') ?? 0;
    _itemCount2 = prefs.getInt('itemCount2') ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context)!.settings.arguments;
    tallyMoneyStable = int.parse(obj['tallyMoney']);
    addingWhatStable = int.parse(obj['addingFuckInWhat']);
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    if (!flag) {
      tallyMoney = tallyMoneyStable;
      addingWhat = addingWhatStable;
    }
    if (addingWhat == 9) {
      addingWhat = 1;
    }
    if (addingWhat == 0) {
      addingWhat = 8;
    }
    addingWhatShow = AddingWhat.addingWhatList[addingWhat];
    dateElse = DateTime.now().toString().substring(5, 19);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              //height: 80,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/detailMessagePage");
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Provider.of<ThemeProvider>(context).outer,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Icon(
                                Icons.list,
                                size: 40,
                                color: Provider.of<ThemeProvider>(context)
                                    .mainFont,
                              )),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "明细",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/moreThingsPage");
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      //color: Provider.of<ThemeProvider>(context).background,
                      child: Icon(
                        Icons.person,
                        size: 25,
                        color: Provider.of<ThemeProvider>(context).mainFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(),
                  child: mainPage(),
                )),
                Container(
                    width: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/statisPage");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Provider.of<ThemeProvider>(context).outerSide,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.stacked_bar_chart,
                                size: 30,
                                // color: Provider.of<ThemeProvider>(context)
                                //     .mainFont,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "统\n计",
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
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ' 将要记下：',
              textScaleFactor: 3.0,
              style: TextStyle(
                // color: Provider.of<ThemeProvider>(context)
                //     .assistFont,
                fontWeight: FontWeight.w900,
                shadows: <Shadow>[],
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              setState(() {
                _1isShow = !_1isShow;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                        blurRadius: 1.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ],
                  color: Provider.of<ThemeProvider>(context).confirmMid,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              width: width - 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(children: [
                  Container(
                    height: 20,
                  ),
                  Text(
                    '记账金额',
                    style: TextStyle(
                        // color: Provider.of<ThemeProvider>(context)
                        //     .mainFont,
                        fontWeight: FontWeight.w600),
                    textScaleFactor: 1.5,
                  ),
                  Container(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Offstage(
                        offstage: !_1isShow,
                        child: Text(
                          '$tallyMoney',
                          textScaleFactor: 5.0,
                          style: TextStyle(
                              // color: Provider.of<ThemeProvider>(context)
                              //     .mainFont
                              ),
                        ),
                      ),
                      Offstage(
                        offstage: _1isShow,
                        child: Container(
                          width: width - 50,
                          child: Row(
                            children: [
                              Container(
                                width: width - 170,
                                child: TextField(
                                  // cursorColor: Provider.of<ThemeProvider>(context)
                                  //     .assistFont,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    hintText: "修改记账金额：当前 $tallyMoney",
                                    hintStyle: TextStyle(
                                        // color: Provider.of<ThemeProvider>(context)
                                        //     .assistFont
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (text) {
                                    print(text);
                                    tallyMoneyTemplate = int.parse(text);
                                    flag = true;
                                  },
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF2F2E41),
                                    elevation: 1.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _1isShow = !_1isShow;
                                      tallyMoney = tallyMoneyTemplate;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    child: Icon(
                                      Icons.check_box_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Provider.of<ThemeProvider>(context).confirmMid,
                            elevation: 1.0,
                          ),
                          onPressed: () {
                            setState(() {
                              flag = true;
                              tallyMoney = tallyMoney - 10;
                            });
                          },
                          child: Icon(
                            Icons.arrow_downward_sharp,
                            color: Provider.of<ThemeProvider>(context).mainFont,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1.0,
                            primary:
                                Provider.of<ThemeProvider>(context).confirmMid,
                          ),
                          onPressed: () {
                            setState(() {
                              flag = true;
                              tallyMoney = tallyMoney - 1;
                            });
                          },
                          child: Icon(
                            Icons.arrow_drop_down,
                            // color: Provider.of<ThemeProvider>(context)
                            //       .mainFont,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Provider.of<ThemeProvider>(context).confirmMid,
                            elevation: 1.0,
                          ),
                          onPressed: () {
                            setState(() {
                              flag = true;
                              tallyMoney = tallyMoney + 1;
                            });
                          },
                          child: Icon(
                            Icons.arrow_drop_up,
                            // color: Provider.of<ThemeProvider>(context)
                            //     .mainFont,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Provider.of<ThemeProvider>(context).confirmMid,
                            elevation: 1.0,
                          ),
                          onPressed: () {
                            flag = true;
                            tallyMoney = tallyMoney + 10;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.arrow_upward_sharp,
                            // color: Provider.of<ThemeProvider>(context)
                            //     .mainFont,
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                ]),
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _2isShow = !_2isShow;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).confirmMid,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: width - 80,
              child: Column(children: [
                Container(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    '$addingWhatShow',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ),
                Offstage(
                  offstage: _2isShow,
                  child: Column(children: [
                    Container(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 1.0,
                            ),
                            onPressed: () {
                              setState(() {
                                flag = true;
                                addingWhat--;
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color:
                                  Provider.of<ThemeProvider>(context).mainFont,
                            ),
                          ),
                          Text(
                            '更改',
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .mainFont,
                                fontWeight: FontWeight.w900),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 1.0,
                            ),
                            onPressed: () {
                              setState(() {
                                flag = true;
                                addingWhat++;
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color:
                                  Provider.of<ThemeProvider>(context).mainFont,
                            ),
                          ),
                        ]),
                  ]),
                ),
                Container(
                  height: 10,
                ),
              ]),
            ),
          ),
          Container(
            height: 20,
          ),
          Container(
            width: width - 50,
            child: Row(
              children: [
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 212, 164, 164),
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: width / 2 - 135,
                    height: 60,
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 162, 219, 170),
                      elevation: 5.0,
                    ),
                    onPressed: () async {
                      if (tallyMoney == 0) {
                        Fluttertoast.showToast(msg: "数据不合理");
                      } else {
                        int a = prefs.getInt('todayExpenditure') ?? 0;
                        int b = prefs.getInt('monthExpenditure') ?? 0;
                        if (addingWhat > 0 && addingWhat <= 4) {
                          prefs.setInt('todayExpenditure', a - tallyMoney);
                          prefs.setInt('monthExpenditure', b - tallyMoney);
                        } else {
                          prefs.setInt('todayExpenditure', a + tallyMoney);
                          prefs.setInt('monthExpenditure', b + tallyMoney);
                        }
                        String dateTime = formatDate(DateTime.now(),
                            ['yyyy', '年', 'mm', '月', 'dd', '日']);
                        List<String> item = [
                          tallyMoney.toString(),
                          addingWhat.toString(),
                          dateTime
                        ];
                        print('itemCount ${_itemCount + 1} is saved');
                        print('item $item is saved');
                        prefs.setInt('itemCount', _itemCount + 1);
                        prefs.setInt('itemCount2', _itemCount2 + 1);
                        prefs.setStringList(_itemCount.toString(), item);
                        String date = dateTime.substring(0, 4) +
                            '/' +
                            dateTime.substring(5, 7) +
                            '/' +
                            dateTime.substring(8, 10) +
                            ' ' +
                            '00:00:00';
                        print(date);
                        print(_itemCount);
                        ////////
                        var response = await Dio().post(
                            "http://121.43.164.122:3390/user/addtally",
                            queryParameters: {
                              "userName": prefs.getStringList('user')![0],
                              "tallyDatetime": date,
                              "tallyDiscription": tallyMoney.toString(),
                              "tallyId": _itemCount,
                              "tallyLabels": addingWhat,
                            });
                        print(response);
                        ////////
                        Navigator.popAndPushNamed(
                            context, "/detailMessagePage");
                      }
                    },
                    child: Container(
                      height: 60,
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Stack(children: [
            Offstage(
              offstage: !_isShow,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Provider.of<ThemeProvider>(context).confirmMid,
                  elevation: 5.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: new BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).confirmMid,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                  ),
                  height: 100,
                  width: width - 80,
                  child: Text(
                    '更多选项:',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Provider.of<ThemeProvider>(context).mainFont,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isShow = !_isShow;
                  });
                },
              ),
            ),
            Offstage(
              offstage: _isShow,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                ),
                height: 100,
                width: width - 80,
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "键入备注:",
                    ),
                    onChanged: (text) {
                      print(text);
                      ps = text;
                      flag = true;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 1.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _isShow = !_isShow;
                      });
                    },
                    child: Icon(Icons.arrow_back_ios_sharp,
                        color: Colors.black, size: 20.0),
                  ),
                ]),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
