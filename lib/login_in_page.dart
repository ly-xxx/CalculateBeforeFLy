import 'package:flutter/material.dart';

class LoginInPage extends StatefulWidget {
  const LoginInPage({Key? key}) : super(key: key);

  @override
  _LoginInPageState createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            alignment: Alignment.centerRight,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 8.0,
              ),
              child: Text(
                "跳过",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/myPage");
              },
            ),
          ),
          SizedBox(height: 100),
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  border: new Border.all(
                    width: 5,
                    color: Colors.white70,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueAccent,
                        offset: Offset(0.0, 0.0), //阴影x轴偏移量
                        blurRadius: 2000, //阴影模糊程度
                        spreadRadius: 25 //阴影扩散程度
                        )
                  ],
                  image: new DecorationImage(
                    alignment: Alignment.centerRight,
                    image: new AssetImage('assets/images/furry.png'),
                  ),
                ),
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 120,
              ),
              Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 3.0), //阴影x轴偏移量
                      blurRadius: 2, //阴影模糊程度
                      spreadRadius: 1, //阴影扩散程度
                    )
                  ],
                  color: Colors.white,
                ),
                height: 150,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "账号",
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "密码",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/myPage");
                  },
                  child: Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "登录!",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: this._value,
                      onChanged: (bool? value) {
                        setState(() {
                          this._value = value!;
                        });
                      }),
                  Text(
                    "了解并同意隐私政策",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w900),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
