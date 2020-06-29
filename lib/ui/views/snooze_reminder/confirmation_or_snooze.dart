import 'package:MedBuzz/ui/navigation/page_transition/page_transition.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/snooze_reminder/confirmation_or_snooze_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmOrSnoozeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ConfirmOrSnoozeModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: Config.yMargin(context, 0),
                child: Opacity(
                  opacity: .3,
                  child: Container(
                      alignment: Alignment.center,
                      height: height * .25,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/profile_bg.png')))),
                ),
              ),
              Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned(
                      top: Config.yMargin(context, 8),
                      child: CustomPadding(
                        padding: 3,
                        child: Container(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("It's time for your",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: Config.textSize(context, 9),
                                      fontWeight: FontWeight.w600)),
                              Text("medication",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: Config.textSize(context, 9),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * .24,
                      child: Container(
                        height: height * .57,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: height * .45,
                              width: width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'images/remedy-amico_1.png'))),
                            ),
                            SizedBox(height: Config.yMargin(context, 1)),
                            Text('You have not taken your',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4.5))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('daily dose of ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 4.5),
                                    )),
                                Text('"${model.drugName}"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: Config.textSize(context, 4.5),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            // Expanded(
                            //   child: RichText(
                            //       text: TextSpan(children: [
                            //     TextSpan(
                            //         text: 'You have not taken your daily dose of ',
                            //         style: TextStyle(
                            //             fontSize: Config.textSize(context, 7))),
                            //     TextSpan(
                            //         //name of actual drug should be dynamically show here
                            //         text: '"${model.drugName}"',
                            //         style: TextStyle(
                            //             fontSize: Config.textSize(context, 7),
                            //             fontWeight: FontWeight.bold)),
                            //   ])),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Config.yMargin(context, 7),
                      child: Container(
                        margin:
                            EdgeInsets.only(left: Config.xMargin(context, 3)),
                        width: width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: Config.yMargin(context, 7),
                              width: Config.xMargin(context, 40),
                              child: FlatButton(
                                //Function to snooze reminder should be invoked here
                                onPressed: () {
                                  // Empty function to be implemented already exists in the view model
                                  //if you're implementing, just go edit the onSnooze function
                                  model.onSnooze();
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) {
                                        return CustomAlertBox(
                                            title: 'Snooze notification');
                                      });
                                },
                                color: Theme.of(context).backgroundColor,
                                splashColor: Theme.of(context).buttonColor,
                                child: Text(
                                  'Snooze',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Config.xMargin(context, 3.5)),
                                    side: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: Config.xMargin(context, 6)),
                              height: Config.yMargin(context, 7),
                              width: Config.xMargin(context, 40),
                              child: FlatButton(
                                //Function to mark reminder as done should be invoked here
                                onPressed: () {
                                  // Empty function to be implemented already exists in the view model
                                  //if you're implementing, just go edit the onDone function
                                  model.onDone();
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) =>
                                          CustomAlertBox(title: 'Success'));
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                                color: Theme.of(context).primaryColor,
                                splashColor: Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Config.xMargin(context, 3.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomPadding extends StatelessWidget {
  final Widget child;
  final double padding;

  const CustomPadding({Key key, this.child, this.padding = 3})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Config.xMargin(context, padding)),
      child: child,
    );
  }
}

class CustomAlertBox extends StatefulWidget {
  final String title;

  CustomAlertBox({Key key, this.title}) : super(key: key);

  @override
  _CustomAlertBoxState createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox>
    with TickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  start() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: widget.title == 'Snooze notification'
          ? Container(
              height: height * .3,
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedIcon(
                      size: Config.xMargin(context, 12),
                      color: Colors.red,
                      icon: AnimatedIcons.pause_play,
                      progress: animation),
                  SizedBox(height: Config.textSize(context, 1)),
                  Text(
                    'Snoozed for 20 minutes',
                    style: TextStyle(fontSize: Config.textSize(context, 4.5)),
                  ),
                ],
              ),
            )
          : Container(
              height: height * .3,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedIcon(
                      size: Config.xMargin(context, 12),
                      color: Colors.green,
                      icon: AnimatedIcons.event_add,
                      progress: animation),
                  SizedBox(height: Config.textSize(context, 1)),
                  Text('Schedule completed',
                      style:
                          TextStyle(fontSize: Config.textSize(context, 4.5))),
                ],
              )),
    );
  }
}
