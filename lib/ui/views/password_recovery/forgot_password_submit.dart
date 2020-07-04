import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class ForgotPasswordSubmit extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordSubmit> {
  @override
  Widget build(BuildContext context) {
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, RouteNames.login);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(Config.xMargin(context, 7),
                      Config.yMargin(context, 25), 0, 0),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 7.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Config.yMargin(context, 1.2),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, Config.yMargin(context, 3.5),
                      Config.xMargin(context, 40), 0),
                  child: Container(
                    height: height * .008,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(Config.xMargin(context, 5)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Config.yMargin(context, 1),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Config.yMargin(context, 3.6),
                      left: Config.xMargin(context, 5.4),
                      right: Config.xMargin(context, 5.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: Config.textSize(context, 4.9),
                          fontWeight: FontWeight.w500,
                          color: Color(0xff333333),
                        ),
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 0.6),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'abc@example.com',
                          hintStyle: TextStyle(
                            fontSize: Config.textSize(context, 4.4),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 5),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.forgotPasswordReset);
                        },
                        child: Container(
                          height: height * .07,
                          child: Material(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Config.yMargin(context, 1.28)),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Config.textSize(context, 3.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
