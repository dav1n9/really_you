import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:really_you/screen/main_background.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

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
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 30, 0, 0),
                                    child: Text(
                                      i,
                                      style: const TextStyle(
                                        fontSize: 35.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(
                                      (i == "upload")
                                          ? Icons.phone_android
                                          : Icons.search,
                                      size: 70.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                  child: const Text(
                    '도움이 필요하신가요?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                  child: const Text(
                    '보이스피싱 피해 신고 : 000-0000',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                  child: const Text(
                    '보이스피싱 피해 신고 : 000-0000',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
