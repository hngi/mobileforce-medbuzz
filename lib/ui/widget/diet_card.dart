import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietCard extends StatefulWidget {
  final double width;
  final double height;
  final DietModel diet;
  DietCard({
    Key key,
    this.width,
    this.height,
    this.diet,
  }) : super(key: key);

  @override
  _DietCardState createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Config.xMargin(context, 3),
          vertical: Config.yMargin(context, 1)),
//              height: Config.yMargin(context, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
//blurRadius: 2,
//offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '6:00PM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Config.textSize(context, 3),
                  color: Theme.of(context).hintColor,
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.more_vert,
                  size: Config.textSize(context, 5),
                ),
                onTap: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MMMMM').format(widget.diet.startDate),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Config.textSize(context, 3),
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Text(
                      widget.diet.startDate.day.toString(),
                      style: TextStyle(
                        fontSize: Config.textSize(context, 7),
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                    Text(
                      DateFormat('EEE').format(widget.diet.startDate),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Config.textSize(context, 3),
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Config.xMargin(context, 3),
              ),
              Container(
                color: Theme.of(context).primaryColorDark,
                height: widget.height * 0.07,
                width: widget.width * 0.001,
                child: VerticalDivider(
                  indent: 25.0,
                  endIndent: 25.0,
                ),
              ),
              SizedBox(
                width: Config.xMargin(context, 5),
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.diet.description),
                      SizedBox(
                        height: Config.yMargin(context, 1),
                        width: double.infinity,
                      ),
                      Divider(
                        color: Theme.of(context).primaryColorDark,
                        height: widget.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            child: Text('Skip'),
                            onPressed: () {},
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.done),
                                SizedBox(
                                  width: Config.xMargin(context, 0.5),
                                ),
                                Text(
                                  'Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
