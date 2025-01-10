import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:goorm_project/social_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          // JWT 토큰을 받아오는 부분
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
          print('JWT Token: ${tokenInfo.id}');
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          // JWT 토큰을 받아오는 부분
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
          print('JWT Token: ${tokenInfo.id}');
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      return true;
    } catch (e) {
      return false;
    }
  }
}