/// chat_id : ""
/// user_id : ""
/// user_name : ""
/// user_img : ""
/// user_mobile : ""
/// user_msg : ""
/// user_date : ""
/// user_time : ""
/// admin_img : ""
/// admin_name : ""
/// admin_id : ""
/// admin_msg : ""
/// admin_date : ""
/// admin_time : ""
/// status : ""

class ChatQuestionList {
  ChatQuestionList({
      String? chatId, 
      String? userId, 
      String? userName, 
      String? userImg, 
      String? userMobile,
    String? userEmale,
      String? userMsg, 
      String? userDate, 
      String? userTime, 
      String? adminImg, 
      String? adminName, 
      String? adminId, 
      String? adminMsg, 
      String? adminDate, 
      String? adminTime, 
      String? status,
    String? type,
  int? index,}){
    _chatId = chatId;
    _userId = userId;
    _userName = userName;
    _userImg = userImg;
    _userMobile = userMobile;
    _userEmale = userEmale;
    _userMsg = userMsg;
    _userDate = userDate;
    _userTime = userTime;
    _adminImg = adminImg;
    _adminName = adminName;
    _adminId = adminId;
    _adminMsg = adminMsg;
    _adminDate = adminDate;
    _adminTime = adminTime;
    _status = status;
    _type = type;
    _index = index;
}

  ChatQuestionList.fromJson(dynamic json) {
    _chatId = json['chat_id'];
    _userId = json['user_id'];
    _userName = json['user_name'];
    _userImg = json['user_img'];
    _userMobile = json['user_mobile'];
    _userMsg = json['user_msg'];
    _userEmale = json['user_emale'];
    _userDate = json['user_date'];
    _userTime = json['user_time'];
    _adminImg = json['admin_img'];
    _adminName = json['admin_name'];
    _adminId = json['admin_id'];
    _adminMsg = json['admin_msg'];
    _adminDate = json['admin_date'];
    _adminTime = json['admin_time'];
    _status = json['status'];
    _type = json['type'];
    _index = json['index'];
  }
  String? _chatId;
  String? _userId;
  String? _userName;
  String? _userImg;
  String? _userEmale;
  String? _userMobile;
  String? _userMsg;
  String? _userDate;
  String? _userTime;
  String? _adminImg;
  String? _adminName;
  String? _adminId;
  String? _adminMsg;
  String? _adminDate;
  String? _adminTime;
  String? _status;
  String? _type;
  int? _index;
  ChatQuestionList copyWith({  String? chatId,
  String? userId,
  String? userName,
  String? userImg,
  String? userMobile,
    String? userEmale,
  String? userMsg,
  String? userDate,
  String? userTime,
  String? adminImg,
  String? adminName,
  String? adminId,
  String? adminMsg,
  String? adminDate,
  String? adminTime,
  String? status,
    String? type,
int?    index,
}) => ChatQuestionList(  chatId: chatId ?? _chatId,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  userImg: userImg ?? _userImg,
  userMobile: userMobile ?? _userMobile,
  userMsg: userMsg ?? _userMsg,
  userDate: userDate ?? _userDate,
    userEmale: userEmale?? _userEmale,
  userTime: userTime ?? _userTime,
  adminImg: adminImg ?? _adminImg,
  adminName: adminName ?? _adminName,
  adminId: adminId ?? _adminId,
  adminMsg: adminMsg ?? _adminMsg,
  adminDate: adminDate ?? _adminDate,
  adminTime: adminTime ?? _adminTime,
  status: status ?? _status,
    type: type ?? _type,
    index: index ?? _index,
);
  String? get chatId => _chatId;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userImg => _userImg;
  String? get userEmale => _userEmale;
  String? get userMobile => _userMobile;
  String? get userMsg => _userMsg;
  String? get userDate => _userDate;
  String? get userTime => _userTime;
  String? get adminImg => _adminImg;
  String? get adminName => _adminName;
  String? get adminId => _adminId;
  String? get adminMsg => _adminMsg;
  String? get adminDate => _adminDate;
  String? get adminTime => _adminTime;
  String? get status => _status;
  String? get type => _type;
  int? get index => _index;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat_id'] = _chatId;
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['user_img'] = _userImg;
    map['user_mobile'] = _userMobile;
    map['user_emale'] = _userEmale;
    map['user_msg'] = _userMsg;
    map['user_date'] = _userDate;
    map['user_time'] = _userTime;
    map['admin_img'] = _adminImg;
    map['admin_name'] = _adminName;
    map['admin_id'] = _adminId;
    map['admin_msg'] = _adminMsg;
    map['admin_date'] = _adminDate;
    map['admin_time'] = _adminTime;
    map['status'] = _status;
    map['type'] = _type;
    map['index'] = _index;
    return map;
  }

}