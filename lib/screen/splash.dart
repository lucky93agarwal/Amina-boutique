import 'dart:io';

import 'package:amin/admin/admin_home.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/first.dart';
import 'package:amin/screen/home.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/screen/login.dart';
import 'package:amin/utils/config.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:version_check/version_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkVersion();
  //  checkLogin();
  }

  // final versionCheck = VersionCheck(
  //   packageName: 'com.app.aminaboutique',
  //   packageVersion: '1.0.28',
  //   showUpdateDialog: customShowUpdateDialog,
  //   country: 'in',
  // );
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;



  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(

        title: new Text(
          'NEW Update Available',
          style: Theme.of(context).textTheme.headline2,
        ).tr(),
        content: new Text('Do you REALLY want to update to ${Config.packageVersion}?',
            style: Theme.of(context).textTheme.bodyText2)
            .tr(),
        actions: <Widget>[
          // new GestureDetector(
          //   onTap: () => Navigator.of(context).pop(false),
          //   child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
          // ),
          // SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              /*Navigator.of(context).pop(true);*/
              // exit(0);



              final url = Uri.parse("market://details?id=${Config.packageName}");
              launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
          ),
        ],
      ),
    );
  }
  Future checkVersion() async {


    var result = await FirebaseFirestore.instance
        .collection('app_info')
        .where('packageVersion', isEqualTo: Config.packageVersion)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {
          // setState(() {
          //   _progress = false;
          // }),
          docss = value.docs,
          cprint('login message = reference id = ' +
              docss[0].reference.id),
          checkLogin(),

          /*showToast("User already exist...")*/
        }
      else
        {

          _onWillPop(),
          // setState(() {
          //   _progress = false;
          // }),
          cprint('login message = mobile = false'),

        }
    });

 //  var checki =  await versionCheck.checkVersion(context);
 //   print('data check in roll 1 ');
 //   print(checki);
 //   print('data check in roll 1 ');
 //   if(checki == null){
 //     checkLogin();
 //   }
    // setState(() {
    //   version = versionCheck.packageVersion;
    //   packageName = versionCheck.packageName;
    //   storeVersion = versionCheck.storeVersion;
    //   storeUrl = versionCheck.storeUrl;
    // });
  }


  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  checkLogin() async {
    final pref = getIt<SharedPreferenceHelper>();
    bool? check = await pref.getLogin();
    String? type = await pref.getUserType();

    if (check!) {
      // login
      cprint('User Login ');
      if(type == "admin"){
        Future.delayed(const Duration(seconds: 1)).then((_) {
          nextScreenReplace(context, AdminHomeScreen());
        });
       // nextScreenReplace(context, AdminHomeScreen());
      }else {
        Future.delayed(const Duration(seconds: 1)).then((_) {
          nextScreenReplace(context, HomeOrderAccount());
        });
     //   nextScreenReplace(context, HomeOrderAccount());
      }
    } else {
      cprint('User Not Login');
      Future.delayed(const Duration(seconds: 1)).then((_) {
        nextScreenReplace(context, LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: CachedNetworkImage(
                imageUrl: "assets/images/icons/iconappbar.png",
                imageBuilder: (context, imageProvider) => Container(width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(image: DecorationImage(image: imageProvider)),),
                placeholder: (context, url) => SizedBox(width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())),),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),*/
            Image.asset(
              "assets/images/icons/iconappbar.png", //delivoo logo
              height: 200.0,
              width: 200,
            ),
            Text(
              "Aminaboutique",
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
// void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       title: Text('NEW Update Available'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: <Widget>[
//             Text(
//                 'Do you REALLY want to update to ${versionCheck.storeVersion}?'),
//             Text('(current version ${versionCheck.packageVersion})'),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('Update'),
//           onPressed: () async {
//             await versionCheck.launchStore();
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Close'),
//           onPressed: () {
//             exit(0);
//           },
//         ),
//       ],
//     ),
//   );
// }
