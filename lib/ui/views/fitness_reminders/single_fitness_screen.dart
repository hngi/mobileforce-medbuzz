import 'package:MedBuzz/ui/views/fitness_reminders/delete_successful.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: color = Color(0xffFAFAFA),
            leading: IconButton(
                icon: Icon(Icons.keyboard_backspace,
                    color: Theme.of(context).primaryColorDark
                ),
//Function to navigate to previous screen
                onPressed: () {}),
          ),
          body: ListView(
              physics: ScrollPhysics(),
            children: [
              Container(
              width: Config.xMargin(context, 100),
                height: Config.yMargin(context, 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/run.png'),
            fit: BoxFit.fill,
                //borderRadius: BorderRadius.only(bottomRight:  Radius.circular(20)),
            ),
            )
            ),
              Padding(
                padding:  EdgeInsets.only( left: 20.0, top: 20.0, bottom: 20.0, right: 20.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Running',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Segoe',
                      ),
                    ),

                    FlatButton.icon(
                      icon: Icon(Icons.delete,
                        color: color= Color(0xffEB5757),
                      ) ,
                      label: Text('Delete',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe',
                          color: color= Color(0xffEB5757),
                        ),
                      ) ,
                        onPressed: () {
                        //pops up the delete function
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    height: Config.yMargin(context, 15),
                                    width: Config.xMargin(context, 150.0),
                                    //width: Config.xMargin(context, 50),
                                    child: Padding(
                                      padding:  EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: 23.0, bottom: 17.0),
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
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => DeleteSuccess()),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  color:  Color(0xFF219653),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          Config.xMargin(context, 2.0))),
                                                ),
                                              ),
                                              Container(
                                                height: Config.yMargin(context, 6.0),
                                                width: Config.xMargin(context, 30.0),
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  color:  Color(0xFFEB5757),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          Config.xMargin(context, 2.0))),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only( left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                        color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                    ),
                    ),
                    SizedBox(height: Config.yMargin(context, 2.0)),
                    Text(
                      'A quick run from home to the estate junction and back home.',
                      style: TextStyle(
                        fontFamily: 'Segoe',
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ),
                    ),

                    SizedBox(height: Config.yMargin(context, 7.0)),

                    Text(
                      'Frequency',
                      style: TextStyle(
                        fontFamily: 'Segoe',
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
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
                            fontSize: 16.0,
                          ),
                        ),

                        Text(
                          '8:00AM',
                          style: TextStyle(
                            fontFamily: 'Segoe',
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
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
                        fontSize: 16.0,
                      ),
                    ),

                    SizedBox(height: Config.yMargin(context, 2.0)),
                    Text(
                      '4 days left out of 30 days',
                      style: TextStyle(
                        fontFamily: 'Segoe',
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ),
                    ),

                    SizedBox(height: Config.yMargin(context, 6.0)),


                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only( left: 24.0, right: 24.0),
                child: Center(
                    child: Container(
                      height: Config.yMargin(context, 7.0),
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        //function to navigate back to fitness screen after editing details goes here
                        onPressed: () {},
                        child: Text(
                          'Edit',style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Config.xMargin(context, 4.0))),
                      ),
                    )),
              ),
            ]
          ),
        ));
  }
}
