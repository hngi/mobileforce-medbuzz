import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

// TODO: In other to stop thunder from firing yolu change the routes before you push
// TODO: Fix the orientation of this page to POTRAIT
// Commented out for presentation purpose

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This is for the switch button
  bool switcher = false;
  bool darkSwitcher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Column(
        //physics: BouncingScrollPhysics(),
        children: <Widget>[
          // SizedBox(
          //   height: Config.xMargin(context, 7),
          // ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Config.xMargin(context, 1)),
            child: Container(
              //height: Config.yMargin(context, 50),
              // color: Colors.blue[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Change Username'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: Config.xMargin(context, 4),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  ListTile(
                    title: Text('Change Fingerprint'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: Config.xMargin(context, 4),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        darkSwitcher = !darkSwitcher;
                      });
                    },
                    title: Text('Dark Mode'),
                    trailing: Switch(
                        activeColor: ThemeData().primaryColor,
                        activeTrackColor: Colors.blueAccent,
                        onChanged: (value) {
                          setState(() {
                            darkSwitcher = value;
                          });
                        },
                        value: darkSwitcher),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        switcher = !switcher;
                      });
                    },
                    title: Text('Do not disturb'),
                    trailing: Switch(
                        activeColor: ThemeData().primaryColor,
                        activeTrackColor: Colors.blueAccent,
                        onChanged: (value) {
                          setState(() {
                            switcher = value;
                          });
                        },
                        value: switcher),
                  ),
                  ListTile(
                    title: Text('Clear all Reminders'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: Config.xMargin(context, 4),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Config.xMargin(context, 9),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                //Code throws error with named routes
                // Navigation().pushToAndReplace(context, LoginPage());
                //this works
                Navigator.of(context).pushReplacementNamed(RouteNames.signup);
              },
              child: Container(
                //height: Config.yMargin(context, 0),
                width: Config.xMargin(context, 30),
                child: Row(
                  children: <Widget>[
                    ImageIcon(
                      AssetImage('images/logout.png'),
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
