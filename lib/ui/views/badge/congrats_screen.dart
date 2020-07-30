import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class CongratsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: <Widget>[
              Stack(children: [
                Positioned(
                  top: Config.yMargin(context, 3),
                  left: Config.yMargin(context, 2),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    onPressed: () {},
                  ),
                ),
                Opacity(
                  opacity: 0.11,
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('images/profile_bg.png'),
                  ),
                ),
                Opacity(
                  opacity: 0.05,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: Config.yMargin(context, 96.0),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                ),
              ]),
            ],
          ),
          Positioned(
            top: Config.yMargin(context, 18.0),
            left: Config.yMargin(context, 8.0),
            child: Column(children: [
              Text(
                'Badge Complete',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Config.textSize(context, 9.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Config.xMargin(context, 15.0),
              ),
              Image(
                fit: BoxFit.fill,
                image: AssetImage('images/congratsbadge.png'),
              ),
              SizedBox(
                height: Config.xMargin(context, 15.0),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'You have successfully completed your \n ',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: Config.textSize(context, 4)),
                    children: <TextSpan>[
                      TextSpan(
                        text: '"Fitness"',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      TextSpan(
                        text: ' badge',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
