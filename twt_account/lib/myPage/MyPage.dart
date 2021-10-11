import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dataTransfer.dart';
import 'tally.dart';
class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _todayExpenditure=1;
  int _monthExpenditure=3;
  int _averageDailyConsumption=2;


  Widget mainPage(){

    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Text("消费额/支出额",style: TextStyle(fontSize: 20)),
         SizedBox(height: 50),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: tools(),
          ),
        )
      ],
    );
  }

  Widget tools(){
    final data=DateTransferAdapter(
        _todayExpenditure,
        _monthExpenditure,
        _averageDailyConsumption
    );

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
                      "$_todayExpenditure",
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
                      "$_monthExpenditure",
                      style: TextStyle(fontSize: 60)
                  ),
                  Text("本月支出")
                ],
              )
          ),
          InkWell(
              child: Text("记一笔",style: TextStyle(fontSize: 30)),
            onTap: (){
                print(_averageDailyConsumption);
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context)=>Tally(data: data))
                // );
              Navigator.pushNamed(context, "/tally");
            },
          ),
          Container(
              child: Column(
                children: [
                  Text(
                      "$_averageDailyConsumption",
                      style: TextStyle(fontSize: 60)
                  ),
                  Text("日均消费")
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
