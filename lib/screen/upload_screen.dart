import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../controller/upload_controller.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late UploadController uploadController;

  File selectedFile = File('');
  //bool uploadVisibility = true;

  @override
  void initState() {
    getPermission();
    uploadController = Get.put(UploadController());
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

  uploadAudio() async {
    final file = await getFilePath();
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

  Future<File> getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return File('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 65),
          child: Image.asset(
            'assets/images/logo.png',
            width: 120,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadController.resetUploadVisibility();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // 파일 가져오기?
                setState(() async {
                  selectedFile = await getFilePath();
                  if (selectedFile.path != '') {
                    uploadController.changeUploadVisibility();
                    print("업로드");
                  }
                });
              },
              child: Obx(
                () => Visibility(
                  visible: uploadController.uploadVisibility.value,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    dashPattern: const <double>[5, 3],
                    color: Color.fromARGB(255, 0, 66, 165),
                    strokeWidth: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.asset('assets/images/upload_icon.png')),
                            ),
                            Text(
                              'UPLOAD',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
