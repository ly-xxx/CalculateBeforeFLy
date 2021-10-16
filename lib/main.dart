import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/data/global_data.dart';
import 'package:twt_account/login_regist/login_regis_page.dart';
import 'package:twt_account/statistics/statis_page.dart';
import 'package:twt_account/statistics/statiscs_page_expend.dart';
import 'package:twt_account/login_regist/login_page.dart';
import 'package:twt_account/moreThings/skin.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';
import 'package:twt_account/add_configure/add_configure.dart';
import 'package:twt_account/my_page.dart';
import 'package:twt_account/details/detail_message.dart';
import 'package:twt_account/moreThings/more_things.dart';
import 'package:twt_account/data/test.dart';

void main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),

      routes: {
        "/loginInPage": (context) => LoginInPage(),
        "/registerPage": (context) => RegisterPage(),
        "/myPage": (context) => MyPage(),
        "/detailMessagePage": (context) => DetailMessagePage(),
        "/statisPage": (context) => StatisPage(),
        "/moreThingsPage": (context) => MoreThingsPage(),
        "/addConfigure": (context) => AddConfigure(),
        "/test": (context) => Test(),
        "/skinPage": (context) => SkinPage(),
        "/staticsExpendPage": (context) => StatisExpendPage(),
      },
      //initialRoute: "/myPage",

      home: StartPage(),
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
    new Future.delayed(Duration(seconds: 1), () {
      SharedPreferences prefs = GlobalData.getPref()!;
      bool logged = prefs.getBool("logState") ??
          () {
            print("not logged");
            return false;
          }();
      if (logged) {
        Navigator.of(context).pushReplacementNamed("/myPage");
      } else {
        Navigator.of(context).pushReplacementNamed("/loginInPage");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset("assets/images/fourth.png", fit: BoxFit.cover));
  }
}
