/// code : 40000
/// message : "Failure"
/// result : "用户名/昵称或密码有误"

class LoginFailedBean {
  LoginFailedBean({
      int? code, 
      String? message, 
      String? result,}){
    _code = code;
    _message = message;
    _result = result;
}

  LoginFailedBean.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _result = json['result'];
  }
  int? _code;
  String? _message;
  String? _result;

  int? get code => _code;
  String? get message => _message;
  String? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['result'] = _result;
    return map;
  }

}