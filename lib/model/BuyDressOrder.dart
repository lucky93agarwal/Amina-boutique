/// dress_id : ""
/// buy_id : ""
/// transation_id : ""
/// dress_size : ""
/// dress_quantity : ""
/// dress_unit_price : ""
/// user_id : ""
/// user_name : ""
/// user_img : ""
/// user_mobile : ""
/// user_city : ""
/// user_pincode : ""
/// user_State : ""
/// user_country : ""
/// delivery_status : ""
/// date : ""
/// time : ""
/// coupon_id : ""
/// delivery_charges : ""
/// net_price : ""
/// couponStatus : ""

class BuyDressOrder {
  BuyDressOrder({
    String? dressId,
    String? dressTitle,
    String? dressImg,
    String? buyId,
    String? transationId,
    String? dressSize,
    String? dressQuantity,
    String? dressUnitPrice,
    String? userId,
    String? userName,
    String? userImg,
    String? userMobile,
    String? userCity,
    String? userPincode,
    String? userAddress,
    String? userEmail,
    String? userState,
    String? userCountry,
    String? deliveryStatus,
    String? date,
    String? time,
    String? couponId,
    String? deliveryCharges,
    String? netPrice,
    String? couponStatus,
    String? rating,
  }) {
    _dressId = dressId;
    _dressTitle = dressTitle;
    _dressImg = dressImg;
    _buyId = buyId;
    _transationId = transationId;
    _dressSize = dressSize;
    _dressQuantity = dressQuantity;
    _dressUnitPrice = dressUnitPrice;
    _userId = userId;
    _userName = userName;
    _userImg = userImg;
    _userMobile = userMobile;
    _userCity = userCity;
    _userPincode = userPincode;
    _userAddress = userAddress;
    _userEmail = userEmail;
    _userState = userState;
    _userCountry = userCountry;
    _deliveryStatus = deliveryStatus;
    _date = date;
    _time = time;
    _couponId = couponId;
    _deliveryCharges = deliveryCharges;
    _netPrice = netPrice;
    _couponStatus = couponStatus;
    _rating = rating;
  }

  BuyDressOrder.fromJson(dynamic json) {
    _dressId = json['dress_id'];
    _dressTitle = json['dress_title'];
    _dressImg = json['dress_img'];
    _buyId = json['buy_id'];
    _transationId = json['transation_id'];
    _dressSize = json['dress_size'];
    _dressQuantity = json['dress_quantity'];
    _dressUnitPrice = json['dress_unit_price'];
    _userId = json['user_id'];
    _userName = json['user_name'];
    _userImg = json['user_img'];
    _userMobile = json['user_mobile'];
    _userCity = json['user_city'];
    _userPincode = json['user_pincode'];
    _userAddress = json['user_address'];
    _userEmail = json['user_email'];
    _userState = json['user_State'];
    _userCountry = json['user_country'];
    _deliveryStatus = json['delivery_status'];
    _date = json['date'];
    _time = json['time'];
    _couponId = json['coupon_id'];
    _deliveryCharges = json['delivery_charges'];
    _netPrice = json['net_price'];
    _couponStatus = json['Coupon_status'];
    _rating = json['rating'];
  }

  String? _dressId;
  String? _dressTitle;
  String? _dressImg;
  String? _buyId;
  String? _transationId;
  String? _dressSize;
  String? _dressQuantity;
  String? _dressUnitPrice;
  String? _userId;
  String? _userName;
  String? _userImg;
  String? _userMobile;
  String? _userCity;
  String? _userPincode;
  String? _userAddress;
  String? _userEmail;
  String? _userState;
  String? _userCountry;
  String? _deliveryStatus;
  String? _date;
  String? _time;
  String? _couponId;
  String? _deliveryCharges;
  String? _netPrice;
  String? _couponStatus;
  String? _rating;

