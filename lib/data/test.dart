import 'package:flutter/material.dart';
import '../login_regist/login_page.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    double width = 0.0;
    double height = 0.0;
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: height,
          width: width,
        ),
        PageView(
          scrollDirection: Axis.horizontal,
          children: [
            Image.asset("assets/images/first.png"),
            Image.asset("assets/images/second.png"),
            Image.asset("assets/images/third.png"),
            LoginInPage(),
          ],
        ),
      ],
    );
  }
}
