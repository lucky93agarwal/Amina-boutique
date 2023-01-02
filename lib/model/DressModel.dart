/// title : ""
/// details : ""
/// info : ""
/// story : ""
/// MSize : ""
/// MPrice : ""
/// MMRP : ""
/// MBlack : ""
/// MGreen : ""
/// MWhite : ""
/// MPink : ""
/// MRed : ""
/// SSize : ""
/// SPrice : ""
/// SMRP : ""
/// LSize : ""
/// LPrice : ""
/// LMRP : ""
/// LBlack : ""
/// LBlue : ""
/// LWhite : ""
/// LPink : ""
/// LRed : ""
/// XLSize : ""
/// XLPrice : ""
/// XLMRP : ""
/// XLBlack : ""
/// xLGreen : ""
/// XLWhite : ""
/// XLPink : ""
/// XLRed : ""
/// ImgBlack1 : ""
/// ImgBlack2 : ""
/// ImgBlue1 : ""
/// imgGreen2 : ""
/// ImgWhite1 : ""
/// ImgWhite2 : ""
/// ImgPink1 : ""
/// ImgPink2 : ""
/// ImgRed1 : ""
/// ImgRed2 : ""

class DressModel {
  DressModel({
    String? couponApply,
    String? id,
    String? category,
    String? title,
    String? details,
    String? info,

    String? mSize,
    String? mPrice,
    String? mmrp,
    String? mname,

    String? sSize,
    String? sPrice,
    String? smrp,
    String? sname,

    String? lSize,
    String? lPrice,
    String? lmrp,
    String? lname,

    String? xLSize,
    String? xLPrice,
    String? xlmrp,
    String? xlname,

    String? sxSize,
    String? sxPrice,
    String? sxmrp,
    String? sxname,

    String? mxSize,
    String? mxPrice,
    String? mxmrp,
    String? mxname,

    String? lxSize,
    String? lxPrice,
    String? lxmrp,
    String? lxname,

    String? xLxSize,
    String? xLxPrice,
    String? xlxmrp,
    String? xlxname,

    String? xxLxSize,
    String? xxLxPrice,
    String? xxlxmrp,
    String? xxlxname,

    String? xxxLxSize,
    String? xxxLxPrice,
    String? xxxlxmrp,
    String? xxxlxname,


    String? imgWhite1,
    String? imgWhite2,
    String? rating,
  }) {
    _couponApply = couponApply;
    _id = id;
    _category = category;
    _title = title;
    _details = details;
    _info = info;

    _mSize = mSize;
    _mPrice = mPrice;
    _mmrp = mmrp;
    _mname = mname;

    _sSize = sSize;
    _sPrice = sPrice;
    _smrp = smrp;
    _sname = sname;

    _lSize = lSize;
    _lPrice = lPrice;
    _lmrp = lmrp;
    _lname = lname;

    _xLSize = xLSize;
    _xLPrice = xLPrice;
    _xlmrp = xlmrp;
    _xlname = xlname;

    _sxSize = sxSize;
    _sxPrice = sxPrice;
    _sxmrp = sxmrp;
    _sxname = sxname;

    _mxSize = mxSize;
    _mxPrice = mxPrice;
    _mxmrp = mxmrp;
    _mxname = mxname;

    _lxSize = lxSize;
    _lxPrice = lxPrice;
    _lxmrp = lxmrp;
    _lxname = lxname;

    _xLxSize = xLxSize;
    _xLxPrice = xLxPrice;
    _xlxmrp = xlxmrp;
    _xlxname = xlxname;

    _xxLxSize = xxLxSize;
    _xxLxPrice = xxLxPrice;
    _xxlxmrp = xxlxmrp;
    _xxlxname = xxlxname;

    _xxxLxSize = xxxLxSize;
    _xxxLxPrice = xxxLxPrice;
    _xxxlxmrp = xxxlxmrp;
    _xxxlxname = xxxlxname;

    _imgWhite1 = imgWhite1;
    _imgWhite2 = imgWhite2;
    _rating = rating;
  }

  DressModel.fromJson(dynamic json) {
    _couponApply = json['couponApply'];
    _id = json['id'];
    _category = json['category'];
    _title = json['title'];
    _details = json['details'];
    _info = json['shipping_charges'];

    _mSize = json['MSize'];
    _mPrice = json['MPrice'];
    _mmrp = json['MStock'];
    _mname = json['MName'];

    _sSize = json['SSize'];
    _sPrice = json['SPrice'];
    _smrp = json['SStock'];
    _sname = json['SName'];

    _lSize = json['LSize'];
    _lPrice = json['LPrice'];
    _lmrp = json['LStock'];
    _lname = json['LName'];

    _xLSize = json['XLSize'];
    _xLPrice = json['XLPrice'];
    _xlmrp = json['XLStock'];
    _xlname = json['XLName'];


    _sxSize = json['SxSize'];
    _sxPrice = json['SxPrice'];
    _sxmrp = json['SxStock'];
    _sxname = json['SxName'];

    _mxSize = json['MxSize'];
    _mxPrice = json['MxPrice'];
    _mxmrp = json['MxStock'];
    _mxname = json['MxName'];


    _lxSize = json['LxSize'];
    _lxPrice = json['LxPrice'];
    _lxmrp = json['LxStock'];
    _lxname = json['LxName'];

    _xLxSize = json['XLxSize'];
    _xLxPrice = json['XLxPrice'];
    _xlxmrp = json['XLxStock'];
    _xlxname = json['XLxName'];

    _xxLxSize = json['xXLxSize'];
    _xxLxPrice = json['xXLxPrice'];
    _xxlxmrp = json['xXLxStock'];
    _xxlxname = json['xXLxName'];

    _xxxLxSize = json['xxXLxSize'];
    _xxxLxPrice = json['xxXLxPrice'];
    _xxxlxmrp = json['xxXLxStock'];
    _xxxlxname = json['XLxName'];

    _imgWhite1 = json['ImgWhite1'];
    _imgWhite2 = json['ImgWhite2'];

    _rating = json['rating'];
  }

  String? _couponApply;
  String? _id;
  String? _category;
  String? _title;
  String? _details;
  String? _info;
  String? _story;

  String? _mSize;
  String? _mPrice;
  String? _mmrp;
  String? _mname;

  String? _sSize;
  String? _sPrice;
  String? _smrp;
  String? _sname;

  String? _lSize;
  String? _lPrice;
  String? _lmrp;
  String? _lname;

  String? _xLSize;
  String? _xLPrice;
  String? _xlmrp;
  String? _xlname;

  String? _sxSize;
  String? _sxPrice;
  String? _sxmrp;
  String? _sxname;

  String? _mxSize;
  String? _mxPrice;
  String? _mxmrp;
  String? _mxname;

  String? _lxSize;
  String? _lxPrice;
  String? _lxmrp;
  String? _lxname;

  String? _xLxSize;
  String? _xLxPrice;
  String? _xlxmrp;
  String? _xlxname;

  String? _xxLxSize;
  String? _xxLxPrice;
  String? _xxlxmrp;
  String? _xxlxname;

  String? _xxxLxSize;
  String? _xxxLxPrice;
  String? _xxxlxmrp;
  String? _xxxlxname;

  String? _imgWhite1;
  String? _imgWhite2;

  String? _rating;

