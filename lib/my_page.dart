import 'package:date_format/date_format.dart';
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
  double _averageDailyConsumption = 0.0;     //日均消费
  int _budget = 0;
  int valueTransfer = 0;
  int tallyMoney = 0; //金额
  IconData icon = Icons.more_horiz;
  double _monthExpenditureBudgetPercentage = 0;
  SharedPreferences prefs = GlobalData.getPref()!;
  String _today='';

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
  Color tallyContainerColor = Colors.white;
  Color halfTallyContainerColor = Colors.white;
  Color containerColor1 = Colors.white;
  Color containerColor2 = Colors.white;
  Color containerColor3 = Colors.white;
  Color containerColor4 = Colors.white;
  Color textColorUnselected = Colors.white;
  Color textColorSelected = Colors.white;
  Color textColor1 = Colors.black;
  Color textColor2 = Colors.black;
  Color textColor3 = Colors.black;
  Color textColor4 = Colors.black;

  ///tally黑框显示与否
  bool _isNotShow = true;

  bool get wantKeepAlive => true;


  String addingWhatListOutput = "";

  get async => null;

  Color indicatorColor = Colors.white;


  @override
  void initState() {
    _today=formatDate(DateTime.now(), ['dd']);

    super.initState();
  }

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
    _averageDailyConsumption=_monthExpenditure/int.parse(_today);
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    smallTallyWidth = (width - 100) / 4;
    addingWhatListOutput = AddingWhat.addingWhatList[addingFuckInWhat];
    icon = AddingWhat.addingWhatListIcon[addingFuckInWhat];
    if (_monthExpenditure == 0) {
      _monthExpenditureBudgetPercentage = 0;
    } else
      _monthExpenditureBudgetPercentage = _monthExpenditure / _budget * 0.9;
    if (_monthExpenditure > _budget)
      indicatorColor = Provider.of<ThemeProvider>(context).indicatorBad;
    else
      indicatorColor = Provider.of<ThemeProvider>(context).indicatorGood;
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).background,
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
                                color: theme.background,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Icon(
                                  Icons.list,
                                  size: 40,
                                  color: theme.mainFont,
                                )),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "明细",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme.mainFont,
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
                        color: Provider.of<ThemeProvider>(context).background,
                        child: Icon(
                          Icons.settings,
                          size: 25,
                          //color: Provider.of<ThemeProvider>(context).background,
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
                              color: theme.background,
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
                                  color: theme.mainFont,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "统\n计",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme.mainFont,
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
        borderColor: Provider.of<ThemeProvider>(context).background,
        borderWidth: 1,
        backgroundColor: theme.background,
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
                        color: theme.mainFont,
                      ),
                    )
                  : _monthExpenditure < 0
                      ? Text(
                          '${_monthExpenditure.abs()}',
                          //"${_monthExpenditure.abs()} / $_budget",
                          // "$_monthExpenditure / $_budget",..
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w900,
                            color: theme.mainFont,
                          ),
                        )
                      : Text(
                          "${_monthExpenditure.abs()} / $_budget",
                          // "$_monthExpenditure / $_budget",..
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w900,
                            color: theme.mainFont,
                          ),
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
                        color: theme.assistFont),
                  )
                : _monthExpenditure < 0
                    ? Text(
                        " 收入 ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: theme.assistFont),
                      )
                    : Text(
                        "收入 / 预算",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: theme.assistFont),
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
                  tallyMoney = (150000 *
                          (0.45 - relativeY) *
                          (0.45 - relativeY) *
                          (0.45 - relativeY) *
                          (0.45 - relativeY))
                      .floor();
                  if (relativeY < 0.45) {
                    //收入
                    tallyTitle1 = "生活费";
                    tallyTitle2 = "理财";
                    tallyTitle3 = "学习";
                    tallyTitle4 = "其他";
                    tallyContainerColor =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assist1;
                    halfTallyContainerColor =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assistFont;
                    textColorUnselected =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assistFont;
                    textColorSelected =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assist1;
                    if (relativeX < 0.5) {
                      if (relativeX < 0.25) {
                        //生活费 工资
                        containerColor1 = halfTallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorSelected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 1;
                      } else {
                        //理财
                        containerColor1 = tallyContainerColor;
                        containerColor2 = halfTallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorSelected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 2;
                      }
                    } else {
                      if (relativeX < 0.75) {
                        //学习
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = halfTallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorSelected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 3;
                      } else {
                        //其他
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = halfTallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorSelected;
                        addingFuckInWhat = 4;
                      }
                    }
                  } else {
                    //支出
                    tallyTitle1 = "娱乐";
                    tallyTitle2 = "生活";
                    tallyTitle3 = "学习";
                    tallyTitle4 = "其他";
                    tallyContainerColor =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assist2;
                    halfTallyContainerColor =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assistFont;
                    textColorUnselected =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assistFont;
                    textColorSelected =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .assist2;
                    if (relativeX < 0.5) {
                      if (relativeX < 0.25) {
                        //餐饮 娱乐
                        containerColor1 = halfTallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorSelected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 5;
                      } else {
                        //生活
                        containerColor1 = tallyContainerColor;
                        containerColor2 = halfTallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorSelected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 6;
                      }
                    } else {
                      if (relativeX < 0.75) {
                        //学习
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = halfTallyContainerColor;
                        containerColor4 = tallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorSelected;
                        textColor4 = textColorUnselected;
                        addingFuckInWhat = 7;
                      } else {
                        //其他
                        containerColor1 = tallyContainerColor;
                        containerColor2 = tallyContainerColor;
                        containerColor3 = tallyContainerColor;
                        containerColor4 = halfTallyContainerColor;
                        textColor1 = textColorUnselected;
                        textColor2 = textColorUnselected;
                        textColor3 = textColorUnselected;
                        textColor4 = textColorSelected;
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
                if (tallyMoney == 0) {
                  _isNotShow = !_isNotShow;
                } else {
                  Navigator.pushNamed(context, "/addConfigure", arguments: {
                    "tallyMoney": '$tallyMoney',
                    "addingFuckInWhat": '$addingFuckInWhat'
                  }).then((value) => setState(() {
                        _isNotShow = !_isNotShow;
                      }));
                }
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
                        height: height - 182,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: tallyContainerColor,
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
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(3),
                            width: smallTallyWidth,
                            decoration: BoxDecoration(
                              color: containerColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont,
                                    offset: Offset(1.0, 1.0), //阴影x轴偏移量
                                    blurRadius: 1, //阴影模糊程度
                                    spreadRadius: 0 //阴影扩散程度
                                    )
                              ],
                            ),
                            child: Text(
                              '$tallyTitle1',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: textColor1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(3),
                            width: smallTallyWidth,
                            decoration: BoxDecoration(
                              color: containerColor2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont,
                                    offset: Offset(1.0, 1.0), //阴影x轴偏移量
                                    blurRadius: 1, //阴影模糊程度
                                    spreadRadius: 0 //阴影扩散程度
                                    )
                              ],
                            ),
                            child: Text(
                              '$tallyTitle2',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: textColor2,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(3),
                            width: smallTallyWidth,
                            decoration: BoxDecoration(
                              color: containerColor3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont,
                                    offset: Offset(1.0, 1.0), //阴影x轴偏移量
                                    blurRadius: 1, //阴影模糊程度
                                    spreadRadius: 0 //阴影扩散程度
                                    )
                              ],
                            ),
                            child: Text(
                              '$tallyTitle3',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: textColor3,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(3),
                            width: smallTallyWidth,
                            decoration: BoxDecoration(
                              color: containerColor4,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont,
                                    offset: Offset(1.0, 1.0), //阴影x轴偏移量
                                    blurRadius: 1, //阴影模糊程度
                                    spreadRadius: 0 //阴影扩散程度
                                    )
                              ],
                            ),
                            child: Text(
                              '$tallyTitle4',
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                color: textColor4,
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
          top: 53,
          left: 24,
          child: Row(
            children: [
              SizedBox(width: 5),
              Icon(
                icon,
                color: Provider.of<ThemeProvider>(context).mainFont,
              ),
              SizedBox(width: 10),
              Text(
                '$addingWhatListOutput',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).mainFont,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 77,
          left: 24,
          child: Row(
            children: [
              Text(
                '￥',
                textScaleFactor: 2.0,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).mainFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$tallyMoney',
                textScaleFactor: 5.0,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).mainFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
                        color: Provider.of<ThemeProvider>(context).mainFont,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(_todayExpenditure > 0 ? '今日支出' : '今日收入',
                      style: TextStyle(
                          fontSize: 15,
                          color: Provider.of<ThemeProvider>(context).assistFont,
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
                        color: Provider.of<ThemeProvider>(context).mainFont,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(_monthExpenditure > 0 ? '本月支出' : '本月收入',
                      style: TextStyle(
                          fontSize: 15,
                          color: Provider.of<ThemeProvider>(context).assistFont,
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
                              color: Provider.of<ThemeProvider>(context)
                                  .assistFont,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(150.0))),
                          child: Center(
                            child: Text("记一笔",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Provider.of<ThemeProvider>(context)
                                        .outer,
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
                    _averageDailyConsumption.abs().toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 60,
                        color: Provider.of<ThemeProvider>(context).mainFont,
                        fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _remove();
                      });
                    },
                    child: _averageDailyConsumption>0?Text("日均消费",
                        style: TextStyle(
                            fontSize: 15,
                            color: Provider.of<ThemeProvider>(context).background,
                            fontWeight: FontWeight.w900))
                    :Text("日均收入",
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Provider.of<ThemeProvider>(context).assistFont,
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
