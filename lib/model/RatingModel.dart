/// id : ""
/// productId : ""
/// rating : ""
/// reply : ""
/// time : ""
/// userId : ""
/// userImg : ""
/// userMessage : ""
/// userName : ""
/// visible : ""

class RatingModel {
  RatingModel({
      String? id, 
      String? productId, 
      String? rating, 
      String? reply, 
      String? time,
    String? type,
    String? userId,
      String? userImg, 
      String? userMessage, 
      String? userName, 
      String? visible,}){
    _id = id;
    _productId = productId;
    _rating = rating;
    _reply = reply;
    _time = time;
    _type = type;
    _userId = userId;
    _userImg = userImg;
    _userMessage = userMessage;
    _userName = userName;
    _visible = visible;
}

  RatingModel.fromJson(dynamic json) {
    _id = json['id'];
    _productId = json['productId'];
    _rating = json['rating'];
    _reply = json['reply'];
    _time = json['time'];
    _type = json['type'];
    _userId = json['userId'];
    _userImg = json['userImg'];
    _userMessage = json['userMessage'];
    _userName = json['userName'];
    _visible = json['visible'];
  }
  String? _id;
  String? _productId;
  String? _rating;
  String? _reply;
  String? _time;
  String? _type;
  String? _userId;
  String? _userImg;
  String? _userMessage;
  String? _userName;
  String? _visible;
RatingModel copyWith({  String? id,
  String? productId,
  String? rating,
  String? reply,
  String? time,
  String? type,
  String? userId,
  String? userImg,
  String? userMessage,
  String? userName,
  String? visible,
}) => RatingModel(  id: id ?? _id,
  productId: productId ?? _productId,
  rating: rating ?? _rating,
  reply: reply ?? _reply,
  time: time ?? _time,
  type: type ?? _type,
  userId: userId ?? _userId,
  userImg: userImg ?? _userImg,
  userMessage: userMessage ?? _userMessage,
  userName: userName ?? _userName,
  visible: visible ?? _visible,
);
  String? get id => _id;
  String? get productId => _productId;
  String? get rating => _rating;
  String? get reply => _reply;
  String? get time => _time;
  String? get userId => _userId;
  String? get type => _type;
  String? get userImg => _userImg;
  String? get userMessage => _userMessage;
  String? get userName => _userName;
  String? get visible => _visible;
  set setvisible(String name) {
    _visible = name;
  }

  set setReply(String name){
    _reply = name;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['productId'] = _productId;
    map['rating'] = _rating;
    map['reply'] = _reply;
    map['time'] = _time;
    map['userId'] = _userId;
    map['type'] = _type;
    map['userImg'] = _userImg;
    map['userMessage'] = _userMessage;
    map['userName'] = _userName;
    map['visible'] = _visible;
    return map;
  }

}