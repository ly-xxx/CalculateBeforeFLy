import 'package:flutter/material.dart';
import 'LoginInPage.dart';
import 'myPage/MyPage.dart';
import 'detailMessage.dart';
import 'askingPrice.dart';
import 'moreThings.dart';
import 'myPage/tally.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/loginInPage":(context)=>LoginInPage(),
        "/myPage":(context)=> MyPage(),
        "/detailMessagePage":(context)=>DetailMessagePage(),
        "/askingPricePage":(context)=>AskingPricePage(),
        "/moreThingsPage":(context)=>MoreThingsPage(),
        "/tally":(context)=>Tally()
      },
      initialRoute: "/myPage",
    );
  }
}

