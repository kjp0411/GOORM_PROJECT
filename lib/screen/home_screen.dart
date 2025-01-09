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

  // 맛집 리스트와 맛집 일기 리스트를 정의 (이름과 이미지 경로 포함)
  final List<Map<String, String>> restaurantList = [
    {'name': '맛집 A', 'image': 'assets/images/a.png'},
    {'name': '맛집 B', 'image': 'assets/images/a.png'}, // 이미지가 없는 경우 빈 문자열로
    {'name': '맛집 C', 'image': 'assets/images/a.png'},
    {'name': '맛집 D', 'image': 'assets/images/a.png'},
    {'name': '맛집 리스트 테스트', 'image': 'assets/images/a.png'},
  ];

  final List<Map<String, String>> diaryRestaurantList = [
    {'name': '맛집 E', 'image': 'assets/images/a.png'},
    {'name': '맛집 F', 'image': 'assets/images/a.png'},
    {'name': '맛집 G', 'image': 'assets/images/a.png'},
    {'name': '맛집 일기 테스트', 'image': 'assets/images/a.png'},
  ];

  // 탭별 페이지 위젯 리스트
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTab(
        restaurantList: restaurantList,
        diaryRestaurantList: diaryRestaurantList, // 맛집 일기 리스트 전달
      ),
      DetailPage(
        title: '맛집 일기 전체보기',
        restaurantList: diaryRestaurantList,
        showAppBar: true,
      ),
      BulletinBoardPage(), // 게시판
      MyPage(), // 마이페이지
      MorePage(), // 더보기
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 1
          ? null // 맛집 일기 탭에서는 AppBar 숨김
          : AppBar(
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
  final List<Map<String, String>> restaurantList;
  final List<Map<String, String>> diaryRestaurantList; // 맛집 일기 리스트 추가

  const HomeTab({Key? key, required this.restaurantList, required this.diaryRestaurantList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          Section(
            title: '맛집 리스트',
            restaurantList: restaurantList, // restaurantList 데이터 전달
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: '맛집 리스트 전체보기',
                    restaurantList: restaurantList,
                    showAppBar: true,
                  ),
                ),
              );
            },
          ),
          Section(
            title: '맛집 일기',
            restaurantList: diaryRestaurantList, // 맛집 일기 리스트 전달
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: '맛집 일기 전체보기',
                    restaurantList: diaryRestaurantList,
                    showAppBar: true,
                  ),
                ),
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
  final List<Map<String, String>> restaurantList;
  final VoidCallback onTap;

  const Section({
    Key? key,
    required this.title,
    required this.restaurantList,
    required this.onTap,
  }) : super(key: key);

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
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final imagePath = restaurantList[index]['image']!.isEmpty
                    ? 'assets/images/default.png' // 기본 이미지 경로
                    : restaurantList[index]['image']!;
                return Card(
                  child: Column(
                    children: [
                      Image.asset(
                        imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(restaurantList[index]['name']!),
                      ),
                    ],
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
  final List<Map<String, String>> restaurantList;
  final bool showAppBar;

  const DetailPage({
    Key? key,
    required this.title,
    required this.restaurantList,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(title)) : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            final imagePath = restaurantList[index]['image']!.isEmpty
                ? 'assets/images/default.png' // 기본 이미지 경로
                : restaurantList[index]['image']!;
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      restaurantList[index]['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
