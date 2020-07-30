import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/notification_tone/notification_tone_model.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationToneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<NotificationToneModel>(context);
    return Scaffold(
      appBar: appBar(
        onPressed: () {
          model.pause();
          Navigator.pop(context);
        },
        context: context,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              model.onTap(model.tones[0]);
            },
            title: Text(model.tones[0]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[0]);
                },
                value: model.isClassic),
          ),
          ListTile(
            onTap: () {
              model.onTap(model.tones[1]);
            },
            title: Text(model.tones[1]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[1]);
                },
                value: model.isDream),
          ),
          ListTile(
            onTap: () {
              model.onTap(model.tones[2]);
            },
            title: Text(model.tones[2]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[2]);
                },
                value: model.isDrizzle),
          ),
          ListTile(
            onTap: () {
              model.onTap(model.tones[3]);
            },
            title: Text(model.tones[3]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[3]);
                },
                value: model.isEnchantment),
          ),
          ListTile(
            onTap: () {
              model.onTap(model.tones[4]);
            },
            title: Text(model.tones[4]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[4]);
                },
                value: model.isSynthwave),
          ),
          ListTile(
            onTap: () {
              model.onTap(model.tones[5]);
            },
            title: Text(model.tones[5]),
            trailing: Switch(
                activeColor: ThemeData().primaryColor,
                activeTrackColor: Colors.blueAccent,
                onChanged: (value) {
                  model.saveNotificationTone(model.tones[5]);
                },
                value: model.isBell),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: Config.yMargin(context, 2)),
          //   width: width,
          //   alignment: Alignment.center,
          //   child: FlatButton(
          //       color: Theme.of(context).primaryColor,
          //       onPressed: () {},
          //       shape: RoundedRectangleBorder(
          //           borderRadius:
          //               BorderRadius.circular(Config.xMargin(context, 2))),
          //       child: Text(
          //         "Save",
          //         style: TextStyle(
          //             color: Theme.of(context).primaryColorLight,
          //             fontSize: Config.xMargin(context, 5)),
          //       )),
          // )
        ],
      ),
    );
  }
}
