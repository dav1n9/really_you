import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:really_you/screen/main_background.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<String> list = ["방금 대화 의심스러운데?", "의심번호를 조심하세요!"];

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          width: 120,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: MainBackGround(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                  child: Text(
                    'REALLYOU로 딥보이스를 탑지하세요!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(
                    '남녀노소 속을 수 있는 딥보이스 피싱을 릴리유로 예방하세요.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_ub60s1vk.json',
                  width: 350,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    
                    height: 180.0,
                    enableInfiniteScroll: false,
                  ),
                  items: ["upload", "search"].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            (i == "upload")
                                ? Navigator.of(context).pushNamed("/upload")
                                : Navigator.of(context).pushNamed("/search");
                          },
                          child: (i == "upload")? upload() : search()
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                  child: Text(
                    '도움이 필요하신가요?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(8, 13, 0, 0),
                //   child: RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(text: '보이스피싱 피해'),
                //         TextSpan(text: '신고', style: TextStyle(fontWeight: FontWeight.bold)),
                //         TextSpan(text: ': 110'),
                //       ]
                //     )),
                //   // child: const Text(
                //   //   '보이스피싱 피해 신고 : 110',
                //   //   style: TextStyle(fontSize: 15),
                //   // ),
                // ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                  child: GestureDetector(
                    child: Text(
                      '보이스피싱 피해 신고 : 1379',
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      // String url = 'tel:$phoneNumber';
                      // if (await canLaunch(url)) {
                      //   await launch(url);
                      // } else {
                      //   throw '전화 걸기를 지원하지 않는 기기입니다.';
                      // }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget upload() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 62, 113),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding:
                  EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: const Column(
                children: <Widget>[
                  Text(
                  "방금 대화 의심스러운데?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "통화 내용을 업로드하여 딥보이스를 판별하세요.",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.phone_android,
                size: 70.0,
                color: Colors.white,
              ),
            ),
          ],
        )),
    );
  }

  Widget search() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 68, 70),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: const Column(
                children: [
                  Text(
                    "의심번호를 조심하세요!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "해당 전화번호의 피싱 내역을 조회할 수 있습니다.",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.search,
                size: 70.0,
                color: Colors.white,
              ),
            ),
          ],
        )),
    );
  }
}
