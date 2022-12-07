import 'package:amin/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amin/utils/config.dart';

class ThemeModel {
  final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.pink,
    primaryColor: Config().appThemeColor,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Color(0xff0d0d11),
    shadowColor: Colors.grey[200],
    brightness: Brightness.light,
    fontFamily: 'Manrope',
    colorScheme: ColorScheme.light(
        primary: Colors.black,
        //text
        secondary: Colors.grey[700]!,
        //text
        onPrimary: Colors.white,
        //card -1
        onSecondary: Colors.grey[100]!,
        //card -2
        primaryVariant: Colors.grey[200]!,
        //card color -3
        secondaryVariant: Colors.grey[300]!,
        //card color -4
        surface: Colors.grey[300]!,
        //shadow color -1
        onBackground: Colors.grey[300]! //loading card color
    ),
    dividerColor: Colors.grey[300],
    iconTheme: IconThemeData(color: Colors.grey[900]),
    primaryIconTheme: IconThemeData(
      color: Colors.grey[900],
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontFamily: 'Nexa',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.7,
          color: Colors.grey[900]),
      iconTheme: IconThemeData(color: Colors.grey[900]),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Config().appThemeColor,
      unselectedItemColor: Colors.blueGrey[200],
    ),
    popupMenuTheme: PopupMenuThemeData(
      textStyle: TextStyle(
          fontFamily: 'Manrope',
          color: Colors.grey[900],
          fontWeight: FontWeight.w500),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Color(0xff13213e), fontSize: 20,letterSpacing: 1.0, fontWeight: FontWeight.w900,),
      headline2: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13,),
      headline3: TextStyle(color: Color(0Xffe6d395), fontWeight: FontWeight.w900, fontSize: 13,),
      headline4: TextStyle(color: Color(0xff13213e), fontWeight: FontWeight.bold, fontSize: 17,),
      headline5: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),
      headline6: TextStyle(color: Colors.lightBlue, fontSize: 15,),
      subtitle1: TextStyle(color: Color(0xff13213e), fontSize: 12,letterSpacing: 0.5, fontWeight: FontWeight.w600,),
      subtitle2: TextStyle(color: Color(0xff777777), fontSize: 17, fontWeight: FontWeight.w500,),
      bodyText1: TextStyle(color: Colors.white, fontSize: 15,),
      bodyText2: TextStyle(color: Color(0xff13213e), fontSize: 13,),
      caption: TextStyle(color: Color(0xff13213e), fontSize: 13.3,),
      button: TextStyle(fontSize: 13.3, color: kWhiteColor,),
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        color: Colors.white),
  );

  final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.pink,
    primaryColor: Config().appThemeColor,
    backgroundColor: Color(0xff16161e),
    scaffoldBackgroundColor: Color(0xff0d0d11),
    shadowColor: Colors.grey[850],
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    colorScheme: ColorScheme.dark(
        primary: Colors.white,
        //text
        secondary: Colors.grey[400]!,
        //text
        onPrimary: Colors.grey[800]!,
        //card color -1
        onSecondary: Colors.grey[800]!,
        //card color -2
        primaryVariant: Colors.grey[800]!,
        //card color -3
        secondaryVariant: Colors.grey[800]!,
        //card color -4
        surface: Color(0xff303030),
        //shadow color - 1
        onBackground: Colors.grey[800]! //loading card color

    ),
    dividerColor: Colors.grey[300],
    iconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
        color: Color(0xff0d0d11),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Nexa',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.7,
            color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
    ),
    popupMenuTheme: PopupMenuThemeData(
      textStyle: TextStyle(
          fontFamily: 'Nexa',
          color: Colors.white,
          fontWeight: FontWeight.w500),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.grey[300], fontSize: 25,letterSpacing: 1.0, fontWeight: FontWeight.w900,),
      headline2: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, ),
      headline3: TextStyle(color: kMainColor, fontSize: 15, fontWeight: FontWeight.w900,),
      headline4: TextStyle(
          color: Colors.grey[300], fontWeight: FontWeight.bold, fontSize: 17),
      headline5: TextStyle(
          color: Colors.grey[300], fontSize: 14, fontWeight: FontWeight.w600,),
      headline6: TextStyle(color: Colors.grey[300], fontSize: 15,letterSpacing: 0.5,),
      subtitle1: TextStyle(color: Color(0xff6b6b71), fontSize: 13,letterSpacing: 0.5, fontWeight: FontWeight.w600,),
      subtitle2: TextStyle(color: Colors.grey[300], fontSize: 17, fontWeight: FontWeight.normal,fontFamily: "Raleway"),
      bodyText1: TextStyle(color: Colors.grey[300], fontSize: 15,),
      caption: TextStyle(color: kMainColor, fontSize: 13.3,),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      color: Colors.grey[800],
    ),
  );

//text style of continue bottom bar
  final TextStyle bottomBarTextStyle = TextStyle(
      fontSize: 15.0,
      color: kWhiteColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'OpenSans');
}
