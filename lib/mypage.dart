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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 정보
            Center(
              child: Column(
                children: [
                  if (viewModel.user?.kakaoAccount?.profile?.profileImageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        viewModel.user!.kakaoAccount!.profile!.profileImageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Icon(Icons.account_circle, size: 100),

                  const SizedBox(height: 16),
                  Text('닉네임: ${viewModel.user?.kakaoAccount?.profile?.nickname ?? '알 수 없음'}'),
                  Text('이메일: ${viewModel.user?.kakaoAccount?.email ?? '알 수 없음'}'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 섹션 1: 나의 게시글
            SectionItem(
              icon: Icons.edit_note,
              title: '나의 게시글',
              description: '내가 작성한 게시글을 확인할 수 있습니다.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPostsPage()),
                );
              },
            ),

            // 섹션 2: 나의 맛집 즐겨찾기
            SectionItem(
              icon: Icons.favorite,
              title: '나의 맛집 즐겨찾기',
              description: '즐겨찾기에 추가한 맛집을 확인할 수 있습니다.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyFavoriteRestaurantsPage()),
                );
              },
            ),

            // 섹션 3: 나의 맛집 일기
            SectionItem(
              icon: Icons.book,
              title: '나의 맛집 일기',
              description: '내가 작성한 맛집 일기 목록을 확인할 수 있습니다.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDiaryPostsPage()),
                );
              },
            ),

            const SizedBox(height: 20),

            // 로그아웃 버튼
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await viewModel.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Kakao Login Example')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const SectionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.yellow),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

class MyPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 사용자의 게시글 목록 페이지
    return Scaffold(
      appBar: AppBar(title: Text('나의 게시글'), backgroundColor: Colors.yellow),
      body: Center(child: Text('나의 게시글 목록')),
    );
  }
}

class MyFavoriteRestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 사용자의 즐겨찾기 맛집 목록 페이지
    return Scaffold(
      appBar: AppBar(title: Text('나의 맛집 즐겨찾기'), backgroundColor: Colors.yellow),
      body: Center(child: Text('즐겨찾기한 맛집 목록')),
    );
  }
}

class MyDiaryPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 사용자의 맛집 일기 목록 페이지
    return Scaffold(
      appBar: AppBar(title: Text('나의 맛집 일기'), backgroundColor: Colors.yellow),
      body: Center(child: Text('맛집 일기 목록')),
    );
  }
}

