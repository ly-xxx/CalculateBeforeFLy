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
      //if()
      //y.add(i);
      _detailList.add(prefs.getStringList(i.toString())??["0","0","no data"]);
      print('get StringList $i is ${_detailList[i]}');
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
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/myPage");
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)),
                        color: Provider.of<ThemeProvider>(context).color1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Icon(
                                Icons.home,
                                size: 30,
                                color: Provider.of<ThemeProvider>(context).color2,
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "主页",
                            style: TextStyle(
                                fontSize: 20,
                                color: Provider.of<ThemeProvider>(context).color2,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, "/askingPricePage");
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Provider.of<ThemeProvider>(context).color3,
                  child: Icon(
                    Icons.attach_money,
                    size: 25,
                    color: Provider.of<ThemeProvider>(context).color2,
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
    edgeOfTab = Provider.of<ThemeProvider>(context).color2;
    if (!flag) {
      date2OnTop = DateTime.now().toString().substring(5, 7);
      date1OnTop = DateTime.now().toString().substring(0, 4);
    }
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).color3,
      body: Column(
          children: [
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: detailMessage(),
                    flex: 9,
                  ),
                  Container(
                    width: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/moreThingsPage");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context).color1,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.account_tree_outlined,
                              size: 30,
                              color: Provider.of<ThemeProvider>(context).color2,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "更\n多",
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
                  )
                ],
              ),
            ),
            bottom(context),
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
              if(_detailList[index][0]=='0'){
                return Container();
              }else return Dismissible(
                  key: UniqueKey(),
                  confirmDismiss: (_)async{
                    return showDialog(
                        context: context,
                        builder: (_){
                          return AlertDialog(
                            title: Text('你确定？'),
                            content: Text('你确定要删除这条记录吗？'),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop(false);
                              }, child: Text('取消')),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop(true);
                              }, child: Text('确定')),
                            ],
                          );
                        }
                    );
                  },
                  onDismissed: (_) {
                    int a=prefs.getInt('todayExpenditure')??0;
                    int b=prefs.getInt('monthExpenditure')??0;
                    int type=int.parse(_detailList[index][1]);
                    if(type<5){
                      a=a+int.parse(_detailList[index][0]);
                      b=b+int.parse(_detailList[index][0]);
                    }else{
                      a=a-int.parse(_detailList[index][0]);
                      b=b-int.parse(_detailList[index][0]);
                    }
                    setState(() {
                      prefs.setInt('todayExpenditure', a);
                      prefs.setInt('monthExpenditure', b);
                      prefs.remove(index.toString());
                      _detailList.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(3, 4, 4, 1),
                    child: Container(
                        height: 80,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Provider.of<ThemeProvider>(context).color1,
                              Provider.of<ThemeProvider>(context).color1,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // border: new Border.all(
                          //   width: 1,
                          //   color: Provider.of<ThemeProvider>(context).color2,
                          // ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: edgeOfTab,
                          //     offset: Offset(0.0, 0.0), //阴影x轴偏移量
                          //     blurRadius: 5, //阴影模糊程度
                          //     spreadRadius: 1, //阴影扩散程度
                          //   )
                          // ],
                        ),
                        child: InkWell(
                            onTap: () {
                              print("you click it");
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.circle,
                                color:
                                Provider.of<ThemeProvider>(context).color2,
                              ),
                              title: Text(
                                AddingWhat().addingWhatList[int.parse(_detailList[index][1])],
                                style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                        .color2),
                              ),
                              subtitle: Text(
                                _detailList[index][2],
                                style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                        .color2),
                              ),
                              trailing: Text(
                                _detailList[index][0],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Provider.of<ThemeProvider>(context)
                                        .color2),
                              ),
                            ))),
                  ));
            }));
  }

  Widget detailMessage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        InkWell(
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
              SizedBox(width: 20,),
              Text(
                '$date1OnTop年$date2OnTop月',
                style: TextStyle(
                  fontSize: 35,
                  color: Provider.of<ThemeProvider>(context).color2,
                  fontWeight: FontWeight.w900,
                  // shadows: <Shadow>[
                  //   Shadow(
                  //     offset: Offset(2.0, 2.0),
                  //     blurRadius: 1.0,
                  //     color: Color.fromARGB(120, 10, 10, 100),
                  //   ),
                  // ],
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 40,
              )
            ],
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 3, 10, 10),
            child: Container(
              // decoration: BoxDecoration(
              //   color: Provider.of<ThemeProvider>(context).color3,
              //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //   boxShadow: [
              //     BoxShadow(
              //         color: Provider.of<ThemeProvider>(context).color2,
              //         offset: Offset(0.0, 0.0), //阴影x轴偏移量
              //         blurRadius: 3, //阴影模糊程度
              //         spreadRadius: 1 //阴影扩散程度
              //         )
              //   ],
              // ),
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
                      Provider.of<ThemeProvider>(context).color2,
                      backgroundColor:
                      Provider.of<ThemeProvider>(context).color2,
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
                          color: Provider.of<ThemeProvider>(context).color1,
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
