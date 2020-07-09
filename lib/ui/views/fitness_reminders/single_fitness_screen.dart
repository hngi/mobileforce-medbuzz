import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/notifications/fitness_notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_names.dart';
import '../../../core/database/fitness_reminder.dart';
import '../../../core/models/fitness_reminder_model/fitness_reminder.dart';

class SingleFitnessScreen extends StatefulWidget {
  final FitnessReminder data;
  SingleFitnessScreen({this.data});
  @override
  _SingleFitnessScreenState createState() => _SingleFitnessScreenState();
}

class _SingleFitnessScreenState extends State<SingleFitnessScreen> {
  Color color;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<FitnessReminderCRUD>(context);
    FitnessNotificationManager fitnessNotificationManager =
        FitnessNotificationManager();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),
//Function to navigate to previous screen
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.fitnessSchedulesScreen);
            }),
      ),
      body: ListView(physics: ScrollPhysics(), children: [
        Container(
          width: Config.xMargin(context, 100),
          height: Config.yMargin(context, 20),
          child: widget.data.fitnesstype == '0'
              ? image('images/cycle.png')
              : widget.data.fitnesstype == '1'
                  ? image('images/sprint.png')
                  : image('images/swim.png'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 20.0,
            bottom: 20.0,
            right: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.name,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: Config.textSize(context, 5.3),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe',
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: color = Color(0xffEB5757),
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe',
                    color: color = Color(0xffEB5757),
                  ),
                ),
                onPressed: () {
                  print(widget.data.id);
                  model.deleteReminder(widget.data.id);
                  fitnessNotificationManager
                      .removeReminder(int.parse(widget.data.id));
                  showDialog(
                    context: context,
                    child: DeleteDialog(),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: Config.textSize(context, 4.5),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 2.0)),
              Text(
                'A quick run from home to the estate junction and back home.',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.normal,
                  fontSize: Config.textSize(context, 4),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 7.0)),
              Text(
                'Frequency',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: Config.textSize(context, 4.5),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 2.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.minsperday.toString() + ' minutes Daily',
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: Config.textSize(context, 4),
                    ),
                  ),
                  Text(
                    widget.data.activityTime[0].toString() +
                        ':' +
                        widget.data.activityTime[1].toString(),
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: Config.textSize(context, 3.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Config.yMargin(context, 7.0)),
              Text(
                'Program',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: Config.textSize(context, 4.5),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 2.0)),
              Text(
                '4 days left out of 30 days',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.normal,
                  fontSize: Config.textSize(context, 4),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 6.0)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Center(
              child: Container(
            height: Config.yMargin(context, 7.0),
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              //function to navigate to screen to edit details goes here
              onPressed: () {
                print(widget.data.id);
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.xMargin(context, 4)),
              ),
            ),
          )),
        ),
      ]),
    );
  }

  image(String image) {
    return Image(
      image: AssetImage(image),
      fit: BoxFit.contain,
    );
  }
}

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.xMargin(context, 4.0)),
      ),
      child: Container(
        height: Config.yMargin(context, 20),
        width: Config.xMargin(context, 150.0),
        //width: Config.xMargin(context, 50),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 23.0, bottom: 20.0),
                child: Text(
                  'Are you sure you want to delete this?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.fitnessSchedulesScreen);
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color: Theme.of(context).hintColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
