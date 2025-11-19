import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppSharedPreference {
  final String _COMPANY_NAME = "companyName";
  final String _IS_USER_LOGIN = "isUserLogin";
  final String _ACCESS_TOEKN = "accessToken";
  final String _USER_ID = "userId";
  final String _DEVICE_ID = "uniqueDeviceId";
  final String _USER_NAME="name";

  AppSharedPreference._internal(this.sharedPreferences);

  static AppSharedPreference? _instance;

  final SharedPreferences sharedPreferences;

  factory AppSharedPreference({required SharedPreferences sharedPreferences}) {
    _instance ??= AppSharedPreference._internal(sharedPreferences);
    return instance!;
  }

  static AppSharedPreference? get instance {
    return _instance;
  }

  Future<void> setCompanyName(String companyName) async {
    await sharedPreferences.setString(_COMPANY_NAME, companyName);
  }

  String getCompanyName() {
    return sharedPreferences.getString(_COMPANY_NAME) ?? "";
  }

  Future<void> setUserName(String name) async {
    await sharedPreferences.setString(_USER_NAME, name);
  }

  String getUserName() {
    return sharedPreferences.getString(_USER_NAME) ?? "";
  }

  Future<void> setIsUserLogin(bool isLogin) async {
    await sharedPreferences.setBool(_IS_USER_LOGIN, isLogin);
  }

  bool getIsUserLogin() {
    return sharedPreferences.getBool(_IS_USER_LOGIN) ?? false;
  }

  Future<void> setAccessToken(String accessToken) async {
    await sharedPreferences.setString(_ACCESS_TOEKN, accessToken);
  }

  String getAccessToken() {
    return sharedPreferences.getString(_ACCESS_TOEKN) ?? "";
  }

  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(_USER_ID, userId);
  }

  String getUserId() {
    return sharedPreferences.getString(_USER_ID) ?? "";
  }

  String getDeviceId() {
    var id = sharedPreferences.getString(_DEVICE_ID);
    id ??= const Uuid().v4();
    setUserId(id);
    return id;
  }

  Future<void> setDeviceId(String deviceId) async {
    await sharedPreferences.setString(_DEVICE_ID, deviceId);
  }

  Future<void> setIsPunchIn(bool isPunchIn) async{
    await sharedPreferences.setBool("isPunchIn", isPunchIn);
  }

  bool isPunchIN(){
    return sharedPreferences.getBool("isPunchIn") ?? false;
  }


}
