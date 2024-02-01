import 'package:easy_khata/util/Cosntant.dart';
import 'package:easy_khata/util/shared_pref.dart';

class MySharedPreference {
  
  static void setUserLogin(bool isLogged) {
    SharedPrefs.instance.setBool(Constant.isLogin, isLogged);
  }
  
  static bool? isLogged() {
    return SharedPrefs.instance.getBool(Constant.isLogin);
  }
  
  static void setUserName(String userName) {
    SharedPrefs.instance.setString(Constant.userName, userName);
  }
  
  static String? getUserName() {
    return SharedPrefs.instance.getString(Constant.userName);
  }

  static void setPhoneNumber(String phoneNumber) {
    SharedPrefs.instance.setString(Constant.phoneNumber, phoneNumber);
  }

  static String? getPhoneNumber() {
    return SharedPrefs.instance.getString(Constant.phoneNumber);
  }
}