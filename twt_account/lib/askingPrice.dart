import 'package:flutter/material.dart';

class AskingPricePage extends StatefulWidget {
  const AskingPricePage({Key key}) : super(key: key);

  @override
  _AskingPricePageState createState() => _AskingPricePageState();
}


class _AskingPricePageState extends State<AskingPricePage> {

  Widget top(){
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),

                child: Icon(Icons.list,size: 40,),
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
                    Container(child: Icon(Icons.settings,size: 40,)),
                    SizedBox(width: 30,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/moreThingsPage");
                      },
                        child: Text("更多"))
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }



  Widget askingPriceMainPage(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                    child: Text("北洋园")
                ),
              ],
            )
          ),
          Expanded(
              child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "问价",
                    style: TextStyle(fontSize: 50),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "搜索框",
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox(width: 30,)),
                        Expanded(child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                            child: Text("不设置")),flex: 2,)
                      ],
                    ),
                  )
                ],
              )
           )
          )
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          top(),
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
                        Icon(Icons.account_box,size: 30),
                        InkWell(
                            child: Text("我的",style: TextStyle(fontSize: 20),),
                          onTap: (){
                              Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container(child: askingPriceMainPage(),),flex: 9,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
