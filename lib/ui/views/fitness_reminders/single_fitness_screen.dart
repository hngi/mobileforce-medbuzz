import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class SingleFitnessScreen extends StatefulWidget {
  @override
  _SingleFitnessScreenState createState() => _SingleFitnessScreenState();
}

class _SingleFitnessScreenState extends State<SingleFitnessScreen> {
  Color color;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),
//Function to navigate to previous screen
            onPressed: () {}),
      ),
      body: ListView(physics: ScrollPhysics(), children: [
        Container(
            width: Config.xMargin(context, 100),
            height: Config.yMargin(context, 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/run.png'),
                fit: BoxFit.fill,
                //borderRadius: BorderRadius.only(bottomRight:  Radius.circular(20)),
              ),
            )),
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
                'Running',
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
                    '30 minute Daily',
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: Config.textSize(context, 4),
                    ),
                  ),
                  Text(
                    '8:00AM',
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
              //function to navigate back to fitness screen after editing details goes here
              onPressed: () {},
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
}
