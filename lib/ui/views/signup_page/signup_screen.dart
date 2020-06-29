import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get Screen size
    Size screenSize = MediaQuery.of(context).size;
    //get Safe area padding
    // EdgeInsets safe = MediaQuery.of(context).viewPadding;

    // print("value = ");
    // print( Config.xMargin(context, 1) );
    // print( Config.yMargin(context, 1) );
    //yMargin constant  = 7.76
    //xMargin constant = 4.5

    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: Config.yMargin(context, 12), //130px
                ),
                Padding(
                  padding: EdgeInsets.only(left: Config.xMargin(context, 5.3)),
                  child: Text('Create An \nAccount',
                      style: TextStyle(
                        fontSize: Config.yMargin(context, 4.12),
                      )),
                ),

                Divider(
                  height: Config.yMargin(context, 8.25), //60
                  color: Theme.of(context).primaryColor,
                  thickness: Config.yMargin(context, 0.64),
                  endIndent: screenSize.width * 0.25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      top: Config.yMargin(context, 1.28)),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Config.textSize(context, 4.9),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      right: Config.xMargin(context, 6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Jay',
                      hintStyle: TextStyle(
                        fontSize: Config.textSize(context, 4.4),
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Config.yMargin(context, 3.5),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      top: Config.yMargin(context, 1.28)),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Config.textSize(context, 4.9),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      right: Config.xMargin(context, 6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'abc@example.com',
                      hintStyle: TextStyle(
                        fontSize: Config.textSize(context, 4.4),
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Config.yMargin(context, 3.5),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      top: Config.yMargin(context, 1.28)),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Config.textSize(context, 4.9),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Config.xMargin(context, 5.3),
                      right: Config.xMargin(context, 6)),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: TextStyle(
                        fontSize: Config.textSize(context, 4.4),
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Config.yMargin(context, 5.0),
                ),
                Container(
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
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: Config.textSize(context, 3.9),
                    ),
                  ),
                ),

                SizedBox(
                  height: Config.yMargin(context, 3.09),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Config.textSize(context, 3.9), //16
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: Config.textSize(context, 3.9), //16
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                      )
                    ],
                  ),
                )

                //xMargin constant: 4.5, yMargin constant7.76
              ],
            ),
          )),
    );
  }
}
