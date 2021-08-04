import 'package:flutter/material.dart';
class LoginInPage extends StatefulWidget {
  const LoginInPage({Key key}) : super(key: key);

  @override
  _LoginInPageState createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  bool _value=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            alignment: Alignment.centerRight,
            height: 50,
              child: ElevatedButton(
                child: Text(
                    "跳过"
                ),
                onPressed: (){
                   Navigator.pushNamed(context, "/myPage");
                },
              ),
          ),
          SizedBox(height: 100),
          Column(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                    border: new Border.all(width: 1,color: Colors.blue)
                ),
                height: 150,
                width: 150,
                child: Text(
                  "图片",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Container(
                width: 300,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                         hintText: "账号",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "密码",
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                child: Text(
                    "登录"
                ),
                onPressed: (){

                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: this._value,
                      onChanged: (bool value){
                        setState(() {
                          this._value=value;
                        });

                      }
                  ),
                  Text(
                    "了解并同意隐私政策"
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
