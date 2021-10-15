import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_1.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_2.dart';
import 'package:twt_account/moreThings/theme/theme_list_main_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_outer.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_background.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_normal.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_overflow.dart';

class ThemeProvider with ChangeNotifier {
  Color _outer = themeListA.first; //默认是我们设置的主题颜色列表第一个
  Color _mainFont = themeListB.first; //默认是我们设置的主题颜色列表第一个
  Color _background = themeListC.first; //默认是我们设置的主题颜色列表第一个
  Color _assistFont = themeListBB.first; //默认是我们设置的主题颜色列表第一个
  Color _indicatorGood = themeListD.first; //默认是我们设置的主题颜色列表第一个
  Color _indicatorBad = themeListE.first;
  Color _assist1 = themeListF.first;
  Color _assist2 = themeListG.first;

  setTheme(int index) {
    //给外部提供修改主题的方法
    _outer = themeListA[index];
    _mainFont = themeListB[index];
    _background = themeListC[index];
    _indicatorGood = themeListD[index];
    _indicatorBad = themeListE[index];
    _assistFont = themeListBB[index];
    _assist1 = themeListF[index];
    _assist2 = themeListG[index];
    print(index);
    notifyListeners();
  }

  Color get outer => _outer; //获取当前主题

  Color get mainFont => _mainFont;

  Color get background => _background;

  Color get indicatorGood => _indicatorGood;

  Color get indicatorBad => _indicatorBad;

  Color get assistFont => _assistFont;

  Color get assist1 => _assist1;

  Color get assist2 => _assist2;
}
