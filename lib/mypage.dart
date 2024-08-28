import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goorm_project/main_view_model.dart'; // MainViewModel import
import 'package:goorm_project/main.dart'; // 로그인 화면 MyHomePage import

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context); // MainViewModel 접근

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 프로필 이미지가 있을 경우 표시
            if (viewModel.user?.kakaoAccount?.profile?.profileImageUrl != null)
              Image.network(viewModel.user!.kakaoAccount!.profile!.profileImageUrl!)
            else
              const Icon(Icons.account_circle, size: 100),

            const SizedBox(height: 20),

            Text('닉네임: ${viewModel.user?.kakaoAccount?.profile?.nickname ?? '알 수 없음'}'),
            Text('이메일: ${viewModel.user?.kakaoAccount?.email ?? '알 수 없음'}'),
            Text('전화번호: ${viewModel.user?.kakaoAccount?.phoneNumber ?? '알 수 없음'}'),

            const SizedBox(height: 20),

            // 로그아웃 버튼
            ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
                // 로그아웃 후 로그인 화면으로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Kakao Login Example')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
