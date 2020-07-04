import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class ForgotPasswordReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        'Reset Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Config.textSize(context, 7.8),
                        ),
                      ),
                    ),
                    Divider(
                      height: Config.yMargin(context, 10), //60
                      color: Theme.of(context).primaryColor,
                      thickness: Config.yMargin(context, 0.64),
                      endIndent: MediaQuery.of(context).size.width * 0.3,
                    ),
                    //SizedBox(height: Config.yMargin(context, 3.5),),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Config.xMargin(context, 5.3),
                          top: Config.yMargin(context, 1.28)),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Config.textSize(context, 4.9),
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Config.xMargin(context, 5.3),
                          right: Config.xMargin(context, 6)),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: '••••••••'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Config.xMargin(context, 5.3),
                          top: Config.yMargin(context, 1.28)),
                      child: Text(
                        'Re-type password',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Config.textSize(context, 4.9),
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Config.xMargin(context, 5.3),
                          right: Config.xMargin(context, 6)),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: '••••••••'),
                      ),
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 5),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.forgotPasswordMail);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Config.yMargin(context, 1.28)),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: Config.xMargin(context, 5.33),
                          right: Config.xMargin(context, 6),
                        ), //24,24,27
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3.9),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
