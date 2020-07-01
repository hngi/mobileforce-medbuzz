import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class SingleDiet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_backspace)),
        elevation: 2.0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Config.yMargin(context, 2.6)),
            child: FlatButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        confirmationDialog(context), //show Confirmation dialog
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
          ),
          //SizedBox(height: Config.yMargin(context, 3)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Fried Rice',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: Config.textSize(context, 5.3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: Config.xMargin(context, 44),
                ),
                Image.asset('images/food.png'),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: Config.xMargin(context, 5.33),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: Config.textSize(context, 3.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Config.yMargin(context, 0.5)),
                    child: Text(
                      'Have a plate of rice and vegetables. Use lean \nprotein.',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: Config.textSize(context, 3.6),
                      ),
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 7)),
                  Text(
                    'Frequency',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: Config.textSize(context, 3.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Config.yMargin(context, 0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Once Today'),
                        Text(
                          '8:00AM',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: Config.textSize(context, 3.6),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 7)),
                  Text(
                    'Length',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: Config.textSize(context, 3.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Config.yMargin(context, 0.5)),
                    child: Text(
                      '4 days left out of 30 days',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: Config.textSize(context, 3.6),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(height: Config.yMargin(context, 23)),

          Padding(
            padding: EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
            child: Container(
              padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(Config.yMargin(context, 1.28))),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: Config.xMargin(context, 5.33),
                  right: Config.xMargin(context, 6)), //24,24,27
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: Config.textSize(context, 3.9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmationDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.xMargin(context, 4.44)),
        ),
        child: Container(
          height: Config.yMargin(context, 23.8), //should be exact 23.7
          width: Config.xMargin(context, 88.0), //should be exact 88
          //width: Config.xMargin(context, 50),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.0, bottom: 17.0),
                  child: Text(
                    'Delete this diet?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: Config.xMargin(context, 30.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color(0xffB5B5B5),
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Config.xMargin(context,
                                  4)) //                 <--- border radius here
                              ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Config.yMargin(context, 1.5)),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xffB5B5B5)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO implement code to delete data from DB
                      },
                      child: Container(
                        width: Config.xMargin(context, 30.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color(0xffB5B5B5),
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Config.xMargin(context,
                                  4)) //                 <--- border radius here
                              ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Config.yMargin(context, 1.5)),
                          child: Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xffDC1D00)),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
