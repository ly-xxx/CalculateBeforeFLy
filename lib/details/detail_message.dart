import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';
import 'dart:ui';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:twt_account/add_configure/adding_what_list.dart';

class DetailMessagePage extends StatefulWidget {
  const DetailMessagePage({Key? key}) : super(key: key);

  @override
  _DetailMessagePageState createState() => _DetailMessagePageState();
}

class _DetailMessagePageState extends State<DetailMessagePage> {
  double width = 0.0;
  double height = 0.0;
  Color edgeOfTab = Colors.black;
  String date1OnTop = "加载错误！";
  String date2OnTop = "加载错误！";
  bool flag = false;
  SharedPreferences prefs = GlobalData.getPref()!;
  //final p=GlobalData.instance;
  List<List<String>> _detailList = [];
  //
  @override
  void initState() {
    int x = prefs.getInt("itemCount") ?? 0;
    print('x is $x');
    for (int i = 0; i < x; i++) {
      //y.add(i);
      _detailList.add(prefs.getStringList(i.toString())??["no data"]);
      print('get StringList $i is ${prefs.getStringList(i.toString())}');
    }
    super.initState();
  }

  _remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  ScrollController _controller = ScrollController();

  Widget bottom(context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeProvider>(context).outer,
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/myPage");
                  },
                  child: Container(
                    width: width - 84,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Icon(
                              Icons.contacts,
                              size: 25,
                              color: Provider.of<ThemeProvider>(context).mainFont,
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "我",
                          style: TextStyle(
                              fontSize: 20,
                              color: Provider.of<ThemeProvider>(context).mainFont,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/askingPricePage");
                  },
                  child: Icon(
                    Icons.attach_money,
                    size: 20,
                    color: Provider.of<ThemeProvider>(context).mainFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    edgeOfTab = Provider.of<ThemeProvider>(context).mainFont;
    if (!flag) {
      date2OnTop = DateTime.now().toString().substring(5, 7);
      date1OnTop = DateTime.now().toString().substring(0, 4);
    }
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).background,
      body: Stack(children: [
        Positioned(
          top: -30,
          left: 0,
          child: Text(
            '明细',
            style: TextStyle(
              fontSize: 180,
              color: Colors.white24,
              fontWeight: FontWeight.w900,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 1.0,
                  color: Color.fromARGB(20, 10, 10, 100),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 30,
          child: InkWell(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1970, 1, 1),
                  maxTime: DateTime(2098, 12, 31),
                  onChanged: (date) {}, onConfirm: (date) {
                    setState(() {
                      flag = true;
                      date2OnTop = date.toString().substring(5, 7);
                      date1OnTop = date.toString().substring(0, 4);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.zh);
            },
            child: Row(
              children: [
                Text(
                  '$date1OnTop年$date2OnTop月',
                  style: TextStyle(
                    fontSize: 40,
                    color: Provider.of<ThemeProvider>(context).mainFont,
                    fontWeight: FontWeight.w900,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Color.fromARGB(120, 10, 10, 100),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 40,
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: detailMessage(),
                    flex: 9,
                  ),
                  Container(
                    width: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: Provider.of<ThemeProvider>(context).outer,
                        elevation: 5.0,
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/moreThingsPage");
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.account_tree_outlined,
                              size: 30,
                              color: Provider.of<ThemeProvider>(context).mainFont,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "更\n多",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                Provider.of<ThemeProvider>(context).mainFont,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottom(context)
          ],
        ),
      ]),
    );
  }

  Widget realDetail() {
    return Scrollbar(
        controller: _controller,
        child: ListView.builder(
            controller: _controller,
            itemCount: _detailList.length,
            itemBuilder: (_, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) {
                    Future.delayed(Duration(seconds: 1));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(3, 4, 4, 1),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Provider.of<ThemeProvider>(context).outer,
                              Provider.of<ThemeProvider>(context).outer,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: new Border.all(
                            width: 1,
                            color: Provider.of<ThemeProvider>(context).mainFont,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: edgeOfTab,
                              offset: Offset(0.0, 0.0), //阴影x轴偏移量
                              blurRadius: 5, //阴影模糊程度
                              spreadRadius: 1, //阴影扩散程度
                            )
                          ],
                        ),
                        child: InkWell(
                            onTap: () {
                              print("you click it");
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.circle,
                                color:
                                Provider.of<ThemeProvider>(context).mainFont,
                              ),
                              title: Text(
                                AddingWhat.addingWhatList[int.parse(_detailList[index][1])],
                                style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont),
                              ),
                              subtitle: Text(
                                _detailList[index][2],
                                style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont),
                              ),
                              trailing: Text(
                                _detailList[index][0],
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                    color: Provider.of<ThemeProvider>(context)
                                        .mainFont),
                              ),
                            ))),
                  ));
            }));
  }

  Widget detailMessage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () => _controller.animateTo(
            -20,
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 80,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      _remove();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Provider.of<ThemeProvider>(context).outer,
                      elevation: 5.0,
                    ),
                    child: Text(
                      "流水/统计",
                      style: TextStyle(
                          fontSize: 20,
                          color: Provider.of<ThemeProvider>(context).mainFont,
                          fontWeight: FontWeight.w900),
                    )),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: Container(
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).background,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Provider.of<ThemeProvider>(context).mainFont,
                      offset: Offset(0.0, 0.0), //阴影x轴偏移量
                      blurRadius: 3, //阴影模糊程度
                      spreadRadius: 1 //阴影扩散程度
                  )
                ],
              ),
              child: Stack(children: <Widget>[
                realDetail(),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      foregroundColor:
                      Provider.of<ThemeProvider>(context).mainFont,
                      backgroundColor:
                      Provider.of<ThemeProvider>(context).mainFont,
                      elevation: 5,
                      splashColor: Colors.amber[100],
                      onPressed: () {
                        _controller.animateTo(
                          -20,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.ease,
                        );
                      },
                      child: Icon(Icons.arrow_drop_up_outlined,
                          color: Provider.of<ThemeProvider>(context).outer,
                          size: 30.0),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
