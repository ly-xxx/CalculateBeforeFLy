import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/add_configure/adding_what_list.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _todayExpenditure = 0;
  int _monthExpenditure = 0;
  int _averageDailyConsumption = 0;
  int _budget = 0;
  int valueTransfer = 0;
  int tallyMoney = 0; //金额
  double _monthExpenditureBudgetPercentage = 0;
  SharedPreferences prefs = GlobalData.getPref()!;

  double width = 0.0;
  double height = 0.0;
  int addingFuckInWhat = 0;

  /// 手指所处 x 坐标
  double currentX = 0;

  ///  X相对坐标，确定记帐品类
  double relativeX = 0;

  /// 手指所处 y 坐标
  double currentY = 0;

  ///  Y相对坐标，确定计入还是计出
  double relativeY = 0;

  ///  记账种类下方小格 1
  String tallyTitle1 = "自由";

  ///  记账种类下方小格 2
  String tallyTitle2 = "滑动";

  ///  记账种类下方小格 3
  String tallyTitle3 = "开始";

  ///  记账种类下方小格 4
  String tallyTitle4 = "记账";

  ///记账部分后期计算出来的四分之一小格宽度
  double smallTallyWidth = 0;

  ///记账container颜色参数
  int tallyContainerColor = 127;
  int halfTallyContainerColor = 63;
  int containerColor1 = 255;
  int containerColor2 = 255;
  int containerColor3 = 255;
  int containerColor4 = 255;

  ///tally黑框显示与否
  bool _isNotShow = true;

  bool get wantKeepAlive => true;

  //List<Widget> _list = [];
  // List addingWhatList = [
  //   'xixi',
  //   '收入了：生活费 工资',
  //   '收入了：理财',
  //   '收入了：学习',
  //   '收入了：其他',
  //   '支出了：餐饮 娱乐',
  //   '支出了：生活',
  //   '支出了：学习',
  //   '支出了：其他'
  // ];
  String addingWhatListOutput = "";

  get async => null;

  Color indicatorColor = Colors.black12;

  _remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void setBudget() {
    int _value = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("取消")),
                    Expanded(child: SizedBox()),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, _value);
                        },
                        child: Text("确定")),
                  ],
                ),
                Expanded(
                  child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (position) {
                        _value = position * 100;
                      },
                      children: List.generate(
                          31,
                          (index) => Text(
                                '${index * 100}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 30),
                              ))),
                ),
              ],
            ),
          );
        }).then((value) {
      setState(() {
        prefs.setInt('budget', value);
        _budget = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _budget = prefs.getInt('budget') ?? 0;
    _todayExpenditure = prefs.getInt('todayExpenditure') ?? 0;
    _monthExpenditure = prefs.getInt('monthExpenditure') ?? 0;
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    smallTallyWidth = (width - 62) / 4;
    addingWhatListOutput = AddingWhat().addingWhatList[addingFuckInWhat];
    if (_monthExpenditure == 0) {
      _monthExpenditureBudgetPercentage = 0;
    } else
      _monthExpenditureBudgetPercentage = _monthExpenditure / _budget * 0.9;
    if (_monthExpenditure > _budget)
      indicatorColor = Provider.of<ThemeProvider>(context).color5;
    else
      indicatorColor = Provider.of<ThemeProvider>(context).color4;
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).color3,
      body: Consumer<ThemeProvider>(
        builder: (_, theme, __) => Stack(children: <Widget>[
          Column(
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
                                color: theme.color1,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Icon(
                                  Icons.list,
                                  size: 40,
                                  color: theme.color2,
                                )),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "明细",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme.color2,
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
                        color: Provider.of<ThemeProvider>(context).color3,
                        child: Icon(
                          Icons.settings,
                          size: 25,
                          color: Provider.of<ThemeProvider>(context).color2,
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
                    child: mainPage(theme),
                  )),
                  Container(
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/statisPage");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: theme.color1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0))),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  size: 30,
                                  color: theme.color2,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "统\n计",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme.color2,
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
        ]),
      ),
    );
  }

  Widget mainPage(ThemeProvider theme) {
    return Stack(children: <Widget>[
      LiquidLinearProgressIndicator(
        value: _monthExpenditureBudgetPercentage,
        //当前进度 0-1
        valueColor: AlwaysStoppedAnimation(indicatorColor),
        // 进度值的颜色.
        borderColor: Provider.of<ThemeProvider>(context).color3,
        borderWidth: 1,
        backgroundColor: theme.color3,
        // 背景颜色.
        direction: Axis
            .vertical, // 进度方向 (Axis.vertical = 从下到上, Axis.horizontal = 从左到右). 默认：Axis.vertical
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Row(children: [
            SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: setBudget,
              child: _budget == 0
                  ? Text(
                      "请输入预算",
                      // "$_monthExpenditure / $_budget",..
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: theme.color2),
                    )
                  : _monthExpenditure < 0
                      ? Text(
                          '${_monthExpenditure.abs()}',
                          //"${_monthExpenditure.abs()} / $_budget",
                          // "$_monthExpenditure / $_budget",..
                          style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w900,
                              color: theme.color2),
                        )
                      : Text(
                          "${_monthExpenditure.abs()} / $_budget",
                          // "$_monthExpenditure / $_budget",..
                          style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w900,
                              color: theme.color2),
                        ),
            ),
          ]),
          Row(children: [
            SizedBox(
              width: 30,
            ),
            _monthExpenditure > 0
                ? Text(
                    "消费 / 预算",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: theme.color6),
                  )
                : _monthExpenditure < 0
                    ? Text(
                        " 收入 ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: theme.color6),
                      )
                    : Text(
                        "收入 / 预算",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: theme.color6),
                      )
          ]),
          SizedBox(height: 100),
          Expanded(
            child: tools(),
          ),
        ],
      ),
      Offstage(
        offstage: _isNotShow,
        child: Stack(
          children: <Widget>[
            // 垂直方向线性布局
            InkWell(
              child: Container(
                width: double.infinity,
                height: height,
                // 子组件居中
                color: Colors.black12,
                child: tally(),
              ),
              onTap: () {
                setState(() {
                  _isNotShow = !_isNotShow;
                });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  ///记账手势部分
  Widget tally() {
    return Stack(
      children: <Widget>[
        // 垂直方向线性布局
        Column(
          children: <Widget>[
            // 手势检测组件
            GestureDetector(
              onPanDown: (e) {
                currentX = e.localPosition.dx;
                currentY = e.localPosition.dy;
              },
              onPanUpdate: (e) {
                setState(() {
                  currentX += e.delta.dx;
                  currentY += e.delta.dy;
                  relativeX = currentX / (width - 52);
                  relativeY = currentY / height;
                  tallyMoney = (100000 *
                          (0.5 - relativeY) *
                          (0.5 - relativeY) *
                          (0.5 - relativeY) *
                          (0.5 - relativeY))
                      .floor();
                  if (relativeY < 0.5) {
                    //收入
                    tallyTitle1 = "生活费\n工资";
                    tallyTitle2 = "理财";
                    tallyTitle3 = "学习";
                    tallyTitle4 = "其他";
                    tallyContainerColor = 255;
                    halfTallyContainerColor = 192;
                    if (relativeX < 0.5) {
                      if (relativeX < 0.25) {
                        //生活费 工资
                        containerColor1 = halfTallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 1;
                      } else {
                        //理财
                        containerColor1 = tallyContainerColor;
                        containerColor2 = halfTallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 2;
                      }
                    } else {
                      if (relativeX < 0.75) {
                        //学习
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = halfTallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 3;
                      } else {
                        //其他
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = halfTallyContainerColor;
                        addingFuckInWhat = 4;
                      }
                    }
                  } else {
                    //支出
                    tallyTitle1 = "餐饮\n娱乐";
                    tallyTitle2 = "生活";
                    tallyTitle3 = "学习";
                    tallyTitle4 = "其他";
                    tallyContainerColor = 0;
                    halfTallyContainerColor = 96;
                    if (relativeX < 0.5) {
                      if (relativeX < 0.25) {
                        //餐饮 娱乐
                        containerColor1 = halfTallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 5;
                      } else {
                        //生活
                        containerColor1 = tallyContainerColor;
                        containerColor2 = halfTallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 6;
                      }
                    } else {
                      if (relativeX < 0.75) {
                        //学习
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = halfTallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        addingFuckInWhat = 7;
                      } else {
                        //其他
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = halfTallyContainerColor;
                        addingFuckInWhat = 8;
                      }
                    }
                  }
                });
              },
              // 点击事件
              onTap: () {
                setState(() {
                  _isNotShow = !_isNotShow;
                });
              },
              onPanEnd: (e) {
                Navigator.pushNamed(context, "/addConfigure", arguments: {
                  "tallyMoney": '$tallyMoney',
                  "addingFuckInWhat": '$addingFuckInWhat'
                }).then((value) => setState(() {
                      _isNotShow = !_isNotShow;
                    }));
              },

              // 手势检测的作用组件 , 监听该组件上的各种手势
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        height: height - 142,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Color.fromARGB(180, tallyContainerColor,
                              tallyContainerColor, tallyContainerColor),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 0.0), //阴影x轴偏移量
                                blurRadius: 3, //阴影模糊程度
                                spreadRadius: 1 //阴影扩散程度
                                )
                          ],
                        ),
                        // 子组件居中
                        child: Row(children: <Widget>[
                          Container(
                            width: smallTallyWidth,
                            color: Color.fromARGB(180, containerColor1,
                                containerColor1, containerColor1),
                            child: Text(
                              '$tallyTitle1',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: Color.fromARGB(
                                    180,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor),
                              ),
                            ),
                          ),
                          Container(
                            width: smallTallyWidth,
                            color: Color.fromARGB(180, containerColor2,
                                containerColor2, containerColor2),
                            child: Text(
                              '$tallyTitle2',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: Color.fromARGB(
                                    180,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor),
                              ),
                            ),
                          ),
                          Container(
                            width: smallTallyWidth,
                            color: Color.fromARGB(180, containerColor3,
                                containerColor3, containerColor3),
                            child: Text(
                              '$tallyTitle3',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: Color.fromARGB(
                                    180,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor),
                              ),
                            ),
                          ),
                          Container(
                            width: smallTallyWidth,
                            color: Color.fromARGB(180, containerColor4,
                                containerColor4, containerColor4),
                            child: Text(
                              '$tallyTitle4',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: Color.fromARGB(
                                    180,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor,
                                    255 - tallyContainerColor),
                              ),
                            ),
                          ),
                        ])),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 68,
          left: 24,
          child: Text(
            '$addingWhatListOutput',
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Color.fromARGB(180, 255 - tallyContainerColor,
                  255 - tallyContainerColor, 255 - tallyContainerColor),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
          top: 92,
          left: 24,
          child: Text(
            '$tallyMoney',
            textScaleFactor: 5.0,
            style: TextStyle(
              color: Color.fromARGB(180, 255 - tallyContainerColor,
                  255 - tallyContainerColor, 255 - tallyContainerColor),
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  ///主界面数据展示层
  Widget tools() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              width: (width - 50) / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _todayExpenditure.abs().toString(),
                    style: TextStyle(
                        fontSize: 60,
                        color: Provider.of<ThemeProvider>(context).color2,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(_todayExpenditure > 0 ? '今日支出' : '今日收入',
                      style: TextStyle(
                          fontSize: 15,
                          color: Provider.of<ThemeProvider>(context).color6,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            Container(
              width: (width - 50) / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _monthExpenditure.abs().toString(),
                    style: TextStyle(
                        fontSize: 60,
                        color: Provider.of<ThemeProvider>(context).color2,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(_monthExpenditure > 0 ? '本月支出' : '本月收入',
                      style: TextStyle(
                          fontSize: 15,
                          color: Provider.of<ThemeProvider>(context).color6,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: height / 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: (width - 50) / 2,
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isNotShow = !_isNotShow;
                          });
                        },
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              color: Provider.of<ThemeProvider>(context).color6,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(150.0))),
                          child: Center(
                            child: Text("记一笔",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                          ),
                        )),
                  ],
                )),
            Container(
              width: (width - 50) / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$_averageDailyConsumption",
                    style: TextStyle(
                        fontSize: 60,
                        color: Provider.of<ThemeProvider>(context).color2,
                        fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _remove();
                      });
                    },
                    child: Text("日均消费",
                        style: TextStyle(
                            fontSize: 15,
                            color: Provider.of<ThemeProvider>(context).color6,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
