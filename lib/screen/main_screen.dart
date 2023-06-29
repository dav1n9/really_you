import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: Text(
                  'DeepVoice를 탐지하세요!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 30),
                child: Text(
                  'DeepVoice를 탐지하세요!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
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
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 30, 0, 0),
                                  child: Text(
                                    i,
                                    style: const TextStyle(
                                      fontSize: 35.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 180),
                                  child: Icon(
                                    (i == "upload")
                                        ? Icons.phone_android
                                        : Icons.search,
                                    size: 150.0,
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

              //Text('App Directory Path: $_appDirectoryPath'),
            ],
          ),
        ),
      ),
    );
  }
}
