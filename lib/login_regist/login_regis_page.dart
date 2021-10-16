import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:twt_account/data/toast_provider.dart';
import '../data/global_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _value = true;
  SharedPreferences prefs = GlobalData.getPref()!;
  String userName = '';
  String nickName = '';
  String pass = '';
  String pass2 = ' ';
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _nickNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordSecondController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 40, 0),
            alignment: Alignment.centerLeft,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 2.0,
              ),
              child: Text(
                "返回登录",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/loginInPage");
              },
            ),
          ),
          SizedBox(height: 20),
          Text(' 欢迎注册划记账号!',
            textScaleFactor: 2.0,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20),
          Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 1.0), //阴影x轴偏移量
                  blurRadius: 1, //阴影模糊程度
                  spreadRadius: 1, //阴影扩散程度
                )
              ],
              color: Colors.white,
            ),
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "账号",
                        helperText: "登录划记并进行同步的唯一凭据"
                    ),
                    controller: _userNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "昵称",
                        helperText: "主页将会展示的名字"
                    ),
                    controller: _nickNameController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "密码",
                      helperText: "密码长度应不少于8位，由数字和字母组成"
                    ),
                    controller: _passwordController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "确认密码",
                    ),
                    controller: _passwordSecondController,
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 224, 249, 255),
                elevation: 5.0,
              ),
              onPressed: () async {
                if (_passwordController.text == _passwordSecondController.text) {
                  var response = await Dio().post(
                      "http://121.43.164.122:3390/user/register",
                      //options: Options(headers: headers),
                      queryParameters: {
                        "userName": _userNameController.text,
                        "nickName": _nickNameController.text,
                        "password": _passwordController.text,
                      });
                  print(response);
                  //Navigator.popAndPushNamed(context, "/registerPage");
                } else ToastProvider.error('两次密码输入不一致！');
              },
              child: Container(
                width: 100,
                child: Center(
                  child: Text(
                    "注册!",
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
      ),
    );
  }
}
