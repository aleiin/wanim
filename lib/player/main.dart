import 'package:flutter/material.dart';
import 'package:wanim/player/player.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("语音播放效果"),
          ),
          body: Center(
            child: InkWell(
              onTap: () {
                isPlay = !isPlay;
                setState(() {});
              },
              child: Player(
                isPlays: isPlay,
                size: Size(200, 200),
              ),
            ),
          ),
        ));
  }
}