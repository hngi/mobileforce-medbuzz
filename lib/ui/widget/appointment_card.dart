import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final double height;
  final double width;
  const AppointmentCard({Key key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 3),
                vertical: Config.yMargin(context, 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Config.xMargin(context, 6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.more_vert,
                    size: Config.textSize(context, 5),
                  ),
                  onTap: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'July',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 7),
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        Text(
                          'Thurs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 3),
                    ),
                    Container(
                      color: Theme.of(context).primaryColorDark,
                      height: height * 0.07,
                      width: width * 0.001,
                      child: VerticalDivider(),
                    ),
                    SizedBox(width: Config.xMargin(context, 5)),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Timing',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 3.4),
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                    ),
                                    Text(
                                      '6.00 PM',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              Config.textSize(context, 3.8)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: Config.xMargin(context, 9)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Appointment for',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 3.4),
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                    ),
                                    Text(
                                      'Dance Class',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              Config.textSize(context, 3.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                              width: double.infinity,
                              child: Divider(
                                color: Theme.of(context).primaryColorDark,
//indent: 50.0,
                                // endIndent: 10.0,
                              ),
                            ),
                            Container(
                              child: Text(
                                'Make sure to make lots of friends',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 3.8)),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
