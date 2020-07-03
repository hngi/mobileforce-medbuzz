import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final int progress;
  final int total;
  final double width;
  final double height;
  final Widget child;
  final Color progressBarColor;
  const ProgressCard(
      {Key key,
      this.title,
      this.progress,
      this.height,
      this.total,
      this.width,
      this.child,
      this.progressBarColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Config.xMargin(context, 3),
          vertical: Config.yMargin(context, 0.25)),
      height: Config.yMargin(context, 20),
      width: width,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ?? Text(''),
          SizedBox(
            height: Config.yMargin(context, 3),
          ),
          Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5))),
              ),
              Container(
                height: height,
                width: width * (progress / total),
                decoration: BoxDecoration(
                    color: progressBarColor,
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
