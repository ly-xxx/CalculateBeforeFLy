import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_1.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_2.dart';
import 'package:twt_account/moreThings/theme/theme_list_assist_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_confirm.dart';
import 'package:twt_account/moreThings/theme/theme_list_detail_background.dart';
import 'package:twt_account/moreThings/theme/theme_list_main_font.dart';
import 'package:twt_account/moreThings/theme/theme_list_morething_background.dart';
import 'package:twt_account/moreThings/theme/theme_list_outer.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_normal.dart';
import 'package:twt_account/moreThings/theme/theme_list_liquid_indicator_overflow.dart';
import 'package:twt_account/moreThings/theme/theme_list_outer_side.dart';
import 'package:twt_account/moreThings/theme/theme_list_pie.dart';
import 'package:twt_account/moreThings/theme/theme_list_statis_background.dart';

class ThemeProvider with ChangeNotifier {
  Color _outer = themeListA.first; //默认是我们设置的主题颜色列表第一个
  Color _outerSide = themeListB.first; //默认是我们设置的主题颜色列表第一个
  Color _confirmMid = themeListC.first; //默认是我们设置的主题颜色列表第一个
  Color _liquidNormal = themeListD.first; //默认是我们设置的主题颜色列表第一个
  Color _liquidOverflow = themeListE.first; //默认是我们设置的主题颜色列表第一个
  Color _detailBackground = themeListF.first; //默认是我们设置的主题颜色列表第一个
  Color _moreBackground = themeListG.first; //默认是我们设置的主题颜色列表第一个
  Color _statisticBackground= themeListH.first; //默认是我们设置的主题颜色列表第一个
  Color _assistFont= themeListAC.first;
  Color _assist1= themeListAA.first;
  Color _assist2= themeListAB.first;
  Color _mainFont = themeListBB.first;
  List<Color> _pieColor=themeListI.first;

  setTheme(int index) {
    //给外部提供修改主题的方法
    _outer = themeListA[index];
    _outerSide = themeListB[index];
    _confirmMid = themeListC[index];
    _liquidNormal = themeListD[index];
    _liquidOverflow = themeListE[index];
    _detailBackground= themeListF[index];
    _moreBackground = themeListG[index];
    _statisticBackground = themeListH[index];

    _assistFont = themeListAC[index];
    _assist1 = themeListAA[index];
    _assist2 = themeListAB[index];
    _mainFont = themeListBB[index];

    _pieColor = themeListI[index];
    print(index);
    notifyListeners();
  }

  Color get outer => _outer; //获取当前主题

  Color get outerSide => _outerSide;

  Color get confirmMid => _confirmMid;

  Color get liquidNormal => _liquidNormal;

  Color get liquidOverflow => _liquidOverflow;

  Color get detailBackground => _detailBackground;

  Color get moreBackground => _moreBackground;

  Color get statisticBackground => _statisticBackground;

  Color get assistFont => _assistFont;

  Color get assist1 => _assist1;

  Color get assist2 => _assist2;

  Color get mainFont => _mainFont;

  List<Color> get pieColor=>_pieColor;

}
