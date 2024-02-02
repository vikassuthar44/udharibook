import 'package:easy_khata/util/Cosntant.dart';
import 'package:easy_khata/util/shared_pref.dart';

class MySharedPreference {

  static void setUserId(String userId) {
    SharedPrefs.instance.setString(Constant.USER_ID, userId);
  }

  static String? getUserId() {
    return SharedPrefs.instance.getString(Constant.USER_ID);
  }

  static void setTotalAmountGet(String amount) {
    SharedPrefs.instance.setString(Constant.TOTAL_AMOUNT_GET, amount);
  }

  static String? getTotalAmountGet() {
    return SharedPrefs.instance.getString(Constant.TOTAL_AMOUNT_GET);
  }

  static void setTotalAmountGive(String amount) {
    SharedPrefs.instance.setString(Constant.TOTAL_AMOUNT_GIVE, amount);
  }

  static String? getTotalAmountGive() {
    return SharedPrefs.instance.getString(Constant.TOTAL_AMOUNT_GIVE);
  }

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
