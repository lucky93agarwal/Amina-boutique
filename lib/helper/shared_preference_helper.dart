import 'dart:convert';
import 'dart:ffi';

import 'package:amin/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._internal();

  static final SharedPreferenceHelper _singleton =
  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  Future clearPreferenceValues() async {
    (await SharedPreferences.getInstance()).clear();
  }

  Future<bool> saveUserProfile(UserModel user) async {
    return (await SharedPreferences.getInstance()).setString(
        UserPreferenceKey.UserProfile.toString(), json.encode(user.toJson()));
  }

  Future<UserModel?> getUserProfile() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserProfile.toString());
    if (jsonString == null) return null;
    return UserModel.fromJson(json.decode(jsonString));
  }

// Check Login
  Future<bool> setLogin(bool user) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.CheckLogin.toString(), user);
  }

  Future<bool?> getLogin() async {
    final bool? checkData = (await SharedPreferences.getInstance())
        .getBool(UserPreferenceKey.CheckLogin.toString());
    if (checkData == null) return false;
    return checkData;
  }

  // Check Login
// Theme
  Future<bool> saveTheme(bool user) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.Theme.toString(), user);
  }

  Future<bool?> getTheme() async {
    final bool? jsonString = (await SharedPreferences.getInstance())
        .getBool(UserPreferenceKey.Theme.toString());
    if (jsonString == null) return null;
    return jsonString;
  }

// Theme

// LangID
  Future<bool> saveLangId(int id) async {
    return (await SharedPreferences.getInstance())
        .setInt(UserPreferenceKey.LangId.toString(), id);
  }
  Future<int?> getLangId() async {
    final int? jsonString = (await SharedPreferences.getInstance())
        .getInt(UserPreferenceKey.LangId.toString());
    if (jsonString == null) return 0;
    return jsonString;
  }
// LangID


// LangName
  Future<bool> saveLangName(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.LangName.toString(), id);
  }
  Future<String?> getLangName() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.LangName.toString());
    if (jsonString == null) return "null";
    return jsonString;
  }
// LangID



// StateName
  Future<bool> saveStateName(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.StateName.toString(), id);
  }
  Future<String?> getStateName() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.StateName.toString());
    if (jsonString == null) return "Select State";
    return jsonString;
  }
// LangID
  Future<bool> saveStateId(int id) async {
    return (await SharedPreferences.getInstance())
        .setInt(UserPreferenceKey.StateId.toString(), id);
  }
  Future<int?> getStateId() async {
    final int? jsonString = (await SharedPreferences.getInstance())
        .getInt(UserPreferenceKey.StateId.toString());
    if (jsonString == null) return 0;
    return jsonString;
  }
// LangID


// UserName
  Future<bool> saveUserName(String name) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserName.toString(), name);
  }
  Future<String?> getUserName() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserName.toString());
    if (jsonString == null) return "A16";
    return jsonString;
  }
// UserName




  // Dress List
  Future<bool> saveDress(List<String> name) async {
    return (await SharedPreferences.getInstance())
        .setStringList(UserPreferenceKey.UserDress.toString(), name);
  }
  Future<List<String>?> getDress() async {
    final List<String>? jsonString = (await SharedPreferences.getInstance())
        .getStringList(UserPreferenceKey.UserDress.toString());
    if (jsonString == null) return [];
    return jsonString;
  }
// Dress List





// UserPass
  Future<bool> saveUserPass(String pass) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserPass.toString(), pass);
  }
  Future<String?> getUserPass() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserPass.toString());
    if (jsonString == null) return "NA";
    return jsonString;
  }
// UserPass

// UserEmail
  Future<bool> saveUserEmail(String email) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserEmail.toString(), email);
  }
  Future<String?> getUserEmail() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserEmail.toString());
    if (jsonString == null) return "xyz@gmail.com";
    return jsonString;
  }
// UserEmail


// UserEmail
  Future<bool> saveUserAdd(String add) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserAddress.toString(), add);
  }
  Future<String?> getUserAdd() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserAddress.toString());
    if (jsonString == null) return "House No/Street/Area";
    return jsonString;
  }
// UserEmail


// UserMobile
  Future<bool> saveUserMobile(String mobile) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserMobile.toString(), mobile);
  }
  Future<String?> getUserMobile() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserMobile.toString());
    if (jsonString == null) return "NA";
    return jsonString;
  }
// UserMobile

  // UserCity
  Future<bool> saveUserCity(String mobile) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserCity.toString(), mobile);
  }
  Future<String?> getUserCity() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserCity.toString());
    if (jsonString == null) return "Select City";
    return jsonString;
  }
// UserCity

  // UserPinCode
  Future<bool> saveUserPinCode(String mobile) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserPinCode.toString(), mobile);
  }
  Future<String?> getUserPinCode() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserPinCode.toString());
    if (jsonString == null) return "000000";
    return jsonString;
  }
// UserPinCode

// UserId
  Future<bool> saveUserId(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserId.toString(), id);
  }
  Future<String?> getUserId() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserId.toString());
    if (jsonString == null) return "NA";
    return jsonString;
  }
// UserId

// UserCountry
  Future<bool> saveUserCountry(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserCountry.toString(), id);
  }
  Future<String?> getUserCountry() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserCountry.toString());
    if (jsonString == null) return "India";
    return jsonString;
  }
// UserCountry




// UserDOB
  Future<bool> saveUserDOB(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserDOB.toString(), id);
  }
  Future<String?> getUserDOB() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserDOB.toString());
    if (jsonString == null) return 'dd-mm-yyyy';
    return jsonString;
  }
// UserDOB


// UserDOB
  Future<bool> saveUserGender(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserGender.toString(), id);
  }
  Future<String?> getUserGender() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserGender.toString());
    if (jsonString == null) return 'Q13';
    return jsonString;
  }
// UserDOB

// UserImage
  Future<bool> saveUserImage(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserImage.toString(), id);
  }
  Future<String?> getUserImage() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserImage.toString());
    if (jsonString == null) return "https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg";
    return jsonString;
  }
// UserImage



// UserType
  Future<bool> saveUserType(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserType.toString(), id);
  }
  Future<String?> getUserType() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserType.toString());
    if (jsonString == null) return "user";
    return jsonString;
  }
// UserType




// UserCountryCode
  Future<bool> saveUserCountryCodeType(String id) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserCountryCode.toString(), id);
  }
  Future<String?> getUserCountryCodeType() async {
    final String? jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserCountryCode.toString());
    if (jsonString == null) return "user";
    return jsonString;
  }
// UserCountryCode


}

enum UserPreferenceKey {
  AccessToken,
  UserProfile,
  UserName,
  IsFirstTimeApp,
  Theme,
  CheckLogin,
  LangId,
  LangName,
  StateId,
  StateName,
  UserPass,
  UserAddress,
  UserEmail,
  UserMobile,
  UserCity,
  UserPinCode,
  UserCountry,
  UserDOB,
  UserGender,
  UserImage,
  UserType,
  UserId,
  UserDress,
  UserCountryCode,
}
