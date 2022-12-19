// import 'package:amin/common/locator.dart';
// import 'package:amin/helper/shared_preference_helper.dart';
// import 'package:amin/helper/uitils.dart';
// import 'package:amin/model/course_list.dart';
// import 'package:amin/utils/color.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class RazorpayScreen extends StatefulWidget {
//   CourseList courseList;
//   int? price;
//   String? couponStatus;
//   String? couponId;
//   RazorpayScreen({Key? key,required this.courseList,required this.price,required this.couponStatus,required this.couponId}) : super(key: key);

//   @override
//   State<RazorpayScreen> createState() => _RazorpayScreenState();
// }
//
// class _RazorpayScreenState extends State<RazorpayScreen> {
//   Razorpay _razorpay = Razorpay();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     firstqueryall();
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   showToast(String test) {
//     Fluttertoast.showToast(
//       msg: test,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: kMainColor,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
//   String? UserName = "";
//   String? UserMobile = "";
//   String? UserEmail = "";
//   String? UserId = "";
//   void firstqueryall() async {
//     print("Lucky price = ");
//     final pref = getIt<SharedPreferenceHelper>();
//     UserName = await pref.getUserName();
//     UserMobile = await pref.getUserMobile();
//     UserEmail = await pref.getUserEmail();
//     UserId = await pref.getUserId();
//     setState(() {
//       openCheckout(widget.price.toString()+"00", UserEmail!, UserMobile!, UserName!);
//     });
//
//
//   }
//   void openCheckout(
//       String TotalPrice, String Email, String Mobile, String Username) async {
//
//
//     var options = {
//       /*'key': 'rzp_test_1DP5mmOlF5G5ag',*/
//       'key': 'rzp_live_UeB21TNJL5A3Gq',
//       'amount': TotalPrice,
//       'name': Username,
//       'description': widget.courseList.cName!,
//       'send_sms_hash': true,
//       'prefill': {'contact': Mobile, 'email': Email},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//   String? Transectionid;
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     /*showToast("SUCCESS: ");*//*
//     Toast.show("SUCCESS: " + response.paymentId, context,
//         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/
//     print("SUCCESS paymentId: " + response.paymentId!);
// //    print("SUCCESS : " + response.orderId);
//     Transectionid = response.paymentId;
//
//     _runapi();
//
//     // Navigator.popAndPushNamed(context, PageRoutes.homePage);
//   }
//
//   CollectionReference userss = FirebaseFirestore.instance.collection('course_buy');
//   _runapi(){
//     var now = new DateTime.now();
//     var formatter = new DateFormat('yyyy-MM-dd');
//     String formattedDate = formatter.format(now);
//     userss
//         .add({
//       'uId': UserId, // John Doe
//       'cId': widget.courseList.cId,
//       'date': formattedDate,
//       'transectionId': Transectionid,
//       'price': widget.courseList.cPrice,
//       'review':"false",
//       'coupon_id': widget.couponId,
//       'Coupon_status': widget.couponStatus
//     })
//         .then((value) => {
//           showToast("Course Purchased Successfully"),
//     Navigator.pop(context),
//
//     })
//     // ignore: invalid_return_type_for_catch_error
//         .catchError(
//             (error) => cprint('Failed to add user: error'));
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     showToast("Transaction Canceled");
//     Navigator.pop(context);
//
// //    Fluttertoast.showToast(
// //        msg: "ERROR: " + response.code.toString() + " - " + response.message,
// //        timeInSecForIos: 4);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     showToast("EXTERNAL_WALLET: " + response.walletName!);
//     Navigator.pop(context);
// //    Fluttertoast.showToast(
// //        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kMainColor,
//       body: Container(
//       ),
//     );
//   }
// }






import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  CourseList courseList;
  int? price;
  String? couponStatus;
  String? couponId;
  RazorpayScreen({Key? key,required this.courseList,required this.price,required this.couponStatus,required this.couponId}) : super(key: key);

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    firstqueryall();
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  String? UserName = "";
  String? UserMobile = "";
  String? UserEmail = "";
  String? UserId = "";
  void firstqueryall() async {
    print("Lucky price = ");
    final pref = getIt<SharedPreferenceHelper>();
    UserName = await pref.getUserName();
    UserMobile = await pref.getUserMobile();
    UserEmail = await pref.getUserEmail();
    UserId = await pref.getUserId();
    setState(() {
      openCheckout(widget.price.toString()+"00", UserEmail!, UserMobile!, UserName!);
    });


  }
  void openCheckout(
      String TotalPrice, String Email, String Mobile, String Username) async {


//       /*'key': 'rzp_test_1DP5mmOlF5G5ag',*/
//       'key': 'rzp_live_UeB21TNJL5A3Gq',
//       'amount': TotalPrice,
//       'name': Username,
//       'description': widget.courseList.cName!,
//       'send_sms_hash': true,
//       'prefill': {'contact': Mobile, 'email': Email},



    var options = {
      'key': Config.RAZORPAY_RETROFIT_URL,
      'amount': TotalPrice,
      'name': Username,
      'description': widget.courseList.cName!,
      'send_sms_hash': true,
      'prefill': {'contact': Mobile, 'email': Email},
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
  String? Transectionid;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    print("SUCCESS paymentId: " + response.paymentId!);

    Transectionid = response.paymentId;



    CollectionReference userss = FirebaseFirestore.instance.collection('course_buy');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    userss
        .add({
      'uId': UserId, // John Doe
      'cId': widget.courseList.cId,
      'date': formattedDate,
      'transectionId': Transectionid,
      'price': widget.courseList.cPrice,
      'review':"false",
      'coupon_id': widget.couponId,
      'Coupon_status': widget.couponStatus,


      'title':widget.courseList.cName!,
      'userName': UserName,
      'paid_Amount': widget.courseList.cPrice,
    })
        .then((value) => {
      showToast("Course Purchased Successfully"),
      Navigator.pop(context),

    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));

  }



  void _handlePaymentError(PaymentFailureResponse response) {
    print("SUCCESS error: " + response.message!);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Container(
      ),
    );
  }
}