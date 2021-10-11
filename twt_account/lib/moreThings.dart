import 'package:flutter/material.dart';

class MoreThingsPage extends StatefulWidget {
  const MoreThingsPage({Key key}) : super(key: key);

  @override
  _MoreThingsPageState createState() => _MoreThingsPageState();
}

class _MoreThingsPageState extends State<MoreThingsPage> {


Widget bottom(){
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),

            child: Icon(Icons.account_box,size: 40,),
          )
      ),
        Expanded(
            flex: 9,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Container(child: Icon(Icons.attach_money,size: 40,)),
                  SizedBox(width: 30,),
                  Text("问价")
                ],
              ),
            )
        ),

      ],
    ),
  );
}

Widget mainPage(){
  return Column(
      children: <Widget>[
        SizedBox(height: 50,),
        ListTile(
          leading: Icon(Icons.person,size: 50,),
          title: Text("用户名"),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(border:Border.all(color: Colors.blue)),
            child: gridViewPage(),
          ),
        )
      ],
  );
}

Widget gridViewPage(){
  return Padding(
    padding: EdgeInsets.all(50.0),
    child: GridView.count(
      crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        crossAxisCount: 2,
      children: <Widget>[
        Container(child: Text("记账天数",style: TextStyle(fontSize: 20),),),
        Container(child: Text("记账总笔数",style: TextStyle(fontSize: 20),),),
        Container(child: Text("皮肤",style: TextStyle(fontSize: 20),),),
        Container(child: Text("固定收支",style: TextStyle(fontSize: 20),)),
        Container(child: Text(" "),),
        Container(child: Text("退出登录",style: TextStyle(fontSize: 20),)),


      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.list,size: 30),
                        Text("明细",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Expanded(child: mainPage(),flex: 9,),
              ],
            ),
          ),
          bottom()
        ],
      ),
    );
  }
}
