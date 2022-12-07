class VideoList{
  VideoList({
    String? subCategory,
    String? categories,
    String? discription,
    String? id,
    String? time,
    String? title,
    String? url,
}){
    _subCategory = subCategory;
    _categories = categories;
    _discription = discription;
    _id = id;
    _time = time;
    _title = title;
    _url = url;
}

  VideoList.fromJson(dynamic json) {
    _subCategory = json['subCategory'];
    _categories = json['categories'];
    _discription = json['discription'];
    _id = json['id'];
    _time = json['time'];
    _title = json['title'];
    _url = json['url'];
  }
  String? _subCategory;
  String? _categories;
  String? _discription;
  String? _id;
  String? _time;
  String? _title;
  String? _url;

  String? get subCategory => _subCategory;
  String? get categories => _categories;
  String? get discription => _discription;
  String? get id => _id;
  String? get time => _time;
  String? get title => _title;
  String? get url => _url;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategory'] = _subCategory;
    map['categories'] = _categories;
    map['discription'] = _discription;
    map['id'] = _id;
    map['time'] = _time;
    map['title'] = _title;
    map['url'] = _url;
    return map;
  }
}