  BuyDressOrder copyWith({
    String? dressId,
    String? dressTitle,
    String? dressImg,
    String? buyId,
    String? transationId,
    String? dressSize,
    String? dressQuantity,
    String? dressUnitPrice,
    String? userId,
    String? userName,
    String? userImg,
    String? userMobile,
    String? userCity,
    String? userPincode,
    String? userAddress,
    String? userEmail,
    String? userState,
    String? userCountry,
    String? deliveryStatus,
    String? date,
    String? time,
    String? couponId,
    String? deliveryCharges,
    String? netPrice,
    String? couponStatus,
    String? rating,
  }) =>
      BuyDressOrder(
        dressId: dressId ?? _dressId,
        dressTitle: dressTitle ?? _dressTitle,
        dressImg: dressImg ?? _dressImg,
        buyId: buyId ?? _buyId,
        transationId: transationId ?? _transationId,
        dressSize: dressSize ?? _dressSize,
        dressQuantity: dressQuantity ?? _dressQuantity,
        dressUnitPrice: dressUnitPrice ?? _dressUnitPrice,
        userId: userId ?? _userId,
        userName: userName ?? _userName,
        userImg: userImg ?? _userImg,
        userMobile: userMobile ?? _userMobile,
        userCity: userCity ?? _userCity,
        userPincode: userPincode ?? _userPincode,
        userAddress: userAddress ?? _userAddress,
        userEmail: userEmail ?? _userEmail,
        userState: userState ?? _userState,
        userCountry: userCountry ?? _userCountry,
        deliveryStatus: deliveryStatus ?? _deliveryStatus,
        date: date ?? _date,
        time: time ?? _time,
        couponId: couponId ?? _couponId,
        deliveryCharges: deliveryCharges ?? _deliveryCharges,
        netPrice: netPrice ?? _netPrice,
        couponStatus: couponStatus ?? _couponStatus,
          rating: rating ?? _rating,
      );

  String? get dressId => _dressId;

  String? get dressTitle => _dressTitle;

  String? get dressImg => _dressImg;

  String? get buyId => _buyId;

  String? get transationId => _transationId;

  String? get dressSize => _dressSize;

  String? get dressQuantity => _dressQuantity;

  String? get dressUnitPrice => _dressUnitPrice;

  String? get userId => _userId;

  String? get userName => _userName;

  String? get userImg => _userImg;

  String? get userMobile => _userMobile;

  String? get userCity => _userCity;

  String? get userPincode => _userPincode;

  String? get userAddress => _userAddress;

  String? get userEmail => _userEmail;

  String? get userState => _userState;

  String? get userCountry => _userCountry;

  String? get deliveryStatus => _deliveryStatus;

  String? get date => _date;

  String? get time => _time;

  String? get couponId => _couponId;

  String? get deliveryCharges => _deliveryCharges;

  String? get netPrice => _netPrice;

  String? get couponStatus => _couponStatus;

  String? get rating => _rating;
  set setdeliveryStatus(String name) {
    _deliveryStatus = name;
  }

  set setRating(String name) {
    _rating = name;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dress_id'] = _dressId;
    map['dress_title'] = _dressTitle;
    map['dress_img'] = _dressImg;
    map['buy_id'] = _buyId;
    map['transation_id'] = _transationId;
    map['dress_size'] = _dressSize;
    map['dress_quantity'] = _dressQuantity;
    map['dress_unit_price'] = _dressUnitPrice;
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['user_img'] = _userImg;
    map['user_mobile'] = _userMobile;
    map['user_city'] = _userCity;
    map['user_pincode'] = _userPincode;
    map['user_address'] = _userAddress;
    map['user_email'] = _userEmail;
    map['user_State'] = _userState;
    map['user_country'] = _userCountry;
    map['delivery_status'] = _deliveryStatus;
    map['date'] = _date;
    map['time'] = _time;
    map['coupon_id'] = _couponId;
    map['delivery_charges'] = _deliveryCharges;
    map['net_price'] = _netPrice;
    map['Coupon_status'] = _couponStatus;
    map['rating'] = _rating;
    return map;
  }
}
