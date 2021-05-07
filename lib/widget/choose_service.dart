import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/widget/start.dart';

import 'menu.dart';

class ChooseService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {
  int peopleNumber = 1;
  bool minusAvailable = false;
  bool chosenWaterService = false;
  bool _isLoading = false;

  void nextStep() async {
    //call service
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Menu()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: DetailAppBar(
        restaurantImage: Restaurant.sample()!.restaurantImage,
        restaurantName: Restaurant.sample()!.name,
        restaurantSubName: Restaurant.sample()!.subName,
        desk: "A10",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("请选择用餐人数"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: IconButton(icon: Icon(Icons.remove), onPressed: minusAvailable ? () {
                                  if(peopleNumber > 1) {
                                    setState(() {
                                      peopleNumber -= 1;
                                      if(peopleNumber == 1){
                                        minusAvailable = false;
                                      }
                                    });
                                  }
                                } : null,
                                  constraints: BoxConstraints(),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xffBBBBBB)
                                )
                              ),
                            ),
                          ),
                          Text("$peopleNumber", style: Theme.of(context).textTheme.headline6),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: IconButton(icon: Icon(Icons.add), onPressed: () {
                                  setState(() {
                                    peopleNumber += 1;
                                    minusAvailable = true;
                                  });
                                },
                                  constraints: BoxConstraints(),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xffBBBBBB)
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("服务"),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2.0, color: chosenWaterService ? Colors.black26 : Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              onTap: () { setState(() {
                                chosenWaterService = !chosenWaterService;
                              });},
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.local_cafe_outlined, color: Theme.of(context).primaryColor, size: 35.0,)
                                  ),
                                  Text("倒水")
                                ],
                              ),
                            )
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Spacer(),
                if (_isLoading) Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: SizedBox(
                      height: 28.0,
                      width: 28.0,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                          nextStep();
                        });
                      },
                      child: Text("下一步")
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}