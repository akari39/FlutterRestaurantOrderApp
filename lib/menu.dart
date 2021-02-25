import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/dish_detail.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/start.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'model/dish.dart';

class _LeftColumn extends StatefulWidget {
  final int selectedColumn;
  final Function onClickColumnItem;
  final Map<String,String> dishTypes;

  const _LeftColumn({Key key, this.onClickColumnItem, this.selectedColumn, this.dishTypes}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LeftColumnState();

}

class _LeftColumnState extends State<_LeftColumn>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.dishTypes.length,
      itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: widget.selectedColumn != index ? Colors.black26 : Theme.of(context).primaryColor
          )
        ),
        color: widget.selectedColumn != index ? Colors.white : Theme.of(context).primaryColor,
        elevation: widget.selectedColumn == index ? 5 : 0,
        child: Container(
          width: 80,
          height: 80,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () { widget.onClickColumnItem(index); },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CachedNetworkImage(imageUrl: widget.dishTypes.values.elementAt(index),
                    fit: BoxFit.fill,
                    height: 35,
                    width: 35,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline)),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                      child: Text(widget.dishTypes.keys.elementAt(index),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontWeight: widget.selectedColumn == index ? FontWeight.bold : FontWeight.normal, fontSize: 12),
                    )
                  ),
                )
              ],
            ),
          ),
        )
      );
    });
  }

}

class _RightColumn extends StatefulWidget {
  final List<Dish> dishList;
  final List<Choice> chosenList;
  final Function onRemove;
  final Function onAdd;

  const _RightColumn({Key key, this.dishList, this.onAdd, this.chosenList, this.onRemove}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RightColumnState();
}

class _RightColumnState extends State<_RightColumn>{
  DishDetail dishDetail;

  pushDetail(Dish dish, Choice choice) {
    showBarModalBottomSheet(duration: Duration(milliseconds: 250), context: context, builder: (context) {
      return DishDetail(
        dish: dish,
        choice: choice,
        onAdd: widget.onAdd,
        onRemove: widget.onRemove,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dishList.length == 0) return
      Container(alignment: Alignment.center,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, size: 54, color: Colors.black54,),
            ),
            Text("没有找到结果", style: TextStyle(color: Colors.black54)),
        ],
      )
    );
    else return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.dishList.length,
      itemBuilder: (context,index) {
        return Container(
          constraints: BoxConstraints(
            minWidth: 280
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {pushDetail(widget.dishList[index], Choice.getSingleChoice(widget.chosenList, widget.dishList[index]));},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CachedNetworkImage(width:70, height: 70,
                                    imageUrl: widget.dishList[index].image,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.dishList[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "¥${widget.dishList[index].getPriceString(Dish.intPrice)}.",
                                                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                                    ),
                                                    TextSpan(
                                                        text: "${widget.dishList[index].getPriceString(Dish.decimalPrice)}",
                                                        style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor)
                                                    )
                                                  ]
                                              )
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 105
                                              ),
                                              child: Text(widget.dishList[index].description, style: Theme.of(context).textTheme.caption)
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text("库存${ widget.dishList[index].stock != null ? widget.dishList[index].stock :
                                              "最多 " + widget.dishList[index].getChildDishesMaxStock().toString() }",
                                                  style: TextStyle(color: Colors.black54, fontSize: 12)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Choice.isInChosenList(widget.chosenList, widget.dishList[index]) && widget.dishList[index].childTypes == null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.remove_circle_outline, size: 24, color: int.parse(widget.dishList[index].stock) > 0 ? Theme.of(context).primaryColor : Colors.black26),
                                          onPressed: int.parse(widget.dishList[index].stock) > 0 ? () {widget.onRemove(widget.dishList[index]);} : null,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints()),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                          child: Text("${Choice.getSingleChoice(widget.chosenList, widget.dishList[index]).count}", style: TextStyle(fontSize: 17))
                                      ),
                                      IconButton(icon: Icon(Icons.add_circle_outline, size: 24, color: Choice.isChosenInStock(widget.chosenList, widget.dishList[index]) ? Theme.of(context).primaryColor : Colors.black26),
                                          onPressed:
                                              Choice.isChosenInStock(widget.chosenList, widget.dishList[index]) ?
                                              () { widget.onAdd(widget.dishList[index]); } : null,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints()),
                                    ]
                                  ),
                                )
                                : InkWell(
                                      borderRadius: BorderRadius.circular(10.0),
                                      onTap: widget.dishList[index].stock != null ?
                                        int.parse(widget.dishList[index].stock) > 0 ? () { widget.onAdd(widget.dishList[index]); } : null :
                                          () { pushDetail(widget.dishList[index],Choice.getSingleChoice(widget.chosenList, widget.dishList[index])); },
                                      child: (widget.dishList[index].stock != null ?
                                        int.parse(widget.dishList[index].stock) > 0 : widget.dishList[index].getChildDishesMaxStock() > 0) ?
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(children: [
                                          Icon(widget.dishList[index].stock != null ?
                                              Icons.add_circle_outline:
                                              Icons.library_add_check_outlined,
                                              size: 24,
                                              color: Theme.of(context).primaryColor
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(widget.dishList[index].stock != null ? "添加" : "选择",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor
                                              ),
                                            ),
                                          )
                                        ]),
                                      ) :
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(children: [
                                          Icon(Icons.add_circle_outline, size: 20,
                                              color: Colors.black26),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("缺货",style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26
                                            ),
                                            ),
                                          )
                                        ]),
                                      )
                                  )
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if(index != widget.dishList.length - 1)
                Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Divider(height: 0.5)
                ) else
                Container(height: 80)
            ],
          )
        );
      });
  }
}

