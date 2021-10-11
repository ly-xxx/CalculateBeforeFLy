import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dataTransfer.dart';

class Tally extends StatefulWidget {
  final DateTransferAdapter data;
  Tally({this.data});
  @override
  _TallyState createState() => _TallyState(data: data);
}


class _TallyState extends State<Tally> {
  final DateTransferAdapter data;
  _TallyState({this.data});
  int _value1=1;  //收入还是支出，下拉选项框参数
  int _value2=1;  //具体来源或者用途，下拉选项框参数

  ///主界面
  Widget mainPage(){
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Text("消费额/支出额",style: TextStyle(fontSize: 20)),
        SizedBox(height: 50),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: tools(),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue)
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    DropdownButton(
                         value: _value1,
                        items: [
                          DropdownMenuItem(child: Text("收入"),value: 1,),
                          DropdownMenuItem(child: Text("支出"),value: 2,),
                        ],
                      onChanged: (value){
                           setState(() {
                             _value1=value;
                           });
                      },
                    ),
                    SizedBox(width: 30),
                    DropdownButton(
                      value: _value2,
                      items: [
                        DropdownMenuItem(child: Text("学习"),value: 1,),
                        DropdownMenuItem(child: Text("娱乐"),value: 2,),
                        DropdownMenuItem(child: Text("生活"),value: 3,),
                        DropdownMenuItem(child: Text("餐饮"),value: 4,),
                        DropdownMenuItem(child: Text("理财"),value: 5,),
                        DropdownMenuItem(child: Text("工资"),value: 6,),
                        DropdownMenuItem(child: Text("生活费"),value: 7,),
                        DropdownMenuItem(child: Text("其他"),value: 8,),
                      ],
                      onChanged: (value){
                        setState(() {
                          _value2=value;
                        });
                      },
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: Container(

                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "金额",
                            hintStyle: TextStyle(fontSize: 18)
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "备注",
                        hintStyle: TextStyle(fontSize: 18)
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: (){
                      _backToData(BuildContext context){
                        var transferData = DateTransferAdapter(5,5,20);
                        Navigator.pop(context,transferData);
                      }
                    },
                    child: Text("确定"))
              ],
            ),
          ),
        )
      ],
    );
  }

  /// 页面中的两个元素，包括今日支出和本月支出。
  Widget tools(){



    return Padding(
      padding: EdgeInsets.all(30.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 50,
        mainAxisSpacing: 100,
        children: <Widget>[
          Container(
              child: Column(
                children: [
                  Text(
                    data.payToday.toString(),
                      style: TextStyle(fontSize: 60)
                  ),
                  Text("今日支出")
                ],
              )
          ),
          Container(
              child: Column(
                children: [
                  Text(
                      data.payMonth.toString(),
                      style: TextStyle(fontSize: 60)
                  ),
                  Text("本月支出")
                ],
              )
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: <Widget>[
                          Container(child: Icon(Icons.list,size: 40,)),
                          SizedBox(width: 30,),
                          InkWell(
                            child: Text("明细"),
                            onTap: (){
                              Navigator.pushNamed(context, "/detailMessagePage");
                            },)
                        ],
                      ),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),

                      child: Icon(Icons.settings,size: 40,),
                    )
                )
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(flex:9,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: mainPage(),
                    )
                ),
                Expanded(
                  flex:1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.attach_money,size: 30),
                        InkWell(
                          child: Text("问价",style: TextStyle(fontSize: 20)),
                          onTap: (){
                            Navigator.pushNamed(context, "/askingPricePage");
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
