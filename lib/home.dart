import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '05/02/main.dart' as main0502;
import '05/03/main.dart' as main0503;
import '05/05/main.dart' as main0505;
import '06/01/00/main.dart' as main060100;
import '06/01/01/main.dart' as main060101;
import '06/01/02/main.dart' as main060102;
import '06/02/00/main.dart' as main060200;
import '06/03/00/main.dart' as main060300;
import '07/05/main.dart' as main0705;
import 'pacman/main.dart' as mainPacman;
import 'cupertinoActivityIndicator/main.dart' as mainCupertinoActivityIndicator;
import 'player/main.dart' as mainPlayer;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final viewList = <Map<String, Object>>[
    {
      "title": "圆形头像呼吸效果",
      "onTap": () {
        Get.to(() => main0502.MyApp());
      }
    },
    {
      "title": "ToggleRotate 组件",
      "onTap": () {
        Get.to(() => main0503.MyApp());
      }
    },
    {
      "title": "自定义 BurstMenu 组件",
      "onTap": () {
        Get.to(() => main0505.MyApp());
      }
    },
    {
      "title": "流光loading",
      "onTap": () {
        Get.to(() => main060100.MyApp());
      }
    },
    {
      "title": "流光loading2",
      "onTap": () {
        Get.to(() => main060101.MyApp());
      }
    },
    {
      "title": "流光loading 合体",
      "onTap": () {
        Get.to(() => main060102.MyApp());
      }
    },
    {
      "title": "旋转loading",
      "onTap": () {
        Get.to(() => main060200.MyApp());
      }
    },
    {
      "title": "交错loading",
      "onTap": () {
        Get.to(() => main060300.MyApp());
      }
    },
    {
      "title": "DecoratedBoxTransition 装饰动画",
      "onTap": () {
        Get.to(() => main0705.MyApp());
      }
    },
    {
      "title": "吃豆人",
      "onTap": () {
        Get.to(() => mainPacman.MyApp());
      }
    },
    {
      "title": "CupertinoActivityIndicator 转动 loading",
      "onTap": () {
        Get.to(() => mainCupertinoActivityIndicator.MyApp());
      }
    },
    {
      "title": "语音播放效果",
      "onTap": () {
        Get.to(() => mainPlayer.MyApp());
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
      body: ListView.builder(
        itemCount: viewList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 48,
            margin: EdgeInsets.only(
              top: 10,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              // color: Colors.greenAccent,
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: InkWell(
              onTap: viewList[index]['onTap'] as Function(),
              child: Row(
                children: [
                  Expanded(
                    child: Text(viewList[index]['title'] as String),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