class _ServiceIcon extends StatelessWidget {
  final String service;

  _ServiceIcon({this.service});

  @override
  Widget build(BuildContext context) {
    switch(service) {
      case "倒茶": return Icon(Icons.local_cafe_outlined, color: Theme.of(context).primaryColor, size: 24.0); break;
      case "换盘": return Icon(Icons.dinner_dining, color: Theme.of(context).primaryColor, size: 24.0);
      case "招呼服务员": return Icon(Icons.room_service_outlined, color: Theme.of(context).primaryColor, size: 24.0);
      default: return Icon(Icons.assistant_outlined, color: Theme.of(context).primaryColor, size: 24.0);
    }
  }
}



class _CartOverlay extends StatefulWidget {
  final OverlayEntry overlayEntry;

  const _CartOverlay({Key key, this.overlayEntry}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartOverlayState();

}

class _CartOverlayState extends State<_CartOverlay>{
  @override initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  _showOverlay() {
    Overlay.of(context).insert(widget.overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _MenuBody extends StatefulWidget {
  final List<String> availableServices;
  final Map<String, String> dishTypes;
  final List<Dish> dishes;

  _MenuBody({this.availableServices, this.dishes, this.dishTypes});

  @override
  State<StatefulWidget> createState() => _MenuBodyState();

}

class _MenuBodyState extends State<_MenuBody> {
  String _searchText = "";
  TextEditingController _textEditingController = TextEditingController();

  int selectedColumn = 0;
  int latestSelectedColumn;
  List<Dish> selectedColumnDishes;
  List<Choice> choices = [];
  double totalPrice = 0.0;

  OverlayEntry overlayEntry;

  @override void initState() {
    super.initState();
    selectedColumnDishes = widget.dishes.where((element) => element.dishTypes ==
        widget.dishTypes.keys.toList()[selectedColumn])
        .toList();
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _Cart(cartItemsCount: "${choices.length != 0 ? (choices.fold(0, (previousValue, element) => previousValue + element.price)).toInt() : 0}", totalPrice: totalPrice.toStringAsFixed(2),
              onClickCartIcon: () {},
              onClickPlaceOrder: () {}
          ),
        ),
      );
    });
  }

  void _search(val) {
    setState(() {
      selectedColumn = null;
      _searchText = val;
      if(val == "") {
        selectedColumn = latestSelectedColumn;
        selectedColumnDishes = widget.dishes.where((element) => element.dishTypes == widget.dishTypes.keys.toList()[selectedColumn]).toList();
      } else {selectedColumnDishes = widget.dishes.where((element) => element.name.contains(val) || element.description.contains(val) || element.dishTypes.contains(val)).toList();};
    });
  }