  DressModel copyWith({
    String? couponApply,
    String? id,
    String? category,
    String? title,
    String? details,
    String? info,

    String? mSize,
    String? mPrice,
    String? mmrp,
    String? mname,

    String? sSize,
    String? sPrice,
    String? smrp,
    String? sname,

    String? lSize,
    String? lPrice,
    String? lmrp,
    String? lname,

    String? xLSize,
    String? xLPrice,
    String? xlmrp,
    String? xlname,

    String? sxSize,
    String? sxPrice,
    String? sxmrp,
    String? sxname,

    String? mxSize,
    String? mxPrice,
    String? mxmrp,
    String? mxname,

    String? lxSize,
    String? lxPrice,
    String? lxmrp,
    String? lxname,

    String? xLxSize,
    String? xLxPrice,
    String? xlxmrp,
    String? xlxname,

    String? xxLxSize,
    String? xxLxPrice,
    String? xxlxmrp,
    String? xxlxname,

    String? xxxLxSize,
    String? xxxLxPrice,
    String? xxxlxmrp,
    String? xxxlxname,

    String? imgWhite1,
    String? imgWhite2,
    String? rating,
  }) =>
      DressModel(
        couponApply: couponApply ?? _couponApply,
        id: id ?? _id,
        category: category ?? _category,
        title: title ?? _title,
        details: details ?? _details,
        info: info ?? _info,

        mSize: mSize ?? _mSize,
        mPrice: mPrice ?? _mPrice,
        mmrp: mmrp ?? _mmrp,
        mname: mname ?? _mname,

        sSize: sSize ?? _sSize,
        sPrice: sPrice ?? _sPrice,
        smrp: smrp ?? _smrp,
        sname: sname ?? _sname,

        lSize: lSize ?? _lSize,
        lPrice: lPrice ?? _lPrice,
        lmrp: lmrp ?? _lmrp,
        lname: lname ?? _lname,

        xLSize: xLSize ?? _xLSize,
        xLPrice: xLPrice ?? _xLPrice,
        xlmrp: xlmrp ?? _xlmrp,
        xlname: xlname ?? _xlname,

        sxSize: sxSize ?? _sxSize,
        sxPrice: sxPrice ?? _sxPrice,
        sxmrp: sxmrp ?? _sxmrp,
        sxname: sxname ?? _sxname,

        mxSize: mxSize ?? _mxSize,
        mxPrice: mxPrice ?? _mxPrice,
        mxmrp: mxmrp ?? _mxmrp,
        mxname: mxname ?? _mxname,

        lxSize: lxSize ?? _lxSize,
        lxPrice: lxPrice ?? _lxPrice,
        lxmrp: lxmrp ?? _lxmrp,
        lxname: lxname ?? _lxname,

        xLxSize: xLxSize ?? _xLxSize,
        xLxPrice: xLxPrice ?? _xLxPrice,
        xlxmrp: xlxmrp ?? _xlxmrp,
        xlxname: xlxname ?? _xlxname,

        xxLxSize: xxLxSize ?? _xxLxSize,
        xxLxPrice: xxLxPrice ?? _xxLxPrice,
        xxlxmrp: xxlxmrp ?? _xxlxmrp,
        xxlxname: xxlxname ?? _xxlxname,

        xxxLxSize: xxxLxSize ?? _xxxLxSize,
        xxxLxPrice: xxxLxPrice ?? _xxxLxPrice,
        xxxlxmrp: xxxlxmrp ?? _xxxlxmrp,
        xxxlxname: xxxlxname ?? _xxxlxname,



        imgWhite1: imgWhite1 ?? _imgWhite1,
        imgWhite2: imgWhite2 ?? _imgWhite2,
          rating: rating ?? _rating,
      );

  String? get couponApply => _couponApply;
  String? get id => _id;

  String? get category => _category;

  String? get title => _title;

  String? get details => _details;

  String? get info => _info;


  String? get mSize => _mSize;
  String? get mPrice => _mPrice;
  String? get mmrp => _mmrp;
  String? get mname => _mname;
  set setMStock(String name) {
    _mmrp = name;
  }


  String? get sSize => _sSize;
  String? get sPrice => _sPrice;
  String? get smrp => _smrp;
  String? get sname => _sname;
  set setSStock(String name) {
    _smrp = name;
  }


  String? get lSize => _lSize;
  String? get lPrice => _lPrice;
  String? get lmrp => _lmrp;
  String? get lname => _lname;
  set setLStock(String name) {
    _lmrp = name;
  }

