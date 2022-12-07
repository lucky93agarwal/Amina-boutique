/// first_img_url : ""
/// first_img_type : ""
/// sec_img_url : ""
/// sec_img_type : ""
/// third_img_url : ""
/// third_img_type : ""
/// four_img_url : ""
/// four_img_type : ""

class HomeBanner {
  HomeBanner({
      String? firstImgUrl, 
      String? firstImgType, 
      String? secImgUrl, 
      String? secImgType, 
      String? thirdImgUrl, 
      String? thirdImgType, 
      String? fourImgUrl, 
      String? fourImgType,}){
    _firstImgUrl = firstImgUrl;
    _firstImgType = firstImgType;
    _secImgUrl = secImgUrl;
    _secImgType = secImgType;
    _thirdImgUrl = thirdImgUrl;
    _thirdImgType = thirdImgType;
    _fourImgUrl = fourImgUrl;
    _fourImgType = fourImgType;
}

  HomeBanner.fromJson(dynamic json) {
    _firstImgUrl = json['first_img_url'];
    _firstImgType = json['first_img_type'];
    _secImgUrl = json['sec_img_url'];
    _secImgType = json['sec_img_type'];
    _thirdImgUrl = json['third_img_url'];
    _thirdImgType = json['third_img_type'];
    _fourImgUrl = json['four_img_url'];
    _fourImgType = json['four_img_type'];
  }
  String? _firstImgUrl;
  String? _firstImgType;
  String? _secImgUrl;
  String? _secImgType;
  String? _thirdImgUrl;
  String? _thirdImgType;
  String? _fourImgUrl;
  String? _fourImgType;
HomeBanner copyWith({  String? firstImgUrl,
  String? firstImgType,
  String? secImgUrl,
  String? secImgType,
  String? thirdImgUrl,
  String? thirdImgType,
  String? fourImgUrl,
  String? fourImgType,
}) => HomeBanner(  firstImgUrl: firstImgUrl ?? _firstImgUrl,
  firstImgType: firstImgType ?? _firstImgType,
  secImgUrl: secImgUrl ?? _secImgUrl,
  secImgType: secImgType ?? _secImgType,
  thirdImgUrl: thirdImgUrl ?? _thirdImgUrl,
  thirdImgType: thirdImgType ?? _thirdImgType,
  fourImgUrl: fourImgUrl ?? _fourImgUrl,
  fourImgType: fourImgType ?? _fourImgType,
);
  String? get firstImgUrl => _firstImgUrl;
  String? get firstImgType => _firstImgType;
  String? get secImgUrl => _secImgUrl;
  String? get secImgType => _secImgType;
  String? get thirdImgUrl => _thirdImgUrl;
  String? get thirdImgType => _thirdImgType;
  String? get fourImgUrl => _fourImgUrl;
  String? get fourImgType => _fourImgType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_img_url'] = _firstImgUrl;
    map['first_img_type'] = _firstImgType;
    map['sec_img_url'] = _secImgUrl;
    map['sec_img_type'] = _secImgType;
    map['third_img_url'] = _thirdImgUrl;
    map['third_img_type'] = _thirdImgType;
    map['four_img_url'] = _fourImgUrl;
    map['four_img_type'] = _fourImgType;
    return map;
  }

}