import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/diet_reminders/diet_reminders_model.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleDietReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<DietReminderModel>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        //Extracted appBar to widgets folder
        appBar: appBar(
            context: context, title: 'Add diet', useDefaultActions: true),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Theme.of(context).backgroundColor,
                width: width,
                padding: EdgeInsets.fromLTRB(
                    Config.xMargin(context, 5),
                    Config.yMargin(context, 1),
                    Config.xMargin(context, 5),
                    Config.yMargin(context, 5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: false, icon: Icon(Icons.expand_more),
                        // here sets the value to the selected month and if null, it defaults to the present date month from DateTime.now()
                        value: model.currentMonth,
                        hint: Text('Month',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.textSize(context, 4.8),
                                color: Theme.of(context).hintColor)),
                        items: model.months
                            .map((month) => DropdownMenuItem(
                                  child: Container(
                                    child: Text(
                                      month,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              Config.textSize(context, 4.8),
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  value: month,
                                ))
                            .toList(),
                        onChanged: (val) => model.updateSelectedMonth(val),
                      ),
                    ),
                    SizedBox(height: Config.yMargin(context, 3)),
                    Container(
                        height: Config.yMargin(context, 15),
                        child: ScrollableCalendar(model: model)),
                    SizedBox(height: Config.yMargin(context, 1.8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Time',
                            style: TextStyle(
                                fontSize: Config.textSize(context, 4.8),
                                color: Theme.of(context).hintColor))
                      ],
                    ),
                    SizedBox(height: Config.yMargin(context, 2.5)),
                    TimeWheel(
                      updateTimeChanged: (val) => model.updateSelectedTime(val),
                    ),
                    SizedBox(height: Config.yMargin(context, 5)),
                    Container(
                      alignment: Alignment.center,
                      height: height * .65,
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.foodClass.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            var foodClass = model.foodClass[index];
                            return InkWell(
                              //Function to update the color of selected food class
                              onTap: () {
                                model.updateSelectedFoodClass(foodClass.name);
                              },
                              child: FoodCard(
                                isSelected:
                                    model.isFoodClassActive(foodClass.name),
                                foodClass: foodClass,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: Config.yMargin(context, 5)),
                    Container(
                      width: width,
                      height: Config.yMargin(context, 8),
                      child: FlatButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  Config.xMargin(context, 3))),

                          //Functions to save reminder to db and schedule notification goes here

                          onPressed: () {},
                          child: Text('Save',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 6),
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorLight))),
                    )
                  ],
                ),
              )),
        ));
  }
}

///Custom FoodCard widget to keep things modular
class FoodCard extends StatelessWidget {
  final FoodClass foodClass;
  final bool isSelected;

  const FoodCard({Key key, this.foodClass, this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: Config.xMargin(context, 3),
          right: Config.xMargin(context, 3),
          bottom: Config.yMargin(context, 2)),
      child: Container(
        alignment: Alignment.center,
        width: width * .45,
        height: height * .3,
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).highlightColor.withOpacity(.5)
                : Theme.of(context).primaryColorLight,
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1, 1),
                  color: Theme.of(context).primaryColorDark.withOpacity(.3),
                  blurRadius: 5,
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(foodClass.image),
            Text(foodClass.name,
                style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).hintColor,
                    fontSize: Config.textSize(context, 4.8)))
          ],
        ),
      ),
    );
  }
}
