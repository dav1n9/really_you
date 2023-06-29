
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  void initState() {
    getPermission();
    //requestStoragePermission(context);
    super.initState();
  }

  getPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print('허락');
    } else if (status.isDenied) {
      print('거절');
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
    }
  }

  // uploadAudio() async {
  //   final audioPath = await getFilePath(); // 오디오 파일 경로 가져오기
  //   final file = File(audioPath);
  //   print("uploadAudioFile: $file");

  //   // 파일 업로드를 위한 서버 URL 설정
  //   final url = Uri.parse('http://your-server-url.com/upload');
  //   // 파일 업로드 요청 보내기
  //   final response = await http.post(url, body: {
  //     'file': file.readAsBytesSync(),
  //   });

  //   // 응답 확인
  //   if (response.statusCode == 200) {
  //     print('파일 업로드 성공');
  //   } else {
  //     print('파일 업로드 실패');
  //   }
  // }

  // Future<File> getFilePath() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;
  //   } else {
  //     // User canceled th
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Upload Audio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('UPLOAD'),
            ),
          ],
        ),
      ),
    );
  }
}