  String? get xLSize => _xLSize;
  String? get xLPrice => _xLPrice;
  String? get xlmrp => _xlmrp;
  String? get xlname => _xlname;
  set setXLStock(String name) {
    _xlmrp = name;
  }

  String? get mxSize => _mxSize;
  String? get mxPrice => _mxPrice;
  String? get mxmrp => _mxmrp;
  String? get mxname => _mxname;
  set setMXStock(String name) {
    _mxmrp = name;
  }

  String? get sxSize => _sxSize;
  String? get sxPrice => _sxPrice;
  String? get sxmrp => _sxmrp;
  String? get sxname => _sxname;
  set setSXStock(String name) {
    _sxmrp = name;
  }

  String? get lxSize => _lxSize;
  String? get lxPrice => _lxPrice;
  String? get lxmrp => _lxmrp;
  String? get lxname => _lxname;
  set setLXStock(String name) {
    _lxmrp = name;
  }

  String? get xLxSize => _xLxSize;
  String? get xLxPrice => _xLxPrice;
  String? get xlxmrp => _xlxmrp;
  String? get xlxname => _xlxname;
  set setXLxStock(String name) {
    _xlxmrp = name;
  }

  String? get xxLxSize => _xLxSize;
  String? get xxLxPrice => _xLxPrice;
  String? get xxlxmrp => _xlxmrp;
  String? get xxlxname => _xlxname;
  set setXXLxStock(String name) {
    _xxlxmrp = name;
  }


  String? get xxxLxSize => _xxxLxSize;
  String? get xxxLxPrice => _xxxLxPrice;
  String? get xxxlxmrp => _xxxlxmrp;
  String? get xxxlxname => _xxxlxname;

  set setXXXLxStock(String name) {
    _xxxlxmrp = name;
  }


  set setRating(String ratingnew){
    _rating = ratingnew;
  }




  String? get imgWhite1 => _imgWhite1;

  String? get imgWhite2 => _imgWhite2;

  String? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['couponApply']=_couponApply;
    map['id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['details'] = _details;
    map['shipping_charges'] = _info;

    map['MSize'] = _mSize;
    map['MPrice'] = _mPrice;
    map['MStock'] = _mmrp;
    map['MName'] = _mname;

    map['SSize'] = _sSize;
    map['SPrice'] = _sPrice;
    map['SStock'] = _smrp;
    map['SName'] = _sname;

    map['LSize'] = _lSize;
    map['LPrice'] = _lPrice;
    map['LStock'] = _lmrp;
    map['LName'] = _lname;

    map['XLSize'] = _xLSize;
    map['XLPrice'] = _xLPrice;
    map['XLStock'] = _xlmrp;
    map['XLName'] = _xlname;


    map['MxSize'] = _mxSize;
    map['MxPrice'] = _mxPrice;
    map['MxStock'] = _mxmrp;
    map['MxName'] = _mxname;

    map['SxSize'] = _sxSize;
    map['SxPrice'] = _sxPrice;
    map['SxStock'] = _sxmrp;
    map['SxName'] = _sxname;



    map['LxSize'] = _lxSize;
    map['LxPrice'] = _lxPrice;
    map['LxStock'] = _lxmrp;
    map['LxName'] = _lxname;

    map['XLxSize'] = _xLxSize;
    map['XLxPrice'] = _xLxPrice;
    map['XLxStock'] = _xlxmrp;
    map['XLxName'] = _xlxname;


    map['xXLxSize'] = _xLxSize;
    map['xXLxPrice'] = _xLxPrice;
    map['xXLxStock'] = _xlxmrp;
    map['xXLxName'] = _xlxname;


    map['xxXLxSize'] = _xxxLxSize;
    map['xxXLxPrice'] = _xxxLxPrice;
    map['xxXLxStock'] = _xxxlxmrp;
    map['xxXLxName'] = _xxxlxname;

    map['ImgWhite1'] = _imgWhite1;
    map['ImgWhite2'] = _imgWhite2;

    map['rating'] = _rating;

    return map;
  }
}
