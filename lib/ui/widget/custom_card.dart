import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const CustomCard({Key key, this.title, this.subtitle, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width * .4,
        height: Config.yMargin(context, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Config.xMargin(context, 5)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorLight,
              spreadRadius: Config.xMargin(context, 2),
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Config.textSize(context, 3.5),
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(
                height: Config.yMargin(context, 1.5),
              ),
              CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: Config.xMargin(context, 5.55),
                  child: Image.asset(image)),
              SizedBox(
                height: Config.yMargin(context, 1),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: Config.textSize(context, 3.5),
                    color: Theme.of(context).primaryColorDark.withOpacity(0.5)),
              ),
            ]));
  }
}
