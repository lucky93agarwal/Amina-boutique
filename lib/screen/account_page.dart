import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/language.dart';
import 'package:amin/screen/contact_us.dart';
import 'package:amin/screen/edit_profile.dart';
import 'package:amin/screen/faq.dart';
import 'package:amin/screen/forget_pass.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/screen/list_tile.dart';
import 'package:amin/screen/order_screen.dart';
import 'package:amin/screen/otp.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/screen/webview.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('my Account', style: Theme.of(context).textTheme.bodyText1).tr(),
        centerTitle: true,
      ),
      body: Account(),
    );
  }
}
class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  late String number;
  //AccountBloc _accountBloc;

  String country_code = "";
  String Mobile = "";
  getUserID() async {
    final pref = getIt<SharedPreferenceHelper>();
    String? mobile = await pref.getUserMobile();
    String? country_code_new = await pref.getUserCountryCodeType();
    setState(() {
      Mobile = mobile!;
      country_code = country_code_new!;
    });




  }
  @override
  void initState() {
    super.initState();
    getUserID();
    // _accountBloc = BlocProvider.of<AccountBloc>(context);
  }

  // language popup
  _langPOPUP(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('logging out').tr(),
            content: Text('are you sure').tr(),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () =>  getUserID(),
                child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
              ),
            /*  FlatButton(
                child: Text('no').tr(),
                textColor: kMainColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kTransparentColor)),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text('yes').tr(),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: kTransparentColor)),
                  textColor: kMainColor,
                  onPressed: () {
                    getUserID();
                    *//* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()),
                          );*//*
                  })*/
            ],
          );
        });
  }
  saveLang(String title,int id)async{

    if(id == 1){
      context.locale = Locale('en', 'US');
    }else if(id == 2){
      context.locale = Locale('es', 'ES');
    }
    final pref = getIt<SharedPreferenceHelper>();
    bool? checkName = await pref.saveLangName(title);
    bool? checkId = await pref.saveLangId(id);
    await pref.setLogin(true);
    // login
    String? LangName = await pref.getLangName();
    int? LangID = await pref.getLangId();
    cprint('User Lang name =  '+LangName!+'  Lang id =   '+LangID.toString());
    nextScreen(context, HomeOrderAccount());
    /*  Navigator.pop(context);
    _langPOPUP();*/
  }
  Widget dividerLine(){
    return    Container(width: MediaQuery.of(context).size.width,
      height: 1,color: Color(0xFF303030),
      margin: const EdgeInsets.symmetric(horizontal: 1),);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserDetails(),

        SizedBox(
          height: 30,
        ),
   /*     AddressTile(),*/

        BuildListTile(
            image: 'assets/images/account/ic_edit.png',
            text: 'Edit Profile',
            check: false,
            context: context,
            onTap: () {
              nextScreen(context,EditProfileScreen(type: true));
              // _langPOPUP();
            }
        ),
        dividerLine(),
        BuildListTile(
          image: 'assets/images/account/icons_shopping_cart.png',
          text: 'Order list',
          check: false,
          context: context,
          onTap: () {

            nextScreen(context, OrderScreen(checkAdmin: false,));
          },
        ),
       /* dividerLine(),
        BuildListTile(
          image: 'assets/images/account/icons_chat.png',
          text: 'Chat Now',
          context: context,
          check: false,
          onTap: () {
            nextScreen(context, FAQScreen());
          },
        ),*/
        dividerLine(),
        BuildListTile(
            image: 'assets/images/account/icons_terms_and_conditions.png',
            text: 'terms & conditions',
            context: context,
            check: false,
            onTap: () {
              nextScreen(context, WebViewScreen(title: 'terms and conditions',url: "https://www.aminaboutique.in/app-terms-and-condition",));
            }
        ),
        dividerLine(),
        BuildListTile(
          image: 'assets/images/account/icons_privacy_policy.png',
          text: 'Refund Policy',
          context: context,
          check: false,
          onTap: () {
            nextScreen(context, WebViewScreen(title: 'Refund Policy',url: "https://www.aminaboutique.in/app-return-and-refund-policy",));
          },
        ),
        dividerLine(),
        BuildListTile(
          image: 'assets/images/account/icons_privacy_policy.png',
          text: 'privacy policy',
          context: context,
          check: false,
          onTap: () {
            nextScreen(context, WebViewScreen(title: 'privacy policy',url: "https://www.aminaboutique.in/app-privacy-policy",));
          },
        ),
        dividerLine(),
        BuildListTile(
          image: 'assets/images/account/icons_lock.png',
          text: 'reset Password',
          check: false,
          context: context,
          onTap: () {

            nextScreen(context, OTPScreen(country_code:country_code,mobile: Mobile,type:"forPass"));
          },
        ),


        dividerLine(),
        LogoutTile(),
      ],
    );
  }
}

class AddressTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
        image: 'assets/images/account/ic_menu_addressact.png',
        text: 'change Address',
        context: context,
        check: false,
        onTap: ()
        {
          nextScreen(context, ForgetPassScreen(type: "changeAdd",title: "change Address",));
         /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CityEditActivity()),
          );*/

        });
  }
}

class LogoutTile extends StatelessWidget {



/*  final dbhandler = DbStudentMamager.instance;
  void DeleteAPI() async {
    print('delete row  2 = ');
    var rowall = await dbhandler.deleteLoginResponse();
    print('delete row = '+rowall.toString());
  }*/
  @override
  Widget build(BuildContext context) {

    void getUserID() async {
      final pref = getIt<SharedPreferenceHelper>();
      pref.clearPreferenceValues();
      /*nextScreenReplace(context, SplashScreen());*/
      nextScreenCloseOthers(context,SplashScreen());
      /*   DeleteAPI();*/
    }

    return BuildListTile(
      image: 'assets/images/account/icons-logout.png',
      text: 'logout',
      context: context,
      check: false,
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('logging out',style: TextStyle(fontSize: 16,color: Colors.white),).tr(),
                content: Text('are you sure',style: TextStyle(fontSize: 14,color: Colors.white),).tr(),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () =>  Navigator.pop(context),
                    child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () =>  getUserID(),
                    child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                  ),
                  /*FlatButton(
                    child: Text('no'
                    , style: TextStyle(fontSize: 16),
                    ).tr(),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () => Navigator.pop(context),
                  ),*/
                /*  FlatButton(
                      child: Text('yes', style: TextStyle(fontSize: 16),).tr(),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                      textColor: kMainColor,
                      onPressed: () {

                        getUserID();
                       *//* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstPage()),
                        );*//*
                      })*/
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatefulWidget {

  @override
  _UserDetailsState createState() => _UserDetailsState();

}
class _UserDetailsState extends State<UserDetails> {
 String Name = "";
   String Mobile = "";
 String country_code = "";
   String Email = "";
  getUserID() async {
    final pref = getIt<SharedPreferenceHelper>();
    String? name = await pref.getUserName();
    String? mobile = await pref.getUserMobile();
    String? country_code_new = await pref.getUserCountryCodeType();
    String? email = await pref.getUserEmail();
    imageUrl = await pref.getUserImage();
    setState(() {
      Name = name!;
      country_code = country_code_new!;
      Mobile = mobile!;
      Email = email!;
      imageUrl;
    });




  }
  @override
  void initState() {
    super.initState();
    getUserID();
    // _accountBloc = BlocProvider.of<AccountBloc>(context);
  }
 String? imageUrl="assets/images/user.png";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(children: [
            Container(width: 60.0,
                height: 60.0,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                 shape: BoxShape.circle,
                  image:imageUrl == "assets/images/user.png" ? DecorationImage(image: AssetImage("assets/images/user.png"),fit: BoxFit.cover): DecorationImage(image: NetworkImage(imageUrl!),fit: BoxFit.cover)
                )
            ),
            Container(width: 200.0, margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\n' + Name == ""? '':"Hi "+Name.toUpperCase(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                Container( margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),child: Text(Email ??'', style: TextStyle(color: Colors.grey,)),)
              ],
            ),),
          ],),

         /* Container( margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text('\n' + Mobile ?? '', style: Theme.of(context).textTheme.subtitle2),),*/





        ],
      ),
    );
  }
}
