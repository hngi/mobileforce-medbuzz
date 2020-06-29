import 'package:MedBuzz/ui/navigation/app_navigation/app_transition.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/login_page/login_page_screen.dart';
import 'package:flutter/material.dart';


// TODO: In other to stop thunder from firing yolu change the routes before you push
// TODO: Fix the orientation of this page to POTRAIT

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This is for the switch button
  bool switcher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  // offset: Offset(-10.0, 10.0)
                  spreadRadius: 2.0,
                  blurRadius: 10.0,
                )
              ], borderRadius: BorderRadius.circular(30), color: Colors.white),
              height: Config.yMargin(context, 36),
              width: Config.xMargin(context, 100),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Juliana Orji',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('julianamonday@gmail.com',
                      style: TextStyle(fontSize: 18))
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: Config.yMargin(context, 60),
              // color: Colors.blue[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Profile Information'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ),
                  ListTile(
                    title: Text('Payment Details'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ),
                  ListTile(
                    title: Text('Subscription Plan'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ),
                  ListTile(
                    title: Text('Reminder History'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        switcher = !switcher;
                      });
                    },
                    title: Text('App Notification'),
                    trailing: Switch(
                        activeColor: ThemeData().primaryColor,
                        activeTrackColor: Colors.blueAccent,
                        onChanged: (value) {
                          setState(() {
                            value = switcher;
                          });
                        },
                        value: switcher),
                  ),
                  ListTile(
                    title: Text('Settings'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 90.0, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigation().pushToAndReplace(context, LoginPage());
                },
                child: Container(
                  height: Config.yMargin(context, 12),
                  width: Config.xMargin(context, 30),
                  child: Row(
                    children: <Widget>[
                      ImageIcon(AssetImage('images/logout.png'), color: Colors.red,),
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
            ),
          )
        ],
      ),
    );
  }
}



