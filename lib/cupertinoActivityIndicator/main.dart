import 'package:flutter/material.dart';
import 'package:wanim/06/03/00/cross.dart';
import 'package:wanim/cupertinoActivityIndicator/cupertinoActivityIndicatorDemo.dart';
import 'package:wanim/pacman/pacman.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
            title: Text("CupertinoActivityIndicator 转动 loading"),
          ),
          body: Center(
            child: CupertinoActivityIndicatorDemo(),
          ),
        ));
  }
}
