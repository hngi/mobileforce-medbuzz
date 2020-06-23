import 'package:MedBuzz/ui/views/home_page.dart';
import 'package:MedBuzz/ui/views/signup_page/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(Config.xMargin(context, 4.5),
                          Config.yMargin(context, 25), 0, 0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 7.8),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                Config.xMargin(context, 4.5),
                                Config.yMargin(context, 29.4),
                                0,
                                0),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 7.8),
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  Config.yMargin(context, 35.6),
                                  Config.xMargin(context, 40),
                                  0),
                              child: Container(
                                height: height * .006,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                        Config.xMargin(context, 5)),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 1.2),
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
                      height: Config.yMargin(context, 3.6),
                    ),
                    Text(
                      'Password',
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
                        hintText: '.........',
                        hintStyle: TextStyle(
                          fontSize: Config.textSize(context, 4.4),
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 2),
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(
                        top: Config.yMargin(context, 2.3),
                      ),
                      child: InkWell(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 2.7),
                    ),
                    Container(
                      height: height * .065,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            },
                            child: Text(
                              'Login',
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
                    SizedBox(
                      height: Config.yMargin(context, 2.7),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'No account?',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Config.textSize(context, 3.9),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ));
                            },
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(
                                fontSize: Config.textSize(context, 3.9),
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
