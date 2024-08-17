import 'package:goorm_project/screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:goorm_project/kakao_login.dart';
import 'package:goorm_project/main_view_model.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: HomeScreen(),
//     ),
//   );
// }

void main() {
  KakaoSdk.init(nativeAppKey: '4cbec296cd4ae6f59d26e4d7a62aa36b');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Kakao Login Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 프로필 이미지가 존재할 때만 렌더링
            if (viewModel.user?.kakaoAccount?.profile?.profileImageUrl != null)
              Image.network(viewModel.user!.kakaoAccount!.profile!.profileImageUrl!)
            else
              const Icon(Icons.account_circle, size: 100), // 프로필 이미지가 없을 경우 아이콘 표시

            const SizedBox(height: 20),

            // 사용자 닉네임과 이메일 표시
            Text('닉네임: ${viewModel.user?.kakaoAccount?.profile?.nickname ?? '알 수 없음'}'),
            Text('이메일: ${viewModel.user?.kakaoAccount?.email ?? '알 수 없음'}'),

            // 전화번호 표시 추가
            Text('전화번호: ${viewModel.user?.kakaoAccount?.phoneNumber ?? '알 수 없음'}'),

            const SizedBox(height: 20),

            // 로그인 상태 확인
            Text(
              '로그인 상태: ${viewModel.isLogined ? "로그인됨" : "로그인 안됨"}',
              style: Theme.of(context).textTheme.headline6,
            ),

            const SizedBox(height: 20),

            // 로그인 버튼
            ElevatedButton(
              onPressed: () async {
                await viewModel.login();
                setState(() {});
              },
              child: const Text('Login'),
            ),

            // 로그아웃 버튼
            ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
                setState(() {});
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
