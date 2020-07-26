import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'To change Fingerprint, go to Settings > Security > Fingerprint > Fingerprint Management',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Input Pin and then Continue',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Got It!',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }
}
