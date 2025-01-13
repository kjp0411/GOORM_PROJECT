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

  final List<Map<String, dynamic>> categories = [
    {'label': '추천', 'iconPath': 'assets/images/custom_icon.png'},
    {'label': '한식', 'iconPath': 'assets/images/한식.png'},
    {'label': '중식', 'iconPath': 'assets/images/중식.png'},
    {'label': '분식', 'iconPath': 'assets/images/분식.png'},
    {'label': '양식', 'iconPath': 'assets/images/패스트푸드.png'},
    {'label': '일식', 'iconPath': 'assets/images/일식.png'},
    {'label': '디저트', 'iconPath': 'assets/images/디저트.png'},
  ];

  final List<Map<String, dynamic>> restaurantList = [
    {'name': '세상 밖으로', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '타이마실', 'image': 'assets/images/b.png'},
    {'name': 'cafe levelroz', 'image': 'assets/images/c.png'},
  ];

  final List<Map<String, String>> diaryRestaurantList = [
    {'name': '세상 밖으로', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '타이마실', 'image': 'assets/images/b.png'},
    {'name': 'cafe levelroz', 'image': 'assets/images/c.png'},
  ];


  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeTab(
          restaurantList: restaurantList,
          diaryRestaurantList: diaryRestaurantList), // 추천 페이지
      KoreanFoodPage(),
      ChineseFoodPage(),
      SnacksPage(),
      WesternFoodPage(),
      JapaneseFoodPage(),
      DessertPage(),
    ]);
  }

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '냥냠집',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 16.0,
              alignment: WrapAlignment.spaceAround,
              children: List.generate(categories.length, (index) {
                return CategoryButton(
                  label: categories[index]['label'],
                  iconPath: categories[index]['iconPath'],
                  isSelected: _selectedIndex == index,
                  onTap: () => _onCategoryTapped(index),
                  fontSize: 20.0,
                );
              }),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex], // 선택된 페이지를 표시
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final List<Map<String, dynamic>> restaurantList;
  final List<Map<String, String>> diaryRestaurantList;

  const HomeTab({Key? key, required this.restaurantList, required this.diaryRestaurantList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Section(
            title: '리뷰 많은 식당',
            restaurantList: restaurantList,
            scrollDirection: Axis.horizontal, // 가로 스크롤
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: '리뷰 많은 식당 전체보기',
                    restaurantList: restaurantList,
                  ),
                ),
              );
            },
          ),
          Section(
            title: '최근 맛집 일기',
            restaurantList: diaryRestaurantList.map((item) => {'name': item['name'], 'image': item['image']}).toList(),
            scrollDirection: Axis.vertical, // 세로 스크롤
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: '최근 맛집 일기 전체보기',
                    restaurantList: diaryRestaurantList,
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
              padding: const EdgeInsets.only(top: 5.0),
              child: Image.asset(iconPath!, width: 24, height: 24),
            ),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontSize: fontSize,
                color: isSelected ? Colors.blue : Colors.black, // 선택된 탭은 파란색
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 2.0,
              width: 20.0,
              color: Colors.blue, // 밑줄 강조
            ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> restaurantList;
  final Axis scrollDirection;
  final VoidCallback onTap;

  const Section({
    Key? key,
    required this.title,
    required this.restaurantList,
    required this.onTap,
    this.scrollDirection = Axis.horizontal,
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
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: onTap,
                child: const Text('전체보기 >', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(
            height: scrollDirection == Axis.horizontal ? 200.0 : 400.0, // 높이 제한 추가
            child: ListView.builder(
              physics: const ClampingScrollPhysics(), // 스크롤 고정 설정
              scrollDirection: scrollDirection,
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final imagePath = restaurantList[index]['image'] ?? 'assets/images/default.png';
                return Card(
                  child: Column(
                    children: [
                      Image.asset(
                        imagePath,
                        width: scrollDirection == Axis.horizontal ? 150 : double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          restaurantList[index]['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
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
  final List<Map<String, dynamic>> restaurantList;

  const DetailPage({Key? key, required this.title, required this.restaurantList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          final imagePath = restaurantList[index]['image'] ?? 'assets/images/default.png';
          return Card(
            child: Column(
              children: [
                Image.asset(imagePath, height: 200, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(restaurantList[index]['name'] ?? ''),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class KoreanFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("한식 페이지"));
  }
}

class ChineseFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("중식 페이지"));
  }
}

class SnacksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("분식 페이지"));
  }
}

class WesternFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("양식 페이지"));
  }
}

class JapaneseFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("일식 페이지"));
  }
}

class DessertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("디저트 페이지"));
  }
}