import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatefulWidget {
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
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard>
    with TickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  start() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuad));

    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    double progress() {
      var value = widget.progress / widget.total;
      return value.isNaN ? 0.0 : value;
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Config.xMargin(context, 3),
          vertical: Config.yMargin(context, 0.25)),
      height: Config.yMargin(context, 20),
      width: widget.width,
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
          widget.child ?? Text(''),
          SizedBox(
            height: Config.yMargin(context, 3),
          ),
          Stack(
            children: [
              Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5))),
              ),
              //This animates the progress bar
              //I'm still trying to figure out how to begin the animation from the start of the
              //container instead of the device screen
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                        _animation.value * width, 0, 0),
                    child: Container(
                      height: widget.height,
                      width: widget.width * progress(),
                      decoration: BoxDecoration(
                          color: widget.progressBarColor,
                          borderRadius: BorderRadius.circular(
                              Config.xMargin(context, 5))),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
