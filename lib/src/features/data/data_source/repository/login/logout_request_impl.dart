import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import '../../../../domain/repository/login/logout_repo.dart';
import '../../remote/login/request_login_api_impl.dart';

class LogoutRequestImpl implements RepositoryLogoutAbstract {
  final LoginApiImpl loginApiImpl;

  LogoutRequestImpl(this.loginApiImpl);

  @override
  Future<bool> logout(String token) async {
    try {
      // read token from shared pref
      final prefs = AppSharedPreference.instance!;
      final token = prefs.getAccessToken();

      // 1️⃣ Call API
      final response = await loginApiImpl.logout(token);

      // 2️⃣ If logout is successful → clear saved data
      if (response) {
        await prefs.setAccessToken("");
        await prefs.setUserId("");
        await prefs.setIsUserLogin(false);
        await prefs.setUserName("");
        await prefs.setCompanyName("");
        await prefs.setIsPunchIn(false);

        // Do NOT delete deviceId — deviceId should stay same.
        // await prefs.setDeviceId("");  ❌ remove this

        return true;
      }

      return false;

    } catch (e) {
      print("Logout Error: $e");
      return false;
    }
  }
}
