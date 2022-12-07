/// id : ""
/// endDate : ""
/// limitUser : ""
/// type : ""

class Coupon {
  Coupon({
      String? id,
    String? titleName,
    String? endDate,
      String? limitUser, 
      String? type,
  String? percentage}){
    _id = id;
    _titleName = titleName;
    _endDate = endDate;
    _limitUser = limitUser;
    _type = type;
    _percentage =percentage;
}

  Coupon.fromJson(dynamic json) {
    _id = json['id'];
    _titleName = json['titleName'];
    _endDate = json['endDate'];
    _limitUser = json['limitUser'];
    _type = json['type'];
    _percentage = json['percentage'];
  }
  String? _id;
  String? _titleName;
  String? _endDate;
  String? _limitUser;
  String? _type;
  String? _percentage;
Coupon copyWith({  String? id,
  String? titleName,
  String? endDate,
  String? limitUser,
  String? type,
  String? percentage,
}) => Coupon(  id: id ?? _id,
  titleName: titleName ?? _titleName,
  endDate: endDate ?? _endDate,
  limitUser: limitUser ?? _limitUser,
  type: type ?? _type,
    percentage: percentage ?? _percentage,
);
  String? get id => _id;
  String? get titleName => _titleName;
  String? get endDate => _endDate;
  String? get limitUser => _limitUser;
  String? get type => _type;
  String? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['titleName'] = _titleName;
    map['endDate'] = _endDate;
    map['limitUser'] = _limitUser;
    map['type'] = _type;
    map['percentage']=_percentage;
    return map;
  }

}