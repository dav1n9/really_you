import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:really_you/screen/search_screen.dart';
import 'package:really_you/screen/upload_screen.dart';

import 'screen/main_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized(); // 1번코드
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 추가해야하는 부분
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const MainScreen(),
        "/search": (context) => const SearchScreen(),
        "/upload": (context) => const UploadScreen(),
      },
    );
  }
}
