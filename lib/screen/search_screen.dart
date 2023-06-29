import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../api/search_api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final numberController = TextEditingController();
  late SpamNum result;

  late String _searchQuery = '';
  List<String> _searchResults = [];
  List<String> _numResults = [];
  List<String> filteredPhoneNumbers = [];
  List<String> filteredDeppNumbers = [];

  ListTile myTile = const ListTile();

  // late final SpamNum spamNum;

  final TextEditingController _textEditingController = TextEditingController();

  late final client;
  @override
  void initState() {
    final dio = Dio();
    client = SearchApi(dio);
    super.initState();
  }

  Future<SpamNum> SpamNumFromJson(String num) async {
    SpamNum result;
    SpamNum s = await client.getTasks(num);
    //print(s.message);
    // Map<String, dynamic> list = json.decode(s);
    // result = (SpamNum.fromJson(list));

    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchMain(),
    );
  }

  Widget SearchMain() {
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
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 25),
                child: SizedBox(
                  width: 250,
                  height: 70,
                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20.0),
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                        filled: true,
                        hintText: '전화번호 입력',
                        fillColor: Colors.white,
                        ),
                      ),
                  ),
                    // keyboardType: TextInputType.phone,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  onPressed: () async {
                    // _searchPhoneNumber(_searchQuery);
                    result = await SpamNumFromJson(numberController.text);
                    String? number = result.message;
                    int? num = result.numOfCall;
                    // print(number);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse('0xFF5A96E3')),
                  ),
                  child: const Text('검색'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListView.builder(
                itemCount: filteredPhoneNumbers.length,
                itemBuilder: (context, index) {
                  final phoneNumber = filteredPhoneNumbers[index];
                  final deepVoiceNumber = filteredDeppNumbers[index];
                  return myTile = ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/images/warning_icon3.png")),
                    
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(result.message.toString()),
                    ),
                    //subtitle: Text(deepVoiceNumber),
                    // onTap: () {
                    //   _callPhoneNumber(phoneNumber);
                    // },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMsg() {
    switch(result.message.toString()) {
      case ("해당 전화번호는 딥보이스 이력이 있는 번호 입니다."):
        break;
    }
      return Scaffold(
        body: Text(result.message.toString()),
      );
    }
  }

  // void _callPhoneNumber(String phoneNumber) async {
  //   bool res = await FlutterPhoneDirectCaller.callNumber(phoneNumber) ?? true;
  //   if (!res) {
  //     // 전화 걸기 실패 처리
  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('딥보이스 피싱 내역'),
  //           content: const Text('딥보이프 피싱이 1건 있습니다.'),
  //           actions: [
  //             TextButton(
  //               child: const Text('닫기'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // void _searchPhoneNumber(searchQuery) {
  //   // 여기에서 전화번호 검색 로직을 구현합니다.
  //   // 예시로 간단히 더미 데이터를 사용합니다.
  //   filteredPhoneNumbers = [];
  //   filteredDeppNumbers = [];
  //   setState(() {
  //     _searchResults = [
  //       '123-456-7890',
  //       '987-654-3210',
  //       '555-123-4567',
  //     ];
  //     _numResults = [
  //       '딥페이크 피싱 내역이 1건 있습니다',
  //       '딥페이크 피싱 내역이 2건 있습니다',
  //       '딥페이크 피싱 내역이 2건 있습니다',
  //     ];
  //   });

  //   int deppNum = 0;
  //   for (String phoneNumber in _searchResults) {
  //     if (phoneNumber.contains(searchQuery)) {
  //       filteredPhoneNumbers.add(phoneNumber);
  //       filteredDeppNumbers.add(_numResults[deppNum]);
  //     }
  //     deppNum++;
  //   }
  // }
// }
