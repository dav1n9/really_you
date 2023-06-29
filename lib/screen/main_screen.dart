import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getPermission();
    //requestStoragePermission(context);
    super.initState();
  }

  uploadAudio() async {
    final audioPath = await getAudioFilePath(); // 오디오 파일 경로 가져오기
    final file = File(audioPath);
    print("uploadAudioFile: $file");

    // 파일 업로드를 위한 서버 URL 설정
    final url = Uri.parse('http://your-server-url.com/upload');
    // 파일 업로드 요청 보내기
    final response = await http.post(url, body: {
      'file': file.readAsBytesSync(),
    });

    // 응답 확인
    if (response.statusCode == 200) {
      print('파일 업로드 성공');
    } else {
      print('파일 업로드 실패');
    }
  }

  Future<String> getAudioFilePath() async {
    //final directory = await getExternalStorageDirectory();
    final directory = await getApplicationSupportDirectory();
    // Recordings/Call
    String appPath = '${directory.path}/20230629_121204.jpg';

    //final audioPath =
    //   '${directory.path}/내장 저장공간/Recordings/Voice Recorder/음성 024.m4a';
    return appPath;
  }

  void _openExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print("파일 경로 : $file");
    } else {
      // User canceled the picker
    }
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text("권한 설정을 확인해주세요."),
              actions: [
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      //Permission.storage.request(); // 허락해달라고 팝업띄우는 코드
                    },
                    child: const Text('설정하기')),
              ],
            );
          });
      return false;
    }
    return true;
  }

  getPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print('허락됨');
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              await uploadAudio();
              //_openExcelFile();
            },
            child: const Text('upload'),
          ),
          //Text('App Directory Path: $_appDirectoryPath'),
        ],
      ),
    );
  }
}
