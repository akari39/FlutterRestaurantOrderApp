import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wireless_order_system/widget/choose_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wireless_order_system/widget/scan_qrcode.dart';

import 'my.dart';

class DetailAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String? restaurantName;
  final String? restaurantSubName;
  final String? restaurantImage;
  final String? desk;
  final Function? onPressUser;

  const DetailAppBar({Key? key, this.restaurantName, this.restaurantSubName, this.restaurantImage, this.desk, this.onPressUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0);
}

class DetailAppBarState extends State<DetailAppBar>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
          children: [
            if(widget.restaurantName != null)
              Card(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          if(widget.restaurantImage != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: SizedBox(
                                height: 42.0,
                                width: 42.0,
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    //httpHeaders: (),
                                    imageUrl: widget.restaurantImage!,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                  ),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                              ),
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80.0,
                                height: 22.0,
                                child: Marquee(
                                  text: widget.restaurantName!,
                                  velocity: 20,
                                  blankSpace: 20,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  )
                                ),
                              ),
                              if(widget.restaurantSubName != null)
                                Text(widget.restaurantSubName!,
                                  style: Theme.of(context).textTheme.caption
                                )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Divider()
                        ),
                      ),
                      if(widget.desk != null)
                        Text(widget.desk!,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold
                          )
                        )
                    ],
                  )
                ),
              ),
            Spacer(),
            Card(
              color: Colors.white,
              elevation: 1.0,
              margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)
              ),
              child: IconButton(
                splashRadius: 24.0,
                onPressed: (){
                  if(widget.onPressUser != null) widget.onPressUser!();
                  else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPage(this.context, myUserName: "测试名")));
                  }
                },
                padding: EdgeInsets.zero,
                icon: Icon(Icons.person_outline),
                color: Theme.of(context).primaryColor
              )
            )
          ]
        )
    );
  }
}

class StartWidget extends StatefulWidget {
  //final User user;
  final bool isRescan;

  const StartWidget({Key? key, this.isRescan=false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartState();
}

class _StartState extends State<StartWidget>{
  void onPressScan() async{
    var status = await Permission.camera.request();
    if(status.isGranted) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ScanPage())
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.isRescan) onPressScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: DetailAppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 144,
                height: 144,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(72.0)
                  ),
                  elevation: 5.0,
                  child:  InkWell(
                    borderRadius: BorderRadius.circular(72.0),
                    child: Icon(Icons.qr_code_scanner,size: 50,color: Colors.white,),
                    onTap: onPressScan,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("扫码点单",style: Theme.of(context).textTheme.headline6),
              )
            ],
          )
        ),
      )
    );
  }

}