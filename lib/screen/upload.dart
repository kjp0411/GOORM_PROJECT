import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _textController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  // 이미지 선택
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // 데이터 전송
  Future<void> _uploadData() async {
    String text = _textController.text;
    if (text.isEmpty || _image == null) {
      // 텍스트나 이미지가 없을 때 처리
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("모든 필드를 채워주세요!")));
      return;
    }

    // 업로드할 데이터 생성 (JSON 형식)
    var request = http.MultipartRequest('POST', Uri.parse('YOUR_SERVER_URL_HERE'));

    request.fields['text'] = text;
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    // 서버에 데이터 전송
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("업로드 성공!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("업로드 실패")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맛집 일기 업로드'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 텍스트 입력 필드
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용을 입력하세요',
              ),
            ),
            SizedBox(height: 16.0),

            // 이미지 선택 버튼 및 이미지 미리보기
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('사진 선택'),
            ),
            SizedBox(height: 16.0),
            _image != null
                ? Image.file(_image!, height: 200)
                : Text('선택된 이미지 없음'),

            SizedBox(height: 16.0),

            // 업로드 버튼
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('업로드'),
            ),
          ],
        ),
      ),
    );
  }
}
