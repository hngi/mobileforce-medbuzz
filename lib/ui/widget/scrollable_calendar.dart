import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//Heavily inspired by Gideon!!!!!

///This widget offers a scrollable calendar with scroll effects
///Big ups to Gideon
///The constructor takes a model that can be customized
///although the calendar could and should have it's own model
///but that one no be today
class ScrollableCalendar extends StatelessWidget {
  final bool hideDivider;
  final model;
  final ItemScrollController _scrollController = ItemScrollController();

  ScrollableCalendar({Key key, @required this.model, this.hideDivider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //without specifying this height, flutter throws an error because of the grid
            height: height * 0.095,
            child: ScrollablePositionedList.builder(
              physics: BouncingScrollPhysics(),
              //sets default selected day to the index of Date.now() date
              initialScrollIndex: model.selectedDay - 1,
              itemScrollController: _scrollController,
              //dynamically sets the itemCount to the number of days in the currently selected month
              itemCount: model.daysInMonth,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String time = (index + 1).toString();
                return GestureDetector(
                  onTap: () {
                    //Logic to prevent user from clicking on past date
                    //Not tested
                    // if (index >= model.currentDay) {
                    //   model.updateSelectedDay(index);
                    //   _scrollController.scrollTo(
                    //     index: index,
                    //     duration: Duration(seconds: 1),
                    //   );
                    // } else {
                    //   _scrollController.scrollTo(
                    //     index: model.currentDay - 1,
                    //     duration: Duration(seconds: 1),
                    //   );
                    // }
                    model.updateSelectedDay(index);
                    _scrollController.scrollTo(
                      index: index,
                      duration: Duration(seconds: 1),
                    );
                  },
                  child: Container(
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      //color: model.getButtonColor(context, index),
                      borderRadius: BorderRadius.circular(height * 0.04),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: Config.xMargin(context, 2)),
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: Config.xMargin(context, 4.5)),
                    child: Stack(fit: StackFit.expand, children: [
                      //Divider that will show which date is tapped
                      Positioned(
                        top: height * .5,
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 2,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              time.length > 1 ? time : '0$time',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: Config.textSize(context, 7.2),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: Config.yMargin(context, .5)),
                            Text(model.getWeekDay(index),
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                  color: Theme.of(context).hintColor,
                                  fontSize: Config.textSize(context, 4.2),
                                  //fontWeight: FontWeight.w500
                                )),
                            index + 1 == model.selectedDay
                                ? Divider(
                                    endIndent: Config.xMargin(context, 11),
                                    color: Theme.of(context).primaryColor,
                                    thickness: 2,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
          hideDivider
              ? Container()
              : Divider(
                  color: Theme.of(context).hintColor.withOpacity(.1),
                  thickness: 3,
                ),
        ],
      ),
    );
  }
}
