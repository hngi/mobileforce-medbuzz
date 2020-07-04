import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class MedicationCard extends StatefulWidget {
  final double height;
  final double width;
  MedicationCard({this.height, this.width});
  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Navigate to screen with single reminder i.e the on user clicked on
      onTap: () {
        setState(() => isSelected = !isSelected);
      },

      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "8:00 AM",
            ),
            SizedBox(height: widget.height * 0.02),
            Container(
                width: widget.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 3),
                    vertical: Config.yMargin(context, 1)),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 5)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColorLight,
                      spreadRadius: Config.xMargin(context, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "images/injection.png",
//                            color: Theme.of(context).primaryColorLight,
                          width: widget.width * 0.2,
                          height: widget.height * 0.1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Chloroquine Injection',
                              style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: widget.height * 0.005),
                            Text(
                              '1 shots once daily',
                              style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 1),
                      width: double.infinity,
                    ),
                    Divider(
                      color: Theme.of(context).primaryColorLight,
                      height: widget.height * 0.02,
//indent: 50.0,
                      // endIndent: 10.0,
                    ),
                    Visibility(
                      visible: isSelected,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteNames.medicationView);
                            },
                            child: Text(
                              'View',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark),
                            ),
                          ),
                          FlatButton(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.close,
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  size: Config.textSize(context, 3),
                                ),
                                SizedBox(
                                  width: Config.xMargin(context, 2),
                                ),
                                Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.done,
                                  color: isSelected
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark,
                                  size: Config.textSize(context, 3),
                                ),
                                SizedBox(
                                  width: Config.xMargin(context, 2),
                                ),
                                Text(
                                  'Done',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ]),
    );
  }
}
