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
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(
          top: Config.yMargin(context, 15.94),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: Config.textSize(context, 7.77),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 6.44),
            ),
            Divider(
              height: Config.yMargin(context, 8.25),
              color: Theme.of(context).primaryColor,
              thickness: Config.yMargin(context, 0.64),
              endIndent: screenSize.width * 0.36,
            ),
            SizedBox(
              height: Config.yMargin(context, 11.56),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 13.6),
              ),
              child: Text(
                'A link has been sent to your mail, click to reset your password.',
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: Config.textSize(context, 3.89),
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
              height: Config.yMargin(context, 8.63),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Mail',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontFamily: 'Segoe UI',
                    fontSize: Config.textSize(context, 4.13),
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
