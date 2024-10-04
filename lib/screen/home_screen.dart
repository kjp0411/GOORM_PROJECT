import 'package:flutter/material.dart';
import 'package:goorm_project/main_view_model.dart'; // MainViewModel import
import 'package:goorm_project/kakao_login.dart'; // KakaoLogin import
import 'package:goorm_project/mypage.dart'; // MyPage import
import 'package:provider/provider.dart'; // Provider import
import 'package:goorm_project/screen/upload.dart'; // UploadPage import

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // 탭별 페이지 위젯 리스트
  static const List<Widget> _pages = <Widget>[
    HomeTab(), // 홈
    DetailPage(title: '맛집 일기'), // 맛집 일기
    BulletinBoardPage(), // 게시판
    MyPage(), // 마이페이지
    MorePage(), // 더보기
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('냥냠집'),
      ),
      body: _pages[_selectedIndex], // 선택된 인덱스에 따른 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '맛집 일기'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시판'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // 탭 선택 시 해당 인덱스에 맞는 페이지로 이동
      ),
// 맛집 일기 탭 선택 시 플로팅 액션 버튼 표시
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadPage()),
          );
        },
        child: Icon(Icons.add),
      )
          : null,
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 카테고리 버튼 섹션
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 16.0,
              alignment: WrapAlignment.spaceAround,
              children: [
                CategoryButton(
                  iconPath: 'assets/images/custom_icon.png',
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryButton(
                  label: '추천',
                  isSelected: true,
                  onTap: () {},
                  fontSize: 20.0,
                ),
                CategoryButton(
                  label: '한식',
                  isSelected: false,
                  onTap: () {},
                  fontSize: 20.0,
                ),
                CategoryButton(
                  label: '중식',
                  isSelected: false,
                  onTap: () {},
                  fontSize: 20.0,
                ),
                CategoryButton(
                  label: '양식',
                  isSelected: false,
                  onTap: () {},
                  fontSize: 20.0,
                ),
                CategoryButton(
                  label: '분식',
                  isSelected: false,
                  onTap: () {},
                  fontSize: 20.0,
                ),
                CategoryButton(
                  label: '일식',
                  isSelected: false,
                  onTap: () {},
                  fontSize: 20.0,
                ),
              ],
            ),
          ),
          // 맛집 리스트 섹션
          Section(
            title: '맛집 리스트',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const DetailPage(title: '맛집 리스트 전체보기')),
              );
            },
          ),
          // 맛집 일기 섹션
          Section(
            title: '맛집 일기',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const DetailPage(title: '맛집 일기 전체보기')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String? label;
  final String? iconPath;
  final bool isSelected;
  final VoidCallback onTap;
  final double? fontSize;

  const CategoryButton({
    Key? key,
    this.label,
    this.iconPath,
    required this.isSelected,
    required this.onTap,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0), // 이미지 위에 패딩 추가
              child: Image.asset(
                iconPath!,
                width: 24,
                height: 24,
              ),
            ),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontSize: fontSize,
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 2.0,
              width: 20.0,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const Section({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text(
                  '전체보기 >',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    width: 150,
                    child: Center(child: Text('$title 항목 ${index + 1}')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text('상세 페이지: $title'),
      ),
    );
  }
}

class BulletinBoardPage extends StatelessWidget {
  const BulletinBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("게시판 내용"),
      ),
    );
  }
}



class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("더보기 페이지 내용"),
      ),
    );
  }
}