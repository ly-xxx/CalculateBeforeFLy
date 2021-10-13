import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/statistics/statisPage.dart';
import 'package:twt_account/statistics/statiscs_page_expend.dart';
import 'login_in_page.dart';
import 'moreThings/skin.dart';
import 'moreThings/theme/theme_config.dart';
import 'add_configure/add_configure.dart';
import 'my_page.dart';
import 'details/detail_message.dart';
import 'moreThings/more_things.dart';
import 'data/test.dart';
import 'package:flutter/services.dart';

void main() async{
  //runApp(MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
  await GlobalData.initPrefs();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
        "/statisPage":(context)=>StatisPage(),
        "/moreThingsPage":(context)=>MoreThingsPage(),
        "/addConfigure":(context)=>AddConfigure(),
        "/test": (context) => Test(),
        "/skinPage":(context)=>SkinPage(),
        "/staticsExpendPage":(context)=>StatisExpendPage(),
      },
      //initialRoute: "/myPage",
      // home: StartPage(),
      home:StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    new Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushReplacementNamed("/myPage");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset("assets/images/fourth.png",fit: BoxFit.cover)
    );
  }
}

