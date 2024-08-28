import 'package:goorm_project/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:goorm_project/kakao_login.dart';
import 'package:goorm_project/main_view_model.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart'; // Provider import

void main() {
  KakaoSdk.init(nativeAppKey: '4cbec296cd4ae6f59d26e4d7a62aa36b');
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
          primarySwatch: Colors.blue,
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
    final viewModel = Provider.of<MainViewModel>(context); // Use provided MainViewModel

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await viewModel.login();
            if (viewModel.isLogined) {
              // 로그인에 성공하면 HomeScreen으로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              // 로그인 실패 시 메시지 출력
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해 주세요.')),
              );
            }
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
