import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/dish.dart';

class CartList extends StatefulWidget {
  final List<Choice>? choices;
  final List<Dish>? dishes;
  final Function? onAdd;
  final Function? onRemove;

  const CartList({Key? key, this.choices, this.onAdd, this.onRemove, this.dishes}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartListState();
}

class _CartListState extends State<CartList>{

  @override
  Widget build(BuildContext context) {
    if(widget.choices!.isEmpty) return Container(alignment:Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 54, color: Theme.of(context).accentColor,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("购物车是空的", style: TextStyle(color: Theme.of(context).accentColor),),
            )
          ],
        )
    );
    else return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(color: Theme.of(context).primaryColor, height: 5.0),
        Padding(padding: EdgeInsets.all(16.0),child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("购物车", style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        )),
        Expanded(
          child: ListView.builder(
              itemCount: widget.choices!.length,itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    width: 80,
                    height: 80,
                    imageUrl: widget.choices![index].dish != null ? widget.choices![index].dish!.image! :
                    widget.dishes!.where((element) =>
                    element.childTypes != null ? element.childTypes!.contains(widget.choices![index].childDish) : false).toList()[0].image!,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline)
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.choices![index].childDish == null ? widget.choices![index].dish!.name! : widget.choices![index].childDish!.parentName!,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          if(widget.choices![index].childDish != null)
                            Text(widget.choices![index].childDish!.name!,
                            style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "¥${widget.choices![index].price!.toStringAsFixed(2).split(".")[0]}.",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                  ),
                                  TextSpan(
                                      text: "${widget.choices![index].price!.toStringAsFixed(2).split(".")[1]}",
                                      style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                                  )
                                ]
                              )
                            ),
                            Text("¥${widget.choices![index].dish != null ?
                            widget.choices![index].dish!.price : widget.choices![index].childDish!.price}",
                                style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor)),
                            Text("${widget.choices![index].count}份",style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor))
                          ]
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(icon: Icon(Icons.remove_circle_outline, size: 24, color: int.parse(widget.choices![index].dishOfChoice.stock) > 0 ? Theme.of(context).primaryColor : Colors.black26),
                                onPressed: int.parse(widget.choices![index].dishOfChoice.stock) > 0 ?
                                    () {widget.onRemove!(widget.choices![index]);} : null,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints()),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                child: Text("${widget.choices![index].count}", style: TextStyle(fontSize: 17))
                              ),
                              IconButton(icon: Icon(Icons.add_circle_outline, size: 24, color: int.parse(widget.choices![index].dishOfChoice.stock) > widget.choices![index].count! ? Theme.of(context).primaryColor : Colors.black26),
                                onPressed:
                                int.parse(widget.choices![index].dishOfChoice.stock) > widget.choices![index].count! ?
                                    () { widget.onAdd!(widget.choices![index]); } : null,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints()),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(index != widget.choices!.length-1) Divider()
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

}