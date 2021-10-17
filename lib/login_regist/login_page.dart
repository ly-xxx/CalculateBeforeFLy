import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/data/toast_provider.dart';
import 'package:twt_account/login_regist/login_bean.dart';
import 'package:twt_account/login_regist/login_failed_bean.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';

import '../data/global_data.dart';

class LoginInPage extends StatefulWidget {
  const LoginInPage({Key? key}) : super(key: key);

  @override
  _LoginInPageState createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  bool _value = true;
  SharedPreferences prefs = GlobalData.getPref()!;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerRight,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
               // elevation: 3.0,
              ),
              child: Text(
                "跳过",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                SharedPreferences prefs = GlobalData.getPref()!;
                prefs.setStringList("user", ['null', '请登录以同步', '']);
                prefs.setBool("logState", false);
                Navigator.popAndPushNamed(context, "/myPage");
              },
            ),
          ),
          SizedBox(height: 100),
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  border: new Border.all(
                    width: 5,
                    color: Colors.white70,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0), //阴影x轴偏移量
                        blurRadius: 2000, //阴影模糊程度
                        spreadRadius: 25 //阴影扩散程度
                        )
                  ],
                  image: new DecorationImage(
                    alignment: Alignment.centerRight,
                    image: new AssetImage('assets/images/huaJi.png'),
                  ),
                ),
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                     // color: Colors.black26,
                      color: Colors.white,
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
                          hintText: "划记账号",
                        ),
                        controller: _userNameController,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "密码",
                        ),
                        controller: _passwordController,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 245, 255, 241),
                   // elevation: 5.0,
                  ),
                  onPressed: () async {
                    var response = await Dio()
                        .post("http://121.43.164.122:3390/user/login",
                            //options: Options(headers: headers),
                            queryParameters: {
                          "userName": _userNameController.text,
                          "password": _passwordController.text,
                        });
                    print(response);
                    int isLogin =
                        LoginBean.fromJson(response.data).result!.isLogin!;
                    if (isLogin == 1) {
                      SharedPreferences prefs = GlobalData.getPref()!;
                      prefs.setStringList("user", [
                        LoginBean.fromJson(response.data).result!.userName!,
                        LoginBean.fromJson(response.data).result!.nickName!,
                        LoginBean.fromJson(response.data).result!.password!,
                      ]);
                      prefs.setBool("logState", true);
                      ToastProvider.success("登录成功!");
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setTheme(LoginBean.fromJson(response.data)
                              .result!
                              .skinNow!); //修改全局状态为选中的值

                      Navigator.popAndPushNamed(context, "/myPage");
                    } else {
                      prefs.setBool("logState", false);
                      ToastProvider.error('登录失败哩');
                    }
                    print(prefs.getStringList("user"));
                  },
                  child: Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "登录！",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                   // primary: Color.fromARGB(255, 231, 224, 218),
                    primary: Color.fromARGB(255, 231, 224, 218),
                    //elevation: 5.0,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/registerPage");
                  },
                  child: Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "注册",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
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
                        fontWeight: FontWeight.w500),
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
