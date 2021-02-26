import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/dish.dart';

class DishDetail extends StatefulWidget {
  final Dish dish;
  final List<Choice> choices;

  final Function onAdd;
  final Function onRemove;

  final Function setStateCallback;

  const DishDetail({Key key, this.dish, this.choices, this.onAdd, this.onRemove, this.setStateCallback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DishDetailState();
}

class DishDetailState extends State<DishDetail>{
  int choiceType = 0;
  Map<int,Choice> choices = new Map<int,Choice>();

  generateTags() {
    List<ChoiceChip> choiceChips = [];
    widget.dish.childTypes.forEach((element) {
      choiceChips.add(ChoiceChip(
          label: Text(element.name),
          selected: widget.dish.childTypes[choiceType] == element,
          onSelected: (bool) {
            setState(() {
              if(bool)
                choiceType = widget.dish.childTypes.indexOf(element);
            });
          }
      ));
    });
    return choiceChips;
  }

  void copyChoices(){
    choices = new Map<int,Choice>();
    List<Choice> copyChoices = [];
    if(widget.choices == null) return;
    else if (choices.containsKey(choiceType)) if(choices[choiceType].count <= 0) choices.remove(choiceType);
    setState(() {
      for(int i=0;i<widget.choices.length;i++){
        copyChoices.add(Choice.clone(widget.choices[i]));
      }

      for(int i=0;i<copyChoices.length;i++){
        choices[widget.dish.childTypes.indexOf(copyChoices[i].childDish)] = copyChoices[i];
      }
    });
  }

  @override void initState() {
    super.initState();
    copyChoices();
    widget.setStateCallback((){copyChoices();});
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
                                          text: "¥${widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType].price.split(".")[0] : widget.dish.getPriceString(Dish.intPrice)}.",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                      ),
                                      TextSpan(
                                          text: "${widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType].price.split(".")[1] : widget.dish.getPriceString(Dish.decimalPrice)}",
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
                          if(!choices.containsKey(choiceType))
                            SizedBox(
                              height: 32,
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                style: ElevatedButton.styleFrom(elevation: 0),
                                onPressed: () {
                                  setState(() {
                                    widget.onAdd(widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType] : widget.dish);
                                    widget.dish.cpType == Dish.multiType ? choices[choiceType] = Choice(childDish: widget.dish.childTypes[choiceType],count: 1) : choices[choiceType] = Choice(dish: widget.dish,count: 1);
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
                                            choices[choiceType].count--;
                                            if (choices[choiceType].count <= 0) choices.remove(choiceType);
                                          });
                                  } : null,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints()),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                      child: Text("${choices[choiceType].count}")
                                  ),
                                  IconButton(icon: Icon(Icons.add_circle_outline, size: 22, color:
                                  (widget.dish.cpType == Dish.singleType ? choices[choiceType].count < int.parse(widget.dish.stock) : choices[choiceType].count < int.parse(widget.dish.childTypes[choiceType].stock)) ?
                                  Theme.of(context).primaryColor : Colors.black26),
                                      onPressed:
                                      choices[choiceType].count < (widget.dish.cpType == Dish.singleType ? int.parse(widget.dish.stock) : int.parse(widget.dish.childTypes[choiceType].stock)) ?
                                          () {widget.onAdd(widget.dish.cpType == Dish.multiType ? widget.dish.childTypes[choiceType] : widget.dish);
                                          setState(() {
                                            choices[choiceType].count ++;
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
            height: 100,
          )
        ],
      )
    );
  }

}