import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class ForgotPasswordMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Config.xMargin(context, 1));
    print(Config.yMargin(context, 1));
    print(Config.textSize(context, 1));

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(Config.xMargin(context, 7),
                  Config.yMargin(context, 25), 0, 0),
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: Config.textSize(context, 7.8),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 1.2),
            ),
            Divider(
              height: Config.yMargin(context, 8.25),
              color: Theme.of(context).primaryColor,
              thickness: Config.yMargin(context, 0.64),
              endIndent: screenSize.width * 0.36,
            ),
            SizedBox(
              height: Config.yMargin(context, 3.6),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 5.4),
              ),
              child: Text(
                'A link has been sent to your mail, click to reset your password.',
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: Config.textSize(context, 4),
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 8.19),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 7.3),
              ),
              height: Config.yMargin(context, 7.2),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Config.yMargin(context, 1.28)),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Mail',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: Config.textSize(context, 3.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // When this button is pressed, it sends mail to user
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
