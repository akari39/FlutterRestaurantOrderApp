import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:scan/scan.dart';

import 'choose_service.dart';

class ScanPage extends StatefulWidget {

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  StateSetter? stateSetter;
  IconData lightIcon = Icons.flash_on;
  ScanController controller = ScanController();

  void getResult(String result){
    setState(() {
      _appBarBrightness = Brightness.light;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChooseService())
    );
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