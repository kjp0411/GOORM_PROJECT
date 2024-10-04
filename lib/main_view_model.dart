// import 'package:goorm_project/social_login.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'package:flutter/foundation.dart'; // ChangeNotifier를 사용하기 위해 필요
//
// class MainViewModel extends ChangeNotifier { // ChangeNotifier를 상속받음
//   final SocialLogin _socialLogin;
//   bool isLogined = false;
//   User? user;
//
//   MainViewModel(this._socialLogin);
//
//   Future login() async {
//     try {
//       isLogined = await _socialLogin.login();
//       if (isLogined) {
//         user = await UserApi.instance.me(); // 로그인 성공 시 사용자 정보 요청
//         notifyListeners(); // 상태가 변경되었음을 알림
//       }
//     } catch (e) {
//       print("로그인 중 오류 발생: $e");
//       isLogined = false;
//       user = null;
//       notifyListeners(); // 상태가 변경되었음을 알림
//     }
//   }
//
//   Future logout() async {
//     try {
//       await _socialLogin.logout();
//       isLogined = false;
//       user = null;
//       notifyListeners(); // 상태가 변경되었음을 알림
//     } catch (e) {
//       print("로그아웃 중 오류 발생: $e");
//     }
//   }
//
//   void printUserInfo(User? user) {
//     if (user != null) {
//       String? nickname = user.kakaoAccount?.profile?.nickname;
//       String? email = user.kakaoAccount?.email;
//       String? phoneNumber = user.kakaoAccount?.phoneNumber;
//       String? profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;
//
//       print('닉네임: ${nickname ?? "없음"}');
//       print('이메일: ${email ?? "없음"}');
//       print('전화번호: ${phoneNumber ?? "없음"}');
//       print('프로필 이미지 URL: ${profileImageUrl ?? "없음"}');
//     } else {
//       print("사용자 정보가 없습니다.");
//     }
//   }
// }


import 'package:goorm_project/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/foundation.dart'; // ChangeNotifier를 사용하기 위해 필요
import 'dart:convert'; // JSON 변환을 위한 import

class MainViewModel extends ChangeNotifier { // ChangeNotifier를 상속받음
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    try {
      isLogined = await _socialLogin.login();
      if (isLogined) {
        user = await UserApi.instance.me(); // 로그인 성공 시 사용자 정보 요청
        notifyListeners(); // 상태가 변경되었음을 알림

        // 사용자 정보를 JSON으로 변환해 출력
        printUserInfo(user);
      }
    } catch (e) {
      print("로그인 중 오류 발생: $e");
      isLogined = false;
      user = null;
      notifyListeners(); // 상태가 변경되었음을 알림
    }
  }

  Future logout() async {
    try {
      await _socialLogin.logout();
      isLogined = false;
      user = null;
      notifyListeners(); // 상태가 변경되었음을 알림
    } catch (e) {
      print("로그아웃 중 오류 발생: $e");
    }
  }

  void printUserInfo(User? user) {
    if (user != null) {
      String? nickname = user.kakaoAccount?.profile?.nickname;
      String? email = user.kakaoAccount?.email;
      String? phoneNumber = user.kakaoAccount?.phoneNumber;
      String? profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;

      // 사용자 정보를 JSON 형식으로 변환
      Map<String, dynamic> userInfo = {
        'nickname': nickname ?? "없음",
        'email': email ?? "없음",
        'phoneNumber': phoneNumber ?? "없음",
        'profileImageUrl': profileImageUrl ?? "없음",
      };

      // JSON 형식으로 변환된 사용자 정보를 출력
      String userInfoJson = jsonEncode(userInfo);
      print('사용자 정보 (JSON): $userInfoJson');
    } else {
      print("사용자 정보가 없습니다.");
    }
  }
}