  void calculatePrice() {
    totalPrice = 0.0;
    setState(() {
      choices.forEach((element) {
        element.price = double.parse((element.childDish == null) ? element.dish.price : element.childDish.price) * element.count;
        totalPrice += element.price;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CartOverlay(overlayEntry: overlayEntry),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SizedBox(
            height: 58,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.availableServices.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _ServiceIcon(service: widget.availableServices[index]),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(widget.availableServices[index], style: TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
          child: Container(
            height: 50,
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.search),
                  hintText: "搜索菜单",
                  contentPadding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  suffixIcon: _searchText != "" ?
                  InkWell(
                    child: Icon(Icons.clear), onTap: () {
                    FocusScope.of(context).unfocus();
                      setState(() {
                        _textEditingController.clear();
                        _searchText = "";
                        selectedColumn = latestSelectedColumn;
                        selectedColumnDishes = widget.dishes.where((element) => element.dishTypes == widget.dishTypes.keys.toList()[selectedColumn]).toList();
                      });
                    },
                    borderRadius: BorderRadius.circular(30.0)
                  ) : null
              ),
              onTap: () {
                latestSelectedColumn = selectedColumn;
              },
              onSubmitted: (val) {
                _search(val);
              },
              onChanged: (val) {
                _search(val);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 80
                ),
                child: _LeftColumn(dishTypes: widget.dishTypes,
                  selectedColumn: selectedColumn,
                  onClickColumnItem: (index) {
                    setState(() {
                      selectedColumn = index;
                      selectedColumnDishes = widget.dishes.where((element) => element.dishTypes == widget.dishTypes.keys.toList()[selectedColumn]).toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: _RightColumn(
                    dishList: selectedColumnDishes,
                    onAdd: <T extends DishInfo> (T dish) {
                      if (!Choice.isInChosenList(choices, dish)) {
                        setState(() {
                          choices.add(dish is Dish ? Choice(dish: dish, count: 1) : Choice(childDish: dish as ChildDish, count: 1));
                          overlayEntry.markNeedsBuild();
                        });
                      } else {
                        setState(() {
                          Choice.getSingleChoice(choices, dish).count++;
                          overlayEntry.markNeedsBuild();
                        });
                      }
                      setState(() {
                        calculatePrice();
                      });
                    },
                    onRemove: <T extends DishInfo> (T dish)  {
                      if(!Choice.isInChosenList(choices, dish)) return;
                      var choice = Choice.getSingleChoice(choices, dish);
                      if(choice.count <= 1) {
                        setState(() {
                          choices.remove(choice);
                          overlayEntry.markNeedsBuild();
                        });
                      } else {
                        setState(() {
                          choice.count --;
                          overlayEntry.markNeedsBuild();
                        });
                      }
                      setState(() {
                        calculatePrice();
                        overlayEntry.markNeedsBuild();
                      });
                    },
                    chosenList: choices
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Cart extends StatefulWidget {
  final String cartItemsCount;
  final String totalPrice;
  final Function onClickCartIcon;
  final Function onClickPlaceOrder;

  const _Cart({Key key, this.totalPrice, this.onClickCartIcon, this.onClickPlaceOrder, this.cartItemsCount}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _CartState();
  
}

class _CartState extends State<_Cart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color(0xffF2F2F2),
          child: Container(height: 44, width: MediaQuery.of(context).size.width-32,),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, bottom: 10.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width-32
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Stack(
                    children: [
                      GestureDetector(child: Icon(Icons.shopping_cart_outlined, color: Colors.black54, size: 42,), onTap: widget.onClickCartIcon),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle
                          ),
                          child: Text(widget.cartItemsCount, style:
                          TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0, color: Theme.of(context).accentColor, decoration: TextDecoration.none
                          ))
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "¥${widget.totalPrice.split(".")[0]}.",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                        ),
                        TextSpan(
                            text: "${widget.totalPrice.split(".")[1]}",
                            style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                        )
                      ]
                    )
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.onClickPlaceOrder,
                  child: Text("下单")
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Menu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        restaurantName: Restaurant.sample().name,
        restaurantImage: Restaurant.sample().restaurantImage,
        restaurantSubName: Restaurant.sample().subName,
        desk: "A10"
      ),
      body: GestureDetector(
          onTap: () { FocusScope.of(context).unfocus(); },
          behavior: HitTestBehavior.translucent,
          child: _MenuBody(availableServices: Restaurant.sample().services,
            dishes:[Dish.sample(),Dish.sample2()],
            dishTypes: Restaurant.sample().dishTypes,
          ),
      ),
      extendBody: true,
    );
  }
}