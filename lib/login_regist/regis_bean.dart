/// code : 0
/// message : "Success"
/// result : {"userName":"张三","nickName":"zhangsan","password":"123456","isLogin":null,"skinNow":null}

class RegisBean {
  RegisBean({
      int? code, 
      String? message, 
      Result? result,}){
    _code = code;
    _message = message;
    _result = result;
}

  RegisBean.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  int? _code;
  String? _message;
  Result? _result;

  int? get code => _code;
  String? get message => _message;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// userName : "张三"
/// nickName : "zhangsan"
/// password : "123456"
/// isLogin : null
/// skinNow : null

class Result {
  Result({
      String? userName, 
      String? nickName, 
      String? password, 
      dynamic isLogin, 
      dynamic skinNow,}){
    _userName = userName;
    _nickName = nickName;
    _password = password;
    _isLogin = isLogin;
    _skinNow = skinNow;
}

  Result.fromJson(dynamic json) {
    _userName = json['userName'];
    _nickName = json['nickName'];
    _password = json['password'];
    _isLogin = json['isLogin'];
    _skinNow = json['skinNow'];
  }
  String? _userName;
  String? _nickName;
  String? _password;
  dynamic _isLogin;
  dynamic _skinNow;

  String? get userName => _userName;
  String? get nickName => _nickName;
  String? get password => _password;
  dynamic get isLogin => _isLogin;
  dynamic get skinNow => _skinNow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['nickName'] = _nickName;
    map['password'] = _password;
    map['isLogin'] = _isLogin;
    map['skinNow'] = _skinNow;
    return map;
  }

}