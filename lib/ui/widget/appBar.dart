import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';

// class MyApBar extends StatelessWidget {
//   final bool useDefaultActions;
//   final String title;
//   final List<Widget> actions;
//   final Widget leading;

//   const MyApBar(
//       {Key key, this.title, this.actions, this.leading, this.useDefaultActions})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Theme.of(context).backgroundColor,
//       title: Text(title,
//           style: TextStyle(color: Theme.of(context).primaryColorDark)),
//       leading: leading ??
//           IconButton(
//               icon: Icon(Icons.keyboard_backspace,
//                   color: Theme.of(context).primaryColorDark),

//               //Function to navigate to previous screen or home screen (as the case maybe) goes here
//               onPressed: () {}),
//       actions: actions != null
//           ? actions
//           : useDefaultActions
//               ? <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         vertical: Config.yMargin(context, 1),
//                         horizontal: Config.xMargin(context, 1.5)),
//                     child: FlatButton(
//                         color: Theme.of(context).backgroundColor,
//                         splashColor: Theme.of(context).backgroundColor,
//                         onPressed: () {},
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 width: 2,
//                                 color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(
//                                 Config.xMargin(context, 10))),
//                         child: Text('Diet Tracker',
//                             style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: Config.textSize(context, 3.5),
//                                 fontWeight: FontWeight.w600))),
//                   )
//                 ]
//               : [],
//     );
//   }
// }

PreferredSizeWidget appBar(
        {@required BuildContext context,
        Color color,
        String title,
        List<Widget> actions,
        Widget leading,
        bool useDefaultActions = false}) =>
    AppBar(
      elevation: 0,
      backgroundColor: color ?? Theme.of(context).backgroundColor,
      title: Text(title,
          style: TextStyle(color: Theme.of(context).primaryColorDark)),
      leading: leading ??
          IconButton(
              icon: Icon(Icons.keyboard_backspace,
                  color: Theme.of(context).primaryColorDark),

              //Function to navigate to previous screen or home screen (as the case maybe) goes here
              onPressed: () {
                Navigator.pop(context);
              }),
      actions: actions != null
          ? actions
          : useDefaultActions
              ? <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Config.yMargin(context, 1),
                        horizontal: Config.xMargin(context, 1.5)),
                    child: FlatButton(
                        color: Theme.of(context).backgroundColor,
                        splashColor: Theme.of(context).backgroundColor,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(
                                Config.xMargin(context, 10))),
                        child: Text('Diet Tracker',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Config.textSize(context, 3.5),
                                fontWeight: FontWeight.w600))),
                  )
                ]
              : [],
    );
