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
          return _printTokens(); // 토큰 출력 함수 호출
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return _printTokens(); // 토큰 출력 함수 호출
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

  Future<bool> _printTokens() async {
    try {
      OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
      if (token != null) {
        print('JWT Access Token: ${token.accessToken}');
        print('Refresh Token: ${token.refreshToken}');
        return true;
      } else {
        print('토큰 정보를 가져올 수 없습니다.');
        return false;
      }
    } catch (e) {
      print('토큰 가져오기 실패: $e');
      return false;
    }
  }
}
