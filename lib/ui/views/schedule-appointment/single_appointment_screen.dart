import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';

class SingleAppointment extends StatelessWidget {
  final Appointment appointment;
  final appointmentDB = AppointmentData();

  SingleAppointment({this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Config.yMargin(context, 2.6)),
            child: FlatButton.icon(
                onPressed: () async {
                  showDialog(
                      context: context,
                      child: DeleteDialog() //show Confirmation dialog
                      );
                  showSnackBar(context);
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    appointmentDB.deleteAppointment(appointment.dateTime);
                    Navigator.of(context).pop(true);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  appointment.appointmentType,
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: Config.textSize(context, 5.3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: Config.xMargin(context, 44),
                ),
                Image.asset('images/appointment.png'),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: Config.xMargin(context, 5.33),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: Config.textSize(context, 4.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Config.yMargin(context, 0.5)),
                  child: Text(
                    appointment.note,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: Config.textSize(context, 4),
                    ),
                  ),
                ),
                SizedBox(height: Config.yMargin(context, 7)),
                Padding(
                  padding: EdgeInsets.only(top: Config.yMargin(context, 0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Appointment Time',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appointment.date.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Config.textSize(context, 3.6),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Config.yMargin(context, 7)),
              ],
            ),
          ),
          SizedBox(height: Config.yMargin(context, 23)),
          Padding(
            padding: EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Config.yMargin(context, 1.28))),
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: Config.xMargin(context, 5.33),
                    right: Config.xMargin(context, 6)), //24,24,27
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
                    fontSize: Config.textSize(context, 4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
