/// uId : ""
/// cId : ""
/// date : ""
/// transectionId : ""
/// price : ""
/// review : "false"

class CourseBuy {
  CourseBuy({
      String? uId, 
      String? cId, 
      String? date, 
      String? transectionId, 
      String? price, 
      String? review,

    String? userName,
    String? title,
    String? paidAmount,}){
    _uId = uId;
    _cId = cId;
    _date = date;
    _transectionId = transectionId;
    _price = price;
    _review = review;

    _userName = userName;
    _title = title;
    _paidAmount = paidAmount;
}

  CourseBuy.fromJson(dynamic json) {
    _uId = json['uId'];
    _cId = json['cId'];
    _date = json['date'];
    _transectionId = json['transectionId'];
    _price = json['price'];
    _review = json['review'];

    _userName = json['userName'];
    _title = json['title'];
    _paidAmount = json['paid_Amount'];
  }
  String? _uId;
  String? _cId;
  String? _date;
  String? _transectionId;
  String? _price;
  String? _review;

  String? _userName;
  String? _title;
  String? _paidAmount;
CourseBuy copyWith({  String? uId,
  String? cId,
  String? date,
  String? transectionId,
  String? price,
  String? review,

  String? userName,
  String? title,
  String? paidAmount,
}) => CourseBuy(  uId: uId ?? _uId,
  cId: cId ?? _cId,
  date: date ?? _date,
  transectionId: transectionId ?? _transectionId,
  price: price ?? _price,
  review: review ?? _review,

  userName: userName ?? _userName,
  title: title ?? _title,
  paidAmount: paidAmount ?? _paidAmount,
);
  String? get uId => _uId;
  String? get cId => _cId;
  String? get date => _date;
  String? get transectionId => _transectionId;
  String? get price => _price;
  String? get review => _review;

  String? get userName => _userName;
  String? get title => _title;
  String? get paidAmount => _paidAmount;

  set setReview(String ratingnew){
    _review = ratingnew;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uId'] = _uId;
    map['cId'] = _cId;
    map['date'] = _date;
    map['transectionId'] = _transectionId;
    map['price'] = _price;
    map['review'] = _review;

    map['userName'] = _userName;
    map['title'] = _title;
    map['paid_Amount'] = _paidAmount;
    return map;
  }

}