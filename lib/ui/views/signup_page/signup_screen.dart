import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: _getForm(context),
          )),
    );
  }

  Widget _getForm(BuildContext context) {
    var box = Hive.box('onboarding');
    var userDb = Provider.of<UserCrud>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: Config.yMargin(context, 12), //130px
        ),
        Padding(
          padding: EdgeInsets.only(left: Config.xMargin(context, 5.3)),
          child: Text('What Do I  \nCall You?',
              style: TextStyle(
                fontSize: Config.yMargin(context, 4.12),
              )),
        ),

        Divider(
          height: Config.yMargin(context, 8.25), //60
          color: Theme.of(context).primaryColor,
          thickness: Config.yMargin(context, 0.64),
          endIndent: MediaQuery.of(context).size.width * 0.25,
        ),

        Padding(
          padding: EdgeInsets.only(
              bottom: Config.yMargin(context, 10),
              left: Config.xMargin(context, 5.3),
              right: Config.xMargin(context, 6)),
          child: Container(
            width: width,
            child: TextFormField(
                controller: nameController,
                cursorColor: Theme.of(context).primaryColorDark,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: Config.xMargin(context, 5.5)),
                decoration: InputDecoration.collapsed(hintText: 'Your name')),
          ),
        ),
        InkWell(
          onTap: () {
            if (nameController.text.isNotEmpty) {
              print('${nameController.text}');
              var newuser = User(
                  id: DateTime.now().toString(), name: nameController.text);
              userDb.adduser(newuser);
              box.put('status', 'true');
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushReplacementNamed(context, RouteNames.homePage);
              });
            } else {
              showSnackBar(context);
            }
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
                right: Config.xMargin(context, 6)), //24,24,27
            child: Text(
              'Next',
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: Config.textSize(context, 3.9),
              ),
            ),
          ),
        ),

        /*
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
          child: TextFormField(
            onSaved: (value) => email = value,
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
          child: TextFormField(
            onSaved: (value) => password = value,
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
        InkWell(
          onTap: () {
            _formKey.currentState.save();
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
        ),

         SizedBox(
          height: Config.yMargin(context, 3.09),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
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
              InkWell(
                highlightColor: Theme.of(context).backgroundColor,
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: Config.textSize(context, 3.9), //16
                  ),
                ),
              )
            ],
          ),
        )
 */
        //xMargin constant: 4.5, yMargin constant7.76
      ],
    );
  }
}

void showSnackBar(BuildContext context, {String text: 'Name cannot be empty'}) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Theme.of(context).buttonColor.withOpacity(.9),
    duration: Duration(seconds: 2),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Config.textSize(context, 5.3),
          color: Theme.of(context).primaryColorLight),
    ),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}
