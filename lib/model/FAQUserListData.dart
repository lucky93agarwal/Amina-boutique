/// id : ""
/// userName : ""
/// userEmail : ""
/// userMobile : ""
/// userImg : ""

class FaqUserListData {
  FaqUserListData({
      String? id, 
      String? userName, 
      String? userEmail, 
      String? userMobile, 
      String? userImg,}){
    _id = id;
    _userName = userName;
    _userEmail = userEmail;
    _userMobile = userMobile;
    _userImg = userImg;
}

  FaqUserListData.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['userName'];
    _userEmail = json['userEmail'];
    _userMobile = json['userMobile'];
    _userImg = json['userImg'];
  }
  String? _id;
  String? _userName;
  String? _userEmail;
  String? _userMobile;
  String? _userImg;
FaqUserListData copyWith({  String? id,
  String? userName,
  String? userEmail,
  String? userMobile,
  String? userImg,
}) => FaqUserListData(  id: id ?? _id,
  userName: userName ?? _userName,
  userEmail: userEmail ?? _userEmail,
  userMobile: userMobile ?? _userMobile,
  userImg: userImg ?? _userImg,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userMobile => _userMobile;
  String? get userImg => _userImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userName'] = _userName;
    map['userEmail'] = _userEmail;
    map['userMobile'] = _userMobile;
    map['userImg'] = _userImg;
    return map;
  }

}