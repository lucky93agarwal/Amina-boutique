/// email : ""
/// mobile : ""
/// pass : ""
/// name : ""
/// address : ""
/// id : ""
/// state : ""
/// city : ""
/// country : ""
/// pincode : ""
/// dob : ""
/// gender : ""
/// image : ""
/// type : ""
/// wallet : ""
/// blocked : ""
/// maintenance : ""

class UserList {
  UserList({
      String? email, 
      String? mobile, 
      String? pass, 
      String? name, 
      String? address, 
      String? id, 
      String? state, 
      String? city, 
      String? country, 
      String? pincode, 
      String? dob, 
      String? gender, 
      String? image, 
      String? type, 
      String? wallet, 
      String? blocked, 
      String? maintenance,}){
    _email = email;
    _mobile = mobile;
    _pass = pass;
    _name = name;
    _address = address;
    _id = id;
    _state = state;
    _city = city;
    _country = country;
    _pincode = pincode;
    _dob = dob;
    _gender = gender;
    _image = image;
    _type = type;
    _wallet = wallet;
    _blocked = blocked;
    _maintenance = maintenance;
}

  UserList.fromJson(dynamic json) {
    _email = json['email'];
    _mobile = json['mobile'];
    _pass = json['pass'];
    _name = json['name'];
    _address = json['address'];
    _id = json['id'];
    _state = json['state'];
    _city = json['city'];
    _country = json['country'];
    _pincode = json['pincode'];
    _dob = json['dob'];
    _gender = json['gender'];
    _image = json['image'];
    _type = json['type'];
    _wallet = json['wallet'];
    _blocked = json['blocked'];
    _maintenance = json['maintenance'];
  }
  String? _email;
  String? _mobile;
  String? _pass;
  String? _name;
  String? _address;
  String? _id;
  String? _state;
  String? _city;
  String? _country;
  String? _pincode;
  String? _dob;
  String? _gender;
  String? _image;
  String? _type;
  String? _wallet;
  String? _blocked;
  String? _maintenance;
UserList copyWith({  String? email,
  String? mobile,
  String? pass,
  String? name,
  String? address,
  String? id,
  String? state,
  String? city,
  String? country,
  String? pincode,
  String? dob,
  String? gender,
  String? image,
  String? type,
  String? wallet,
  String? blocked,
  String? maintenance,
}) => UserList(  email: email ?? _email,
  mobile: mobile ?? _mobile,
  pass: pass ?? _pass,
  name: name ?? _name,
  address: address ?? _address,
  id: id ?? _id,
  state: state ?? _state,
  city: city ?? _city,
  country: country ?? _country,
  pincode: pincode ?? _pincode,
  dob: dob ?? _dob,
  gender: gender ?? _gender,
  image: image ?? _image,
  type: type ?? _type,
  wallet: wallet ?? _wallet,
  blocked: blocked ?? _blocked,
  maintenance: maintenance ?? _maintenance,
);
  String? get email => _email;
  String? get mobile => _mobile;
  String? get pass => _pass;
  String? get name => _name;
  String? get address => _address;
  String? get id => _id;
  String? get state => _state;
  String? get city => _city;
  String? get country => _country;
  String? get pincode => _pincode;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get image => _image;
  String? get type => _type;
  String? get wallet => _wallet;
  String? get blocked => _blocked;
  String? get maintenance => _maintenance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['pass'] = _pass;
    map['name'] = _name;
    map['address'] = _address;
    map['id'] = _id;
    map['state'] = _state;
    map['city'] = _city;
    map['country'] = _country;
    map['pincode'] = _pincode;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['image'] = _image;
    map['type'] = _type;
    map['wallet'] = _wallet;
    map['blocked'] = _blocked;
    map['maintenance'] = _maintenance;
    return map;
  }

}