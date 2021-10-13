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
  int _gdsz=0;    //固定收支
  bool _typeOfGdsz=true;  //收入还是支出，true为收入，false为支出
  int _value1 = 1; //收入还是支出，下拉选项框参数
  int _value2 = 1; //具体来源或者用途，下拉选项框参数
  var textFieldMoney;
  double width = 0.0;
  double height = 0.0;
  SharedPreferences prefs=GlobalData.getPref()!;
  TextEditingController textFieldController=new TextEditingController();


  @override
  void initState() {
    _todayExpenditure=prefs.getInt('todayExpenditure')??0;
    _monthExpenditure=prefs.getInt('monthExpenditure')??0;
    _gdsz=prefs.getInt('gdsz')??0;
    _typeOfGdsz=prefs.getBool('typeOfGdsz')??true;
    super.initState();
  }

  bool isNumber(String str) {   //检查一个金额输入的是否全部是数字
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
          height: 30,
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
      padding: EdgeInsets.all(30.0),
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
          ),
          Container(
            child: fixedPage(),
          ),
          Container(
            child: Text(" "),
          ),
          Container(
            child: logOutPage(),
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
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
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
                                _value1=value as int;
                              });
                            },
                          ),
                          SizedBox(width: 30),
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
                            onChanged: (v){
                              setState(() {
                                //print(v);
                                _value2=v as int;
                                print(_value2);
                              });
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: textFieldController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "金额",
                                    hintStyle: TextStyle(fontSize: 18)),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "备注",
                              hintStyle: TextStyle(fontSize: 18)),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            if(isNumber(textFieldController.text)){
                              int x=int.parse(textFieldController.text);
                              prefs.setInt('gdsz', x);
                              print(_gdsz);
                              if(_typeOfGdsz){
                                //_todayExpenditure+=_gdsz;
                                _monthExpenditure+=_gdsz;
                              }else {
                                //_todayExpenditure-=_gdsz;
                                _monthExpenditure-=_gdsz;
                              }

                              if(_value1==2){
                                prefs.setBool('typeOfGdsz', false);
                                //_todayExpenditure+=x;
                                _monthExpenditure+=x;
                              }else{
                                prefs.setBool('typeOfGdsz', true);
                                //_todayExpenditure-=x;
                                _monthExpenditure-=x;
                              }
                              //prefs.setInt('todayExpenditure', _todayExpenditure);
                              prefs.setInt('monthExpenditure', _monthExpenditure);

                              print('固定收支设置为${prefs.getInt('gdsz')}');
                            }else{
                              Fluttertoast.showToast(msg: '数据不合理');
                            }
                            Navigator.pop(context);
                          },
                          child: Text("确定"))
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.pan_tool_sharp,
            size:25,
            color:Provider.of<ThemeProvider>(context).color2,)),
      Text('固定收支', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.w900,
          color:Provider.of<ThemeProvider>(context).color6 ),)
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
