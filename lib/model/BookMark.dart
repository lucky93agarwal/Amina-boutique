/// userId : ""
/// dress_id : ["",""]

class BookMark {
  BookMark({
      String? userId, 
      List<String>? dressId,}){
    _userId = userId;
    _dressId = dressId;
}

  BookMark.fromJson(dynamic json) {
    _userId = json['userId'];
    _dressId = json['dress_id'] != null ? json['dress_id'].cast<String>() : [];
  }
  String? _userId;
  List<String>? _dressId;
BookMark copyWith({  String? userId,
  List<String>? dressId,
}) => BookMark(  userId: userId ?? _userId,
  dressId: dressId ?? _dressId,
);
  String? get userId => _userId;
  List<String>? get dressId => _dressId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['dress_id'] = _dressId;
    return map;
  }

}