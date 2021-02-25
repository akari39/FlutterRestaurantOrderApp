import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'model/dish.dart';

class DishDetail extends StatefulWidget {
  final Dish dish;
  final Choice choice;

  final Function onAdd;
  final Function onRemove;

  const DishDetail({Key key, this.dish, this.choice, this.onAdd, this.onRemove}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DishDetailState();
}

class DishDetailState extends State<DishDetail>{
  int choiceType = 0;
  Choice choice;

  generateTags() {
    return widget.dish.childTypes.map( (tag) =>
        ChoiceChip(
          label: Text(widget.dish.childTypes[choiceType].name),
          selected: widget.dish.childTypes[choiceType] == tag,
          onSelected: (bool) {
            if(bool)
              choiceType = widget.dish.childTypes.indexOf(tag);
          }
        )
    ).toList();
  }

  @override void initState() {
    super.initState();
    choice = widget.choice;
  }

  void calculatePrice(){
    choice.price = double.parse((widget.dish.childTypes == null) ? widget.dish.price : widget.dish.childTypes[choiceType].price) * choice.count;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: widget.dish.image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.dish.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(widget.dish.description, style: TextStyle(fontSize: 14))
                                )
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minWidth: 90
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "¥${widget.dish.cpType == Dish.singleType ? widget.dish.price.split(".")[0] : widget.dish.getPriceString(Dish.intPrice)}.",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                      ),
                                      TextSpan(
                                          text: "${widget.dish.cpType == Dish.singleType ? widget.dish.price.split(".")[1] : widget.dish.getPriceString(Dish.decimalPrice)}",
                                          style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                                      )
                                    ]
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text("库存${widget.dish.cpType == Dish.singleType ? widget.dish.stock:widget.dish.childTypes[choiceType].stock}",style: TextStyle(color: Colors.black54, fontSize: 14)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      if (widget.dish.cpType == Dish.multiType)
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: generateTags(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(choice == null)
                            SizedBox(
                              height: 32,
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                style: ElevatedButton.styleFrom(elevation: 0),
                                onPressed: () {
                                    setState(() {
                                      widget.onAdd(widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType] : widget.dish);
                                      widget.dish.cpType == Dish.multiType ? choice = Choice(childDish: widget.dish.childTypes[choiceType],count: 1) : choice = Choice(dish: widget.dish,count: 1);
                                      calculatePrice();
                                    });
                                  },
                                label: Text("添加")
                              ),
                            )
                          else Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                                children: [
                                  IconButton(icon: Icon(Icons.remove_circle_outline, size: 22, color:
                                  (widget.dish.cpType == Dish.singleType ? int.parse(widget.dish.stock) > 0 : int.parse(widget.dish.childTypes[choiceType].stock) > 0) ?
                                  Theme.of(context).primaryColor : Colors.black26),
                                      onPressed: (widget.dish.cpType == Dish.singleType ? int.parse(widget.dish.stock) > 0 : int.parse(widget.dish.childTypes[choiceType].stock) > 0) ?
                                          () {widget.onRemove(widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType] : widget.dish);
                                          setState(() {
                                            if (choice.count <= 1) choice = null;
                                            else { choice.count--; calculatePrice(); }
                                          });;
                                  } : null,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints()),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                      child: Text("${choice.count}")
                                  ),
                                  IconButton(icon: Icon(Icons.add_circle_outline, size: 22, color:
                                  (widget.dish.cpType == Dish.singleType ? choice.count < int.parse(widget.dish.stock) : choice.count < int.parse(widget.dish.childTypes[choiceType].stock)) ?
                                  Theme.of(context).primaryColor : Colors.black26),
                                      onPressed:
                                      choice.count < int.parse(widget.dish.stock) ?
                                          () {widget.onAdd(widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType] : widget.dish);
                                          setState(() {
                                            choice.count ++;
                                            calculatePrice();
                                          });
                                  } : null,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints()),
                                ]),
                          )
                        ],
                      )
                    ],
                  )
              )
            )
          ),
          Container(
            height: 80,
          )
        ],
      )
    );
  }

}