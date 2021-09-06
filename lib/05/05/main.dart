import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanim/05/02/circle_shine_image.dart';
import 'package:wanim/05/03/toggle_rotate.dart';
import 'package:wanim/05/05/burst_menu.dart';
import 'package:wanim/common/common.dart';

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
            body: Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.greenAccent,
            child: Center(
              child: BurstMenu(
                center: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
                menus: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.orange,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   color: Colors.orange,
                  // ),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   color: Colors.blue,
                  // ),
                ],
              ),
            ),
          ),
        )));
  }
}
