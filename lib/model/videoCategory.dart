/// id : ""
/// title : ""

class VideoCategory {
  VideoCategory({
      String? id,
    String? image,
    String? title,}){
    _id = id;
    _image = image;
    _title = title;
}
  set setImage(String img){
    _image = img;
  }
  set setTitle(String title){
    _title = title;
  }

  VideoCategory.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
  }
  String? _id;
  String? _image;
  String? _title;
VideoCategory copyWith({  String? id,
  String? title,
}) => VideoCategory(  id: id ?? _id,
  image: image ?? _image,
  title: title ?? _title,
);
  String? get id => _id;
  String? get title => _title;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['title'] = _title;
    return map;
  }

}