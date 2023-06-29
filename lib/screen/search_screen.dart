import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:really_you/api/search_api.dart';
import '../controller/search_num_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final numberController = TextEditingController();
  late SearchNumController searchController;
  late SpamNum result;

  final String _searchQuery = '';
  List<String> _searchResults = [];
  List<String> _numResults = [];
  List<String> filteredPhoneNumbers = [];
  List<String> filteredDeppNumbers = [];

  ListTile myTile = const ListTile();

  late final client;
  @override
  void initState() {
    final dio = Dio();
    client = SearchApi(dio);
    searchController = Get.put(SearchNumController());
    super.initState();
  }

  Future<SpamNum> SpamNumFromJson(String num) async {
    SpamNum s = await client.getTasks(num);
    print(s.message);

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
                padding: const EdgeInsets.only(left: 40, right: 25),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: numberController,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _searchQuery = value;
                    //   });
                    // },
                    decoration: const InputDecoration(
                      labelText: '전화번호 입력',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () async {
                    // _searchPhoneNumber(_searchQuery);
                    result = await SpamNumFromJson(numberController.text);
                    print(result.numOfCall);
                    searchController.setMessage(result.message!);
                    searchController.setSpam(result.numOfCall!);
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
              padding: const EdgeInsets.all(30),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return myTile = ListTile(
                    title: Obx(() => Text(
                          searchController.message.value,
                          style: const TextStyle(fontSize: 21),
                        )),
                    subtitle: Obx(
                      () => Text(
                          "딥보이스 피싱 내역이 ${searchController.spam.value}건 있습니다."),
                    ),
                    onTap: () {
                      _callPhoneNumber(numberController.text);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callPhoneNumber(String phoneNumber) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(phoneNumber) ?? true;
    if (!res) {
      // 전화 걸기 실패 처리
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('딥보이스 피싱 내역'),
            content: const Text('딥보이프 피싱이 1건 있습니다.'),
            actions: [
              TextButton(
                child: const Text('닫기'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _searchPhoneNumber(searchQuery) {
    // 여기에서 전화번호 검색 로직을 구현합니다.
    // 예시로 간단히 더미 데이터를 사용합니다.
    filteredPhoneNumbers = [];
    filteredDeppNumbers = [];
    setState(() {
      _searchResults = [
        '123-456-7890',
        '987-654-3210',
        '555-123-4567',
      ];
      _numResults = [
        '딥페이크 피싱 내역이 1건 있습니다',
        '딥페이크 피싱 내역이 2건 있습니다',
        '딥페이크 피싱 내역이 2건 있습니다',
      ];
    });

    int deppNum = 0;
    for (String phoneNumber in _searchResults) {
      if (phoneNumber.contains(searchQuery)) {
        filteredPhoneNumbers.add(phoneNumber);
        filteredDeppNumbers.add(_numResults[deppNum]);
      }
      deppNum++;
    }
  }
}
