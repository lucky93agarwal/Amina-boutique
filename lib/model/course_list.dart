/// cId : "cId"
/// cName : "cName"
/// cDetails : "cDetails"
/// cThum : "cThum"
/// cPrice : "cPrice"
/// cMRP : "cMRP"
/// video : [{"cvId":"cMRP","cvTitle":"cMRP","cvDetails":"cMRP","cvUrl":"cMRP","cvTime":"cMRP"}]

class CourseList {
  CourseList({
      String? cId, 
      String? cName,
    String? introURL,
      String? cDetails, 
      String? cThum, 
      String? cPrice, 
      String? cMRP,
    String? cRating,
    List<CourseVideo>? video,}){
    _cId = cId;
    _cName = cName;
    _introURL = introURL;
    _cDetails = cDetails;
    _cThum = cThum;
    _cPrice = cPrice;
    _cMRP = cMRP;
    _cRating = cRating;
    _video = video;
}

  CourseList.fromJson(dynamic json) {
    _cId = json['cId'];
    _cName = json['cName'];
    _introURL = json['introURL'];
    _cDetails = json['cDetails'];
    _cThum = json['cThum'];
    _cPrice = json['cPrice'];
    _cMRP = json['cMRP'];
    _cRating = json['rating'];
    if (json['video'] != null) {
      _video = [];
      json['video'].forEach((v) {
        _video?.add(CourseVideo.fromJson(v));
      });
    }
  }
  String? _cId;
  String? _cName;
  String? _introURL;
  String? _cDetails;
  String? _cThum;
  String? _cPrice;
  String? _cMRP;
  String? _cRating;
  List<CourseVideo>? _video;
CourseList copyWith({  String? cId,
  String? cName,
  String? introURL,
  String? cDetails,
  String? cThum,
  String? cPrice,
  String? cMRP,
  String? cRating,
  List<CourseVideo>? video,
}) => CourseList(  cId: cId ?? _cId,
  cName: cName ?? _cName,
  introURL: introURL?? _introURL,
  cDetails: cDetails ?? _cDetails,
  cThum: cThum ?? _cThum,
  cPrice: cPrice ?? _cPrice,
  cMRP: cMRP ?? _cMRP,
  cRating: cRating ?? _cRating,
  video: video ?? _video,
);
  String? get cId => _cId;
  String? get cName => _cName;
  String? get introURL => _introURL;
  String? get cDetails => _cDetails;
  String? get cThum => _cThum;
  String? get cPrice => _cPrice;
  String? get cMRP => _cMRP;
  String? get cRating => _cRating;
  List<CourseVideo>? get video => _video;


  set setRating(String ratingnew){
    _cRating = ratingnew;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cId'] = _cId;
    map['cName'] = _cName;
    map['introURL'] = _introURL;
    map['cDetails'] = _cDetails;
    map['cThum'] = _cThum;
    map['cPrice'] = _cPrice;
    map['cMRP'] = _cMRP;
    map['rating'] = _cRating;
    if (_video != null) {
      map['video'] = _video?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cvId : "cMRP"
/// cvTitle : "cMRP"
/// cvDetails : "cMRP"
/// cvUrl : "cMRP"
/// cvTime : "cMRP"

class CourseVideo {
  CourseVideo({
      String? cvId, 
      String? cvTitle, 
      String? cvDetails, 
      String? cvUrl, 
      String? cvTime,}){
    _cvId = cvId;
    _cvTitle = cvTitle;
    _cvDetails = cvDetails;
    _cvUrl = cvUrl;
    _cvTime = cvTime;
}

  CourseVideo.fromJson(dynamic json) {
    _cvId = json['cvId'];
    _cvTitle = json['cvTitle'];
    _cvDetails = json['cvDetails'];
    _cvUrl = json['cvUrl'];
    _cvTime = json['cvTime'];
  }
  String? _cvId;
  String? _cvTitle;
  String? _cvDetails;
  String? _cvUrl;
  String? _cvTime;

CourseVideo copyWith({  String? cvId,
  String? cvTitle,
  String? cvDetails,
  String? cvUrl,
  String? cvTime,
}) => CourseVideo(  cvId: cvId ?? _cvId,
  cvTitle: cvTitle ?? _cvTitle,
  cvDetails: cvDetails ?? _cvDetails,
  cvUrl: cvUrl ?? _cvUrl,
  cvTime: cvTime ?? _cvTime,
);
  String? get cvId => _cvId;
  String? get cvTitle => _cvTitle;
  String? get cvDetails => _cvDetails;
  String? get cvUrl => _cvUrl;
  String? get cvTime => _cvTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cvId'] = _cvId;
    map['cvTitle'] = _cvTitle;
    map['cvDetails'] = _cvDetails;
    map['cvUrl'] = _cvUrl;
    map['cvTime'] = _cvTime;
    return map;
  }

}