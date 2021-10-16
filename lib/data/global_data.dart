import 'package:shared_preferences/shared_preferences.dart';
class GlobalData{
  GlobalData._();

  static final _instance=GlobalData._();

  factory GlobalData()=>_instance;

  static SharedPreferences? getPref() => _instance._sharedPref;

  SharedPreferences? _sharedPref;

  static Future<void>  initPrefs() async{
    _instance._sharedPref = await SharedPreferences.getInstance();
  }



}