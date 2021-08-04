import 'package:flutter/material.dart';

class DetailMessagePage extends StatefulWidget {
  const DetailMessagePage({Key key}) : super(key: key);

  @override
  _DetailMessagePageState createState() => _DetailMessagePageState();
}

Widget bottom(context ){
  return Container(
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
                  Container(child: Icon(Icons.account_box,size: 40,)),
                  SizedBox(width: 30,),
                  InkWell(child: Text("我的"),onTap: (){
                    Navigator.pushNamed(context, "/myPage");
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

              child: Icon(Icons.attach_money,size: 40,),
            )
        )
      ],
    ),
  );
}

Widget detailMessage(){
  return Column(
    children: <Widget>[
      SizedBox(height: 30,),
      Container(child: Text("日期",style: TextStyle(fontSize: 20),),),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                    height:80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue)
                    ),
                    child: Center(child: Text("净收支",style: TextStyle(fontSize: 20),)),
                  )
              ),
              ElevatedButton(onPressed: (){}, child: Text("流水")),
              ElevatedButton(onPressed: (){}, child: Text("统计")),
            ],
          ),
        ),
      ),
      Text("本月支出  XXX    收入  XXX   预算  XXX"),
      Expanded(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: ListView(
            children: [Text("明细列表")],
          ),
        ),
      )
    ],
  );
}

class _DetailMessagePageState extends State<DetailMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: detailMessage(),flex: 9,),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.settings,size: 30),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, "/moreThingsPage");
                            },
                              child: Text("更多",style: TextStyle(fontSize: 20),)),
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
      );
    }
}
