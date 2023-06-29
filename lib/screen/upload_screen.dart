import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:really_you/api/upload_api.dart';

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

  late final client;

  @override
  void initState() {
    getPermission();
    uploadController = Get.put(UploadController());
    final dio = Dio();
    client = UploadApi(dio);
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

  Future<File> getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print('getFilePath() File 선택 성공 : $file');
      return file;
    } else {
      print('getFilePath() File 선택 실패');
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
        title: const Text('Upload Audio'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadController.resetVisibility();
          uploadController.resetResult();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                // 파일 가져오기?
                setState(() async {
                  selectedFile = await getFilePath();

                  if (selectedFile.path != '') {
                    uploadController.changeUploadVisibility();
                    uploadController.changeResultVisibility();
                    String i = await client.getAudio(selectedFile);
                    uploadController.result.value = i;
                    print("결과 : $i");
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
                    color: Colors.blue.shade900,
                    strokeWidth: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.folder_copy_outlined),
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
            Obx(
              () => Visibility(
                visible: uploadController.resultVisibility.value,
                child: Lottie.network((uploadController.resultVisibility.value)
                    ? 'https://assets7.lottiefiles.com/packages/lf20_2mm5zqab.json'
                    : 'https://assets6.lottiefiles.com/packages/lf20_kl8fqoe3.json'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
