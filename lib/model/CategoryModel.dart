/// cId : ""
/// cName : ""
/// cImg : ""

class CategoryModel {
  CategoryModel({
      String? cId, 
      String? cName, 
      String? cImg,}){
    _cId = cId;
    _cName = cName;
    _cImg = cImg;
}

  CategoryModel.fromJson(dynamic json) {
    _cId = json['cId'];
    _cName = json['cName'];
    _cImg = json['cImg'];
  }
  String? _cId;
  String? _cName;
  String? _cImg;
CategoryModel copyWith({  String? cId,
  String? cName,
  String? cImg,
}) => CategoryModel(  cId: cId ?? _cId,
  cName: cName ?? _cName,
  cImg: cImg ?? _cImg,
);
  String? get cId => _cId;
  String? get cName => _cName;
  String? get cImg => _cImg;

  set setName(String cName) {
    _cName = cName;
  }

  set setImg(String cImg) {
    _cImg = cImg;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cId'] = _cId;
    map['cName'] = _cName;
    map['cImg'] = _cImg;
    return map;
  }

}