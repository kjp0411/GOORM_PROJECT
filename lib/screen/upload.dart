import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _textController = TextEditingController();
  final List<File> _images = [];
  final List<String> _tags = [];
  final picker = ImagePicker();
  double _rating = 3.0; // 기본 별점

  // 이미지 선택 (여러 장 선택 가능)
  Future<void> _pickImage() async {
    if (_images.length >= 5) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("최대 5장까지 첨부할 수 있습니다.")));
      return;
    }

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  // 태그 추가
  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
    }
  }

  // 데이터 전송
  Future<void> _uploadData() async {
    String text = _textController.text;

    if (text.isEmpty || _images.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("모든 필드를 채워주세요!")));
      return;
    }

    // 업로드 로직 (서버 연동)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("업로드 중...")),
    );

    // 요청 보내기 (여기선 임의로 성공 메시지 표시)
    await Future.delayed(Duration(seconds: 2)); // 가상의 업로드 대기 시간
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("업로드 성공!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '맛집 일기 작성',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        actions: [
          TextButton(
            onPressed: _uploadData,
            child: Text(
              '완료',
              style: TextStyle(color: Colors.yellow, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 가게명 및 별점
            Text(
              "안양감자탕",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            RatingBar.builder(
              initialRating: 3.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 16.0),

            // 텍스트 입력 필드
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '내용을 입력해주세요',
              ),
            ),
            SizedBox(height: 16.0),

            // 이미지 미리보기 및 추가 버튼
            Text(
              "사진 업로드",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                ..._images.map((image) => Stack(
                  children: [
                    Image.file(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _images.remove(image);
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(Icons.add, size: 40, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // 태그 추가 기능
            Text(
              "간단 태그",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: _addTag,
                    decoration: InputDecoration(
                      hintText: '태그를 입력 후 Enter',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  deleteIcon: Icon(Icons.cancel),
                  onDeleted: () {
                    setState(() {
                      _tags.remove(tag);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
