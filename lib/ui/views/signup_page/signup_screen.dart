import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MySignUp());
  }
}

class MySignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Set features intro in Medications to false
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
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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

          Container(
            margin: EdgeInsets.only(top: Config.yMargin(context, 10)),
            padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
            height: height * .4,
            width: width,
            alignment: Alignment.center,
            child: TextFormField(
                controller: nameController,
                cursorColor: Theme.of(context).primaryColorDark,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: Config.xMargin(context, 5.5)),
                decoration: InputDecoration(hintText: 'Your name')),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  if (nameController.text.isNotEmpty) {
                    print('${nameController.text}');
                    var newuser = User(
                        id: DateTime.now().toString(),
                        name: nameController.text);
                    await userDb.adduser(newuser).then((value) async {
                      await box.put('status', 'true');
                      FeatureDiscovery.discoverFeatures(
                        context,
                        const <String>{
                          'feature7',
                          'feature1',
                          // feature2,
                          // feature3,
                          // feature4,
                          // feature6,
                          // feature5
                        },
                      );
                      Navigator.pushReplacementNamed(
                          context, RouteNames.homePage);
                    });
                    //delaying with a future might not be the best, but waiting to receive the value from the Future is better
                    // Future.delayed(
                    //     Duration(seconds: 2),
                    //     () => Navigator.pushReplacementNamed(
                    //         context, RouteNames.homePage));
                  } else {
                    showSnackBar(context);
                  }
                },
                child: Container(
                  height: Config.yMargin(context, 7),
                  width: Config.xMargin(context, 40),
                  padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius:
                          BorderRadius.circular(Config.xMargin(context, 2.77))),
                  alignment: Alignment.center, //24,24,27
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: Config.textSize(context, 3.85),
                    ),
                  ),
                ),
              ),
            ],
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
      ),
    );
  }
}

void showSnackBar(BuildContext context, {String text: 'Name cannot be empty'}) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Theme.of(context).primaryColor.withOpacity(.9),
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
