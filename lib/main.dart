import 'package:goorm_project/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:goorm_project/kakao_login.dart';
import 'package:goorm_project/main_view_model.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart'; // Provider import
import 'package:goorm_project/screen/home_screen.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(KakaoLogin()), // Provide MainViewModel
      child: MaterialApp(
        title: 'Kakao Login Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const MyHomePage(title: 'Kakao Login Example'),
      ),
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
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.yellow.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 로고와 텍스트
              Image.asset(
                'assets/images/logo4.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain, // 이미지가 주어진 공간 내에 맞춰서 늘어나도록 설정
              ),
              const SizedBox(height: 16),
              const Text(
                "환영합니다! 나만의 맛집 리스트를 만들어보세요!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "로그인 후 다양한 맛집을 발견하고 나만의 일기를 작성하세요!",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 카카오 로그인 버튼
              GestureDetector(
                onTap: () async {
                  await viewModel.login();
                  if (viewModel.isLogined) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해 주세요.')),
                    );
                  }
                },
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE500),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/kakao_icon.png',
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Login with Kakao',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // 기능 설명 박스
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "🍽️ 맛집 추천: 사용자 리뷰를 바탕으로 한 식당 추천!\n📝 나만의 일기: 방문한 맛집을 기록해 보세요.\n👥 커뮤니티: 사용자들과 경험을 공유하세요.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
