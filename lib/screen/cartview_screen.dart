import 'dart:math';

import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/BuyDressOrder.dart';
import 'package:amin/model/Coupon.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/screen/add_review_screen.dart';
import 'package:amin/utils/config.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class CartViewScreen extends StatefulWidget {
  DressModel? dressModel;
  String? totalPrice;
  String? unitPrice;
  int? totalquantity;
  String? sizeName;
  String? stockKey;
  int? stockValue;
  String? ref;

  CartViewScreen(
      {Key? key,
      required this.dressModel,
      required this.totalPrice,
      required this.unitPrice,
      required this.totalquantity,
      required this.sizeName,
        required this.stockKey,
        required this.stockValue,
      required this.ref})
      : super(key: key);

  @override
  State<CartViewScreen> createState() => _CartViewScreenState();
}

class _CartViewScreenState extends State<CartViewScreen> {
  Razorpay _razorpay = Razorpay();

  bool banenrvisit = false;
  DressModel? dressModel;
  List<String> image = [];
  String? totalPrice = "0";
  String? unitPrice = "0";
  int totalquantity = 0;
  int netPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalquantity = widget.totalquantity!;
    dressModel = widget.dressModel;
    totalPrice = widget.totalPrice;
    unitPrice = widget.unitPrice;
    netPrice = int.parse(totalPrice!) + int.parse(dressModel!.info!);
    image.add(dressModel!.imgWhite1!);
    image.add(dressModel!.imgWhite2!);
    banenrvisit = true;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getdata();
  }

  void openCheckout() {



    var options = {
      /*'key': 'rzp_test_1DP5mmOlF5G5ag',*/
      'key': Config.RAZORPAY_RETROFIT_URL,
      'amount': netPrice.toString() + "00",
      'name': name,
      'description': widget.dressModel!.title!,
      'send_sms_hash': true,
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    /*showToast("SUCCESS: " +
        response
            .paymentId!);*/ /*
    Toast.show("SUCCESS: " + response.paymentId, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/
   print("SUCCESS paymentId: " + response.paymentId!);
//    print("SUCCESS : " + response.orderId);
    setState(() {
      transationId = response.paymentId;
    });

    /*bookOrder();*/
    sendEmailShipping();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String dressbuyids = "DressBuyId" + randomNumber.toString();

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattcertime = new DateFormat("h:mma");
    String formattedDate = formatter.format(now);
    String formattedTime = formattcertime.format(now);
    DateTime date = new DateTime(now.year, now.month, now.day);
    print("Lucky  check date  = " +
        date.toString() +
        ",  formattedDate  = " +
        formattedDate +
        " , time = " +
        formattedTime);
    buyDressOrder = BuyDressOrder(
      dressId: dressModel!.id,
      dressImg: dressModel!.imgWhite1,
      dressTitle: dressModel!.title,
      buyId: dressbuyids,
      transationId: transationId,
      dressSize: widget.sizeName!,
      dressQuantity: widget.totalquantity.toString(),
      dressUnitPrice: widget.unitPrice!,
      userId: id,
      userName: name,
      userImg: img,
      userMobile: mobile,
      userCity: city,
      userPincode: pincode,
      userState: state,
      userCountry: country,
      userAddress: address,
      userEmail: email,
      deliveryStatus: "Processing",
      date: formattedDate,
      time: formattedTime.toString(),
      couponId: couponId,
      deliveryCharges: dressModel!.info,
      netPrice: netPrice.toString(),
      couponStatus: couponStatus,
      rating: "false",
    );
    if(widget.stockKey == "SStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setSStock = totalStack.toString();
    }else if(widget.stockKey == "MStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setMStock = totalStack.toString();
    }else if(widget.stockKey == "LStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setLStock = totalStack.toString();
    }else if(widget.stockKey == "XLStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXLStock = totalStack.toString();
    }else if(widget.stockKey == "SxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setSXStock = totalStack.toString();
    }else if(widget.stockKey == "MxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setMXStock = totalStack.toString();
    }else if(widget.stockKey == "LxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setLXStock = totalStack.toString();
    }else if(widget.stockKey == "XLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXLxStock = totalStack.toString();
    }else if(widget.stockKey == "xXLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXXLxStock = totalStack.toString();
    }else if(widget.stockKey == "xxXLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXXXLxStock = totalStack.toString();
    }


    FirebaseFirestore.instance.collection('dress').doc(widget.ref).update(dressModel!.toJson());
    userss
        .add(buyDressOrder.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Order placed successfully"),
      //  nextScreenReplace(context, AddReviewScreen(dressModel: widget.dressModel,type: "Dress",))
      Navigator.pop(context),
    })
    // ignore: invalid_return_type_for_catch_error
        .catchError((error) => cprint('Failed to add user: error'));
    /* _runapi();*/

    // Navigator.popAndPushNamed(context, PageRoutes.homePage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToast("Transaction Canceled");
    Navigator.pop(context);

//    Fluttertoast.showToast(
//        msg: "ERROR: " + response.code.toString() + " - " + response.message,
//        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToast("EXTERNAL_WALLET: " + response.walletName!);
    Navigator.pop(context);
//    Fluttertoast.showToast(
//        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  String? address = "";
  String? city = "city";
  String? state = "state";
  String? country = "india";
  String? pincode = "000000";
  String? mobile = "0000000000";
  String? email = "xyz@gmail.com";

  String? name = "";
  String? id = "";
  String? img = "";

  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _statsController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _statsController.dispose();
    _pincodeController.dispose();

    super.dispose();
  }

  bool checkfiltervisi = false;
  String? pass = '';
  String? Uname = '';
  String? userid = '';
  String? dob = '';
  String? gender = '';

  getdata() async {
    print("check coupon apply or not = "+widget.dressModel!.couponApply.toString());
    final pref = getIt<SharedPreferenceHelper>();
    address = await pref.getUserAdd();
    city = await pref.getUserCity();
    state = await pref.getStateName();
    country = await pref.getUserCountry();
    pincode = await pref.getUserPinCode();
    email = await pref.getUserEmail();
    mobile = await pref.getUserMobile();
    pass = await pref.getUserPass();
    Uname = await pref.getUserName();
    userid = await pref.getUserId();
    dob = await pref.getUserDOB();
    if(pincode! != "000000"){
      _pincodeController.text = pincode!;
    }
    if(email! != "xyz@gmail.com"){
      _emailController.text = email!;
    }

    if(state! != "Select State"){
      _statsController.text = state!;
    }

    if(city! != "Select City"){
      _cityController.text = city!;
    }

    if(address! != "House No/Street/Area"){
      _addressController.text = address!;
    }


    name = await pref.getUserName();
    id = await pref.getUserId();
    img = await pref.getUserImage();

  }
 /* late Coupon modelCoupon;
  late List<Coupon> listCouponProduct =  [];*/
  final queryPostCoupon = FirebaseFirestore.instance.collection('Coupon').where('type', isEqualTo: "dress").withConverter<Coupon>(fromFirestore:(snapshot,_)=> Coupon.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
/*  listCoupon()async{
    var result = await FirebaseFirestore.instance
        .collection('Coupon')
        .get()
        .then((value) => {

      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          docss = value.docs,
          cprint('login message = reference id = ' +
              docss[0].reference.id),

          *//*showToast("User already exist...")*//*
        }
      else
        {
          setState(() {
            _progress = false;
          }),
          cprint('login message = mobile = false'),
          showToast("wrong credentials")
        }
    });
  }*/
  checkCoupon(String minUser, String CouponId,String persen,String endDate)async {

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    /*var formattcertime = new DateFormat("hh:mm a");*/

    DateTime endTempDate = new DateFormat("yyyy-MM-dd").parse(endDate);
    String formattedDate = formatter.format(now);
    DateTime currentTempDate = new DateFormat("yyyy-MM-dd").parse(formattedDate);
    /*String formattedTime = formattcertime.format(now);*/

    double? unitPriceCal = 0.0;
    double? unitPerCal = 0.0;
    double? unitNetPrice = 0.0;
    double? unitQuant = 1.0;
    double? unitShipping = 1.0;
    cprint('login message = user_id = '+id!+", coupon_id =  "+CouponId);
    var result = await FirebaseFirestore.instance
        .collection('BuyDress')
        .where('Coupon_status', isEqualTo: "1")
        .where('user_id', isEqualTo: id)
        .where('coupon_id', isEqualTo: CouponId)
        .limit(1)
        .get()
        .then((value) => {
      cprint('login message = user_id = '+id!+", coupon_id =  "+CouponId+", size = "+value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          docss = value.docs,

          if(value.size >= int.parse(minUser)){
            showToast("Sorry, you have exhausted your 'per user' limit to use this promo code")
          }else{
            if(currentTempDate.isBefore(endTempDate)){
              cprint("currentTempDate is before endTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
              unitQuant = double.tryParse(totalquantity.toString()),
              unitPriceCal = double.tryParse(unitPrice.toString()),
              unitPriceCal = unitPriceCal! * unitQuant!,
              cprint('login message = mobile = unitNetPrice = '+"  , unitPriceCal  = "+unitPriceCal.toString()),
              unitPerCal = double.tryParse(persen)!/100.0,
              unitNetPrice = unitPriceCal! * unitPerCal!,

              unitNetPrice = unitPriceCal! - unitNetPrice!,

              unitNetPrice = unitNetPrice! + double.tryParse(dressModel!.info!)!,
              netPrice = unitNetPrice!.toInt(),
              cprint('login message = mobile = unitNetPrice = '+unitNetPrice.toString()+"  , unitPerCal  ="+unitPerCal.toString()+"  , unitPriceCal  ="+unitPriceCal.toString()),
              cprint("Accept limit 2 netPrice = "+netPrice.toString()),
              showToast("Coupon applied successfully"),
              setState(() {
                netPrice;
                couponStatus = "1";
                couponId = CouponId;
              }),
            }else
              {
                cprint("endTempDate is before currentTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
              },
          }

          /*showToast("User already exist...")*/
        }
      else
        {
          if(currentTempDate.isBefore(endTempDate)){
            cprint("currentTempDate is before endTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
            unitQuant = double.tryParse(totalquantity.toString()),
            unitPriceCal = double.tryParse(unitPrice.toString()),
            unitPriceCal = unitPriceCal! * unitQuant!,
            cprint('login message = mobile = unitNetPrice = '+"  , unitPriceCal  = "+unitPriceCal.toString()),
            unitPerCal = double.tryParse(persen)!/100.0,
            unitNetPrice = unitPriceCal! * unitPerCal!,

            unitNetPrice = unitPriceCal! - unitNetPrice!,

            unitNetPrice = unitNetPrice! + double.tryParse(dressModel!.info!)!,
            netPrice = unitNetPrice!.toInt(),
            cprint('login message = mobile = unitNetPrice = '+unitNetPrice.toString()+"  , unitPerCal  ="+unitPerCal.toString()+"  , unitPriceCal  ="+unitPriceCal.toString()),
            cprint("Accept limit 1 netPrice = "+netPrice.toString()),
            showToast("Coupon applied successfully"),
            setState(() {
              netPrice;
              couponStatus = "1";
              couponId = CouponId;
            }),
          }else
          {
            cprint("endTempDate is before currentTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
          },


        }
    });
  }
  late String? couponId = "0";
late String? couponStatus = "0";

  late BuyDressOrder buyDressOrder;
  String? transationId;
  CollectionReference userss =
      FirebaseFirestore.instance.collection('BuyDress');
  String emailURL = "";
  String mainURl = "";

  sendEmailShipping()async {
    mainURl = "";
    mainURl = "https://androcoders.com/api/aminaboutique/orderprocessed.php?email="+ email!;
    sendMaile();
  }
  var requestEmail;
  sendMaile()async {
    print("emailURL full Complete =   "+mainURl);
    requestEmail = http.Request('POST', Uri.parse(mainURl));


    http.StreamedResponse response = await requestEmail.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      mainURl = "";
    }
    else {
      print(response.reasonPhrase);
    }
  }
  void bookOrder() async {
    sendEmailShipping();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String dressbuyids = "DressBuyId" + randomNumber.toString();

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattcertime = new DateFormat("h:mma");
    String formattedDate = formatter.format(now);
    String formattedTime = formattcertime.format(now);
    DateTime date = new DateTime(now.year, now.month, now.day);
    print("Lucky  check date  = " +
        date.toString() +
        ",  formattedDate  = " +
        formattedDate +
        " , time = " +
        formattedTime);
    buyDressOrder = BuyDressOrder(
      dressId: dressModel!.id,
      dressImg: dressModel!.imgWhite1,
      dressTitle: dressModel!.title,
      buyId: dressbuyids,
      transationId: transationId,
      dressSize: widget.sizeName!,
      dressQuantity: widget.totalquantity.toString(),
      dressUnitPrice: widget.unitPrice!,
      userId: id,
      userName: name,
      userImg: img,
      userMobile: mobile,
      userCity: city,
      userPincode: pincode,
      userState: state,
      userCountry: country,
      userAddress: address,
      userEmail: email,
      deliveryStatus: "Processing",
      date: formattedDate,
      time: formattedTime.toString(),
      couponId: couponId,
      deliveryCharges: dressModel!.info,
      netPrice: netPrice.toString(),
      couponStatus: couponStatus,
        rating: "false",
    );
    if(widget.stockKey == "SStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setSStock = totalStack.toString();
    }else if(widget.stockKey == "MStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setMStock = totalStack.toString();
    }else if(widget.stockKey == "LStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setLStock = totalStack.toString();
    }else if(widget.stockKey == "XLStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXLStock = totalStack.toString();
    }else if(widget.stockKey == "SxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setSXStock = totalStack.toString();
    }else if(widget.stockKey == "MxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setMXStock = totalStack.toString();
    }else if(widget.stockKey == "LxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setLXStock = totalStack.toString();
    }else if(widget.stockKey == "XLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXLxStock = totalStack.toString();
    }else if(widget.stockKey == "xXLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXXLxStock = totalStack.toString();
    }else if(widget.stockKey == "xxXLxStock"){
      int totalStack = widget.stockValue! -1;
      dressModel?.setXXXLxStock = totalStack.toString();
    }


    FirebaseFirestore.instance.collection('dress').doc(widget.ref).update(dressModel!.toJson());
    userss
        .add(buyDressOrder.toJson())
        .then((value) => {
              cprint('data insert'),
              setState(() {
                _progress = false;
              }),
              showToast("Order placed successfully"),
            //  nextScreenReplace(context, AddReviewScreen(dressModel: widget.dressModel,type: "Dress",))
      Navigator.pop(context),
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => cprint('Failed to add user: error'));
  }

  bool _progress = false;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  late String refId = "";

  void saveUserDetails() async {
    final pref = getIt<SharedPreferenceHelper>();

    bool? emails = await pref.saveUserEmail(_emailController.text);
    bool? add = await pref.saveUserAdd(_addressController.text);
    bool? citys = await pref.saveUserCity(_cityController.text);
    bool? states = await pref.saveStateName(_statsController.text);
    bool? pincodes = await pref.saveUserPinCode(_pincodeController.text);

    email = _emailController.text.toString();
    address = _addressController.text;
    city = _cityController.text;
    state = _statsController.text;
    pincode = _pincodeController.text;

    setState(() {
      email = _emailController.text.toString();
      address = _addressController.text;
      city = _cityController.text;
      state = _statsController.text;
      pincode = _pincodeController.text;
    });
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: mobile)
        .where('pass', isEqualTo: pass)
        .limit(1)
        .get()
        .then((value) => {
              if (value.size >= 1)
                {
                  docss = value.docs,
                  refId = docss[0].reference.id,
                  setState(() {
                    refId;
                  }),
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(refId)
                      .update({
                    'email': email, // John Doe
                    'mobile': mobile,
                    'pass': pass,
                    'name': Uname,
                    'address': address,
                    'id': userid,
                    'state': state,
                    'city': city,
                    'country': country,
                    'pincode': pincode,
                    'dob': dob,
                    'gender': gender,
                    'image': image,
                    'type': "user",
                    'wallet': "0",
                    'blocked': "0",
                    'maintenance': "0",
                  }),
                  showToast("User Details Save"),
                }
              else
                {showToast("wrong credentials")}
            });
  }

 final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CartView"),

      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              SizedBox(
                height: 250.0,
                width: double.infinity,
                child: banenrvisit
                    ? new CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          height: 250,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                        items: image.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: GestureDetector(
                                      child:
                                          Image.network(i, fit: BoxFit.cover),
                                      onTap: () {
                                        /*for (int z = 0; z < image.length; z++) {
                              if (image[z] == i.toString()) {
                                if (image.length > z) {


                                  */
                                        /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsPage(
                                                        P_Id: productModelBannerImageOne[
                                                        z]
                                                            .productId,
                                                        P_name:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .name,
                                                        P_description:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .description,
                                                        P_image1:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .image1,
                                                        P_verShortDesc:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .items[
                                                        0]
                                                            .verShortDesc,
                                                        P_verCapacity:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .items[
                                                        0]
                                                            .verCapacity,
                                                        P_verUnit:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .items[
                                                        0]
                                                            .verUnit,
                                                        P_verPrice:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .items[
                                                        0]
                                                            .verPrice,
                                                        P_offerPrice:
                                                        productModelBannerImageOne[
                                                        z]
                                                            .items[
                                                        0]
                                                            .offerPrice,
                                                        walletprice:
                                                        TotalWallet,
                                                      )));*/
                                        /*
                                }
                              }
                            }*/
                                      }));
                            },
                          );
                        }).toList(),
                      )
                    : new Row(
                        children: [
                          Expanded(
                            flex: 15,
                            child: Shimmer.fromColors(
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                                baseColor: Colors.grey,
                                highlightColor: Colors.white),
                          ),
                          Expanded(
                            flex: 70,
                            child: Shimmer.fromColors(
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                ),
                                baseColor: Colors.grey,
                                highlightColor: Colors.white),
                          ),
                          Expanded(
                            flex: 15,
                            child: Shimmer.fromColors(
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                                baseColor: Colors.grey,
                                highlightColor: Colors.white),
                          ),
                        ],
                      ),
              ),
              // title
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  dressModel!.title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // product info
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Product Info",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // details
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  dressModel!.details!,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              // Order Summary
              Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Color(0xff525252), width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Unit Price",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "₹ " + unitPrice! + ".00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Charges",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "₹ " + dressModel!.info! + ".00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Quantity",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            totalquantity.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Product Price",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "₹ " + netPrice.toString() + ".00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: checkfiltervisi,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "User Info",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      EntryField(
                        controller: _emailController,
                        label: 'Email',
                        image: null,
                        keyboardType: TextInputType.text,
                        maxLength: null,
                        readOnly: false,
                        hint: 'Enter your email',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      EntryField(
                        controller: _addressController,
                        label: 'Address',
                        image: null,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: null,
                        readOnly: false,
                        hint: 'Enter your address',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      EntryField(
                        controller: _cityController,
                        label: 'City',
                        image: null,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: null,
                        readOnly: false,
                        hint: 'Enter your city',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      EntryField(
                        controller: _statsController,
                        label: 'States',
                        image: null,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: null,
                        readOnly: false,
                        hint: 'Enter your state',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      EntryField(
                        controller: _pincodeController,
                        label: 'Pincode',
                        image: null,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        readOnly: false,
                        hint: 'Enter your pincode',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if(_pincodeController.text == "000000" || _pincodeController.text.length ==0){
                            showToast("please enter pincode");
                          }else if(_statsController.text == "Select State" || _statsController.text.length ==0){
                            showToast("please enter state");
                          }else if(_cityController.text == "Select City" || _cityController.text.length ==0){
                            showToast("please enter city");
                          }else if(_addressController.text == "House No/Street/Area" || _addressController.text.length ==0){
                            showToast("please enter address");
                          }else if(_emailController.text == "xyz@gmail.com" || _emailController.text.length ==0){
                            showToast("please enter email");
                          }else {

                          }
                          saveUserDetails();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Center(
                            child: Text(
                              "Save User Details",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.dressModel!.couponApply == "true"? false:true,
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Coupons",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible: widget.dressModel!.couponApply == "true"? false:true,
                child: Container(
                  child: FirestoreListView<Coupon>(
                      query: queryPostCoupon,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (context,snapshot){
                        final user = snapshot.data();
                        return ListTile(
                          onTap: (){
                            checkCoupon(user.limitUser!, user.id!,user.percentage!,user.endDate!);
                           // nextScreen(context, AdminCreateCouponScreen(check: false,coupon: user,refId: snapshot.reference.id,));
                          },
                                trailing: Text(user.percentage!+"%",style: Theme.of(context).textTheme.headline2,),

                          leading: CircleAvatar(backgroundImage: NetworkImage("https://img.freepik.com/free-vector/gift-coupon-with-ribbon-offer_24877-55663.jpg?size=626&ext=jpg&ga=GA1.1.1578454833.1643587200"),),
                          title: Text(user.titleName!.toUpperCase(),style: Theme.of(context).textTheme.headline2,),
                        );
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Color(0xff7b61ff),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₹ " + netPrice.toString() + ".00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Total price ",
                              style: TextStyle(
                                  color: Color(0xffc2b6ff), fontSize: 12),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          if (email! =="xyz@gmail.com") {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your Email");
                          } else
                          if (address! =="House No/Street/Area") {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your Address");
                          } else
                          if (address!.length < 10) {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your Address");
                          } else if (pincode! == "000000") {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your pincode");
                          } else if (pincode!.length < 6) {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your pincode");
                          } else if (state! == "Select State") {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your State");
                          } else if (city! == "Select City") {
                            setState(() {
                              checkfiltervisi = true;
                            });
                            showToast("Please Enter your city");
                          } else {
                            /*   showToast("Please Book order");*/
                            openCheckout();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff6953d9),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          child: Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
