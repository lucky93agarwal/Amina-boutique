/// first_img_url : ""
/// first_img_type : ""
/// sec_img_url : ""
/// sec_img_type : ""
/// third_img_url : ""
/// third_img_type : ""
/// four_img_url : ""
/// four_img_type : ""

class ProductBanner {
  ProductBanner({
    String? firstImgUrl,
    String? firstImgType,
    String? secImgUrl,
    String? secImgType,}){
    _firstImgUrl = firstImgUrl;
    _firstImgType = firstImgType;
    _secImgUrl = secImgUrl;
    _secImgType = secImgType;
  }

  ProductBanner.fromJson(dynamic json) {
    _firstImgUrl = json['first_img_url'];
    _firstImgType = json['first_img_type'];
    _secImgUrl = json['sec_img_url'];
    _secImgType = json['sec_img_type'];
  }
  String? _firstImgUrl;
  String? _firstImgType;
  String? _secImgUrl;
  String? _secImgType;
  ProductBanner copyWith({  String? firstImgUrl,
    String? firstImgType,
    String? secImgUrl,
    String? secImgType,
  }) => ProductBanner(  firstImgUrl: firstImgUrl ?? _firstImgUrl,
    firstImgType: firstImgType ?? _firstImgType,
    secImgUrl: secImgUrl ?? _secImgUrl,
    secImgType: secImgType ?? _secImgType,
  );
  String? get firstImgUrl => _firstImgUrl;
  String? get firstImgType => _firstImgType;
  String? get secImgUrl => _secImgUrl;
  String? get secImgType => _secImgType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_img_url'] = _firstImgUrl;
    map['first_img_type'] = _firstImgType;
    map['sec_img_url'] = _secImgUrl;
    map['sec_img_type'] = _secImgType;
    return map;
  }

}