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
  int _selectedCategoryIndex = 0; // 카테고리 선택 인덱스 (홈, 한식 등)
  int _selectedNavIndex = 0; // 네비게이션 선택 인덱스 (홈, 맛집일기 등)

  // 맛집 리스트와 맛집 일기 리스트를 정의 (이름과 이미지 경로 포함)
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
    {'name': '맛집 A', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '맛집 B', 'image': 'assets/images/b.png'},
    {'name': '맛집 C', 'image': 'assets/images/c.png'},
    {'name': '맛집 A', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '맛집 B', 'image': 'assets/images/b.png'},
    {'name': '맛집 C', 'image': 'assets/images/c.png'},
  ];

  final List<Map<String, String>> diaryRestaurantList = [
    {'name': '맛집 A', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '맛집 B', 'image': 'assets/images/b.png'},
    {'name': '맛집 C', 'image': 'assets/images/c.png'},
    {'name': '맛집 A', 'image': 'assets/images/a.png'}, // 이미지 경로 추가
    {'name': '맛집 B', 'image': 'assets/images/b.png'},
    {'name': '맛집 C', 'image': 'assets/images/c.png'},
  ];


  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeTab(
        restaurantList: restaurantList,
        diaryRestaurantList: diaryRestaurantList, // 맛집 일기 리스트 전달
      ),
      KoreanFoodPage(),
      ChineseFoodPage(),
      SnacksPage(),
      WesternFoodPage(),
      JapaneseFoodPage(),
      DessertPage(),
      DetailPage(title: '맛집 일기 전체보기',
        restaurantList: diaryRestaurantList,
        showAppBar: true,),
      BulletinBoardPage(), // 게시판
      MyPage(), // 마이페이지
      MorePage(), // 더보기
    ]);
  }
  void _onCategoryTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index; // 카테고리 선택 시 업데이트
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index; // 네비게이션 탭 선택 시 업데이트
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
      body: _selectedNavIndex == 0 // "홈" 탭일 때 카테고리 화면 표시
          ? Column(
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
                  isSelected: _selectedCategoryIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index; // 카테고리 버튼 클릭 시 변경
                    });
                  },
                  fontSize: 20.0,
                );
              }),
            ),
          ),
          Expanded(
            child: _buildCategoryPage(), // 선택된 카테고리에 맞는 페이지
          ),
        ],
      )
          : _buildNavigationPage(), // 네비게이션 탭 페이지
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '맛집 일기'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시판'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
        ],
        currentIndex: _selectedNavIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedNavIndex == 1
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

  /// 카테고리 선택에 따른 화면을 반환
  Widget _buildCategoryPage() {
    switch (_selectedCategoryIndex) {
      case 0:
        return HomeTab(
          restaurantList: restaurantList,
          diaryRestaurantList: diaryRestaurantList,
        ); // 추천 페이지
      case 1:
        return KoreanFoodPage(); // 한식 페이지
      case 2:
        return ChineseFoodPage(); // 중식 페이지
      case 3:
        return SnacksPage(); // 분식 페이지
      case 4:
        return WesternFoodPage(); // 양식 페이지
      case 5:
        return JapaneseFoodPage(); // 일식 페이지
      case 6:
        return DessertPage(); // 디저트 페이지
      default:
        return HomeTab(restaurantList: restaurantList, diaryRestaurantList: diaryRestaurantList); // 기본 페이지
    }
  }

  /// 네비게이션 탭 선택에 따른 화면 반환
  Widget _buildNavigationPage() {
    switch (_selectedNavIndex) {
      case 1:
        return DetailPage(
          title: '맛집 일기 전체보기',
          restaurantList: diaryRestaurantList,
          showAppBar: true,
        ); // 맛집일기 페이지
      case 2:
        return BulletinBoardPage(); // 게시판 페이지
      case 3:
        return MyPage(); // 마이페이지
      case 4:
        return MorePage(); // 더보기 페이지
      default:
        return HomeTab(restaurantList: restaurantList, diaryRestaurantList: diaryRestaurantList); // 기본 홈 화면
    }
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
          // "리뷰 많은 식당" 부분만 스타일 변경
          ReviewSection(
            title: '리뷰 많은 식당',
            restaurantList: restaurantList
                .map((item) => {
              'name': item['name'],
              'image': item['image'],
              'address': item.containsKey('address') ? item['address'] : '서울 강남구 테헤란로',
            })
                .toList(), // Iterable을 List로 변환
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: '리뷰 많은 식당 전체보기',
                    restaurantList: restaurantList
                        .map((item) => {
                      'name': item['name'],
                      'image': item['image'],
                      'address': '서울 강남구 테헤란로',
                    })
                        .toList(), // Iterable을 List로 변환
                  ),
                ),
              );
            },
          ),
          // "최근 맛집 일기" 부분은 기존 스타일 유지
          Section(
            title: '최근 맛집 일기',
            restaurantList: diaryRestaurantList
                .map((item) => {
              'name': item['name'],
              'image': item['image'],
              'address': '서울 강남구 테헤란로',
            })
                .toList(),
            scrollDirection: Axis.vertical,
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
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text('전체보기 >', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(
            height: scrollDirection == Axis.horizontal ? 200.0 : 400.0,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: scrollDirection,
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final imagePath = restaurantList[index]['image'] ?? 'assets/images/default.png';
                final restaurantName = restaurantList[index]['name'] ?? '가게 이름 없음';
                final restaurantAddress = restaurantList[index]['address'] ?? '주소 정보 없음';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Row가 자식 크기만큼 축소됨
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagePath,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible( // 부모 크기에 맞게 조정되도록 변경
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurantName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                restaurantAddress,
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.yellow),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  title: restaurantName,
                                  restaurantList: [restaurantList[index]],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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

class ReviewSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> restaurantList;
  final VoidCallback onTap;

  const ReviewSection({
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
                child: const Text('전체보기 >', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final imagePath = restaurantList[index]['image'] ?? 'assets/images/default.png';
                final restaurantName = restaurantList[index]['name'] ?? '가게 이름 없음';
                final restaurantAddress = restaurantList[index]['address'] ?? '주소 정보 없음';

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Stack(
                    children: [
                      // 이미지 부분
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          imagePath,
                          width: 300,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // 투명도 있는 가게 정보 박스
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 가게 이름과 주소
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurantName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.orange, size: 16.0),
                                        const SizedBox(width: 4.0),
                                        Expanded(
                                          child: Text(
                                            restaurantAddress,
                                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // 화살표 아이콘
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, color: Colors.yellow),
                                onPressed: () {
                                  // 버튼 클릭 시 상세 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        title: restaurantName,
                                        restaurantList: [restaurantList[index]],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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

