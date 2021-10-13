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

SharedPreferences prefs = GlobalData.getPref()!;
int _keepCounts = prefs.getInt('itemCount') ?? 0;

class _MoreThingsPageState extends State<MoreThingsPage> {

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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0))
                      ),
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
          shadowColor: Colors.grey.shade800, // 阴影颜色
          //elevation: 10, // 阴影高度
          borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10), // 外边距
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
            child: gridViewPage(),
          ),
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
          SizedBox(
            width: 50,
          ),
          cntPage(),
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
              fontWeight: FontWeight.w500,
              fontSize: 55,
              color: Provider.of<ThemeProvider>(context).color2),
        ),
        Text(
          "记账天数",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
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
              fontWeight: FontWeight.w500,
              fontSize: 60,
              color: Provider.of<ThemeProvider>(context).color2),
        ),
        Text(
          "记账笔数",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
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
        SizedBox(height: 10,),
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
        onPressed: () {},
    child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.library_books,
            size: 40,
            color: Provider.of<ThemeProvider>(context).color2,
          ),
          SizedBox(height: 10,),
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
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0))
                      ),
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

                                color: Provider.of<ThemeProvider>(context).color2,
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
