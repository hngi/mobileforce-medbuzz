import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class ForgotPasswordReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: Config.yMargin(context, 10),),
            Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Config.textSize(context, 7.11),
                ),
              ),
            ),
            Divider(
                    height: Config.yMargin(context, 10),  //60
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
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
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
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
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
                    height: Config.yMargin(context, 5.5),
                  ),
                  Container(
                    padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Config.yMargin(context, 1.28))),
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: Config.xMargin(context, 5.33),
                        right: Config.xMargin(context, 6)), //24,24,27
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'Segoe-Bold',
                        fontSize: Config.yMargin(context, 2.06),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      )
    );
  }
}