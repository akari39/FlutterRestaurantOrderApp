import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:images_picker/images_picker.dart';
import 'package:scan/scan.dart';
import 'package:wireless_order_system/model/dish.dart';
import 'package:wireless_order_system/model/restaurant.dart';

import '../wos_network.dart';
import 'choose_service.dart';
import 'menu.dart';

class ScanPage extends StatefulWidget {

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  StateSetter? stateSetter;
  IconData lightIcon = Icons.flash_on;
  ScanController controller = ScanController();

  Future<void> getResult(String result) async {
    setState(() {
      _appBarBrightness = Brightness.light;
    });
    await WOSNetwork.instance.get(WOSNetwork.getRestaurant, {"childDeskId": result}, (data) {
      if(data != null) {
        Restaurant.initRestaurant(data); //获取餐厅信息并初始化至餐厅单例
        Restaurant.deskId = int.parse(result);
        if(!Restaurant.instance.isEmpty()) { //判断餐厅单例是否为空
          WOSNetwork.instance.get(WOSNetwork.getMenu, {"childDeskId": Restaurant.deskId.toString()}, (data) {
            List<Dish> dishes = [];
            data.forEach((element) {
              Dish dish = Dish.fromJson(element);
              this.setState(() {
                dishes.add(dish);
              });
            });
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Menu(dishes: dishes)) //跳转界面
            );
          });
        } else {
          Fluttertoast.showToast(msg: "获取餐厅失败"); //弹出提示
        }
      }
    });
  }

  Brightness _appBarBrightness = Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          brightness: _appBarBrightness,
          elevation: 0,
          title: Text("扫描点餐码", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
            children: [ScanView(
              controller: controller,
              scanAreaScale: .7,
              scanLineColor: Theme.of(context).primaryColor,
              onCapture: (data) {
                getResult(data);
              },
            ),
              Positioned(
                left: 100,
                bottom: 100,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    stateSetter = setState;
                    return IconButton(
                        icon: Icon(lightIcon, size: 32, color: Theme.of(context).primaryColor),
                        onPressed: (){
                          controller.toggleTorchMode();
                          if (lightIcon == Icons.flash_on){
                            lightIcon = Icons.flash_off;
                          }else {
                            lightIcon = Icons.flash_on;
                          }
                          setState(){}
                        }
                    );
                  },
                ),
              ),
              Positioned(
                right: 100,
                bottom: 100,
                child: IconButton(
                    icon: Icon(Icons.image, size: 32, color: Theme.of(context).primaryColor),
                    onPressed: () async {
                      List<Media> res = (await ImagesPicker.pick())!;
                      if (res != null) {
                        String result = (await Scan.parse(res[0].path))!;
                        getResult(result);
                      }
                    }
                ),
              ),
            ]
        ),
      ),
    );
  }
}