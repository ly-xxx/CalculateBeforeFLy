import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twt_account/moreThings/theme/theme_list_main_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_outer.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_background.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_normal.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_overflow.dart';

class ThemeProvider with ChangeNotifier {
  Color _color1 = themeListA.first; //默认是我们设置的主题颜色列表第一个
  Color _color2 = themeListB.first; //默认是我们设置的主题颜色列表第一个
  Color _color3 = themeListC.first; //默认是我们设置的主题颜色列表第一个
  Color _color4 = themeListD.first; //默认是我们设置的主题颜色列表第一个
  Color _color5 = themeListE.first; //默认是我们设置的主题颜色列表第一个
  Color _color6 = themeListBB.first; //默认是我们设置的主题颜色列表第一个

  setTheme(int index) {
    //给外部提供修改主题的方法
    _color1 = themeListA[index];
    _color2 = themeListB[index];
    _color3 = themeListC[index];
    _color4 = themeListD[index];
    _color5 = themeListE[index];
    _color6 = themeListBB[index];
    print(index);
    notifyListeners();
  }

  Color get color1 => _color1; //获取当前主题

  Color get color2 => _color2;

  Color get color3 => _color3;

  Color get color4 => _color4;

  Color get color5 => _color5;

  Color get color6 => _color6;
}
