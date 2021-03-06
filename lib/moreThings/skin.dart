import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twt_account/moreThings/theme/theme.dart';
import 'package:twt_account/moreThings/theme/theme_config.dart';

class SkinPage extends StatefulWidget {
  @override
  _SkinPageState createState() => _SkinPageState();
}

class _SkinPageState extends State<SkinPage> {
  int? _index; //我们当前主题设置的是 全局主题列表中的第几个？
  @override
  void initState() {
    super.initState();
    loadData(); //查询当前持久化数据
  }

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance(); //获取持久化操作对象
    setState(() {
      _index = sp.getInt("theme") ?? 0; //查询持久化框架中保存的theme字段，如果是null则默认是0
    }); // dart 语法糖 ?? 它的意思是左边如果为空返回右边的值，否则不处理。
  }

  String userName = '';

  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        // padding: const EdgeInsets.all(40),
        height: 70,
        margin: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          image:
          new DecorationImage(image: themeList[index], fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //阴影x轴偏移量
              blurRadius: 0.5, //阴影模糊程度
              spreadRadius: 1, //阴影扩散程度
            )
          ],
        ),

        child: _index != index
            ? Text("") //如果没选中则无东西
            : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.check,
              color: Colors.grey.shade800,
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
      onTap: () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setInt("theme", index); //点击后，修改持久化框架里的theme数据库
        userName = sp.getStringList('user')![0];
        Provider.of<ThemeProvider>(context, listen: false)
            .setTheme(index); //修改全局状态为选中的值
        setState(() {
          _index = index; //设置当前界面选种值，刷新对勾
        });
        networkProcedure();
      },
    );
  }

  networkProcedure() async {
    var response = await Dio()
        .post("http://121.43.164.122:3390/user/addskin", queryParameters: {
      "userName": userName,
      "skinNow": _index!,
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFEBEBF2),
      appBar: AppBar(
        iconTheme: IconThemeData(
        ),
        title: Text(
          "个性装扮",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 10,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Scrollbar(
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: themeList.length,
          ),
        ),
      ),
    );
  }
}
