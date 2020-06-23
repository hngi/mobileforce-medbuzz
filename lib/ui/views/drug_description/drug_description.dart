import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class DrugDescription extends StatelessWidget {
  Color boldTextColor = Color(0xff333333);
  //yMargin constant: 7.76
  //xMargin constant: 4.5
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            'Description', 
            style: TextStyle(
              fontFamily: 'Segoe',
              fontWeight: FontWeight.normal,
              color: boldTextColor,
              )
            ),
          leading: BackButton(color: boldTextColor,),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Config.yMargin(context, 5.15), //40px
            ),
            Padding(
              padding: EdgeInsets.only(left: Config.xMargin(context, 5.33)), //24px
              child: Text(
                'Aspirin',
                style: TextStyle(
                  color: boldTextColor,
                  fontFamily: 'Segoe',
                  fontWeight: FontWeight.w900,
                  fontSize: Config.textSize(context, 4), //18px
                ),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 2.06), //16px
            ),
            Padding(
              padding: EdgeInsets.only(left: Config.xMargin(context, 5.33), right: Config.xMargin(context, 6.5)), //24px , 27px
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xff4F4F4F),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: Config.textSize(context, 3.56), //16px
                  ),
                  text: 'This is a medication for pain relief. It is great any pain you have experiend so far especially during this internship.'
                  ),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 2.06), //16px,
            ),
            //"How to use" Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.yMargin(context, 2.57)), //20
                ),
              margin: EdgeInsets.only(left: Config.xMargin(context, 5.5), right: Config.xMargin(context, 5.8), top: Config.yMargin(context, 2.2)), //26, 16
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33), vertical: Config.yMargin(context, 2.31)), //24, 16
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("How to use", style: TextStyle(color: boldTextColor, fontWeight: FontWeight.w600, fontSize: Config.textSize(context, 3.7))),
                  Icon(Icons.expand_more, ),
                  ],
                ),
              ),
            ),

            //Side Effects Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.yMargin(context, 2.57)), //20
                ),
              margin: EdgeInsets.only(left: Config.xMargin(context, 5.5), right: Config.xMargin(context, 5.8), top: Config.yMargin(context, 2.2)), //26, 16
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33), vertical: Config.yMargin(context, 2.31)), //24, 16
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Side Effects", style: TextStyle(color: boldTextColor, fontWeight: FontWeight.w600, fontSize: Config.textSize(context, 3.7))),
                  Icon(Icons.expand_more, ),
                  ],
                ),
              ),
            ),

            //Precautions Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.yMargin(context, 2.57)), //20
                ),
              margin: EdgeInsets.only(left: Config.xMargin(context, 5.5), right: Config.xMargin(context, 5.8), top: Config.yMargin(context, 2.2)), //26, 16
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33), vertical: Config.yMargin(context, 2.31)), //24, 16
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Precautions", style: TextStyle(color: boldTextColor, fontWeight: FontWeight.w600, fontSize: Config.textSize(context, 3.7))),
                  Icon(Icons.expand_more, ),
                  ],
                ),
              ),
            ),

            //Interactions Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.yMargin(context, 2.57)), //20
                ),
              margin: EdgeInsets.only(left: Config.xMargin(context, 5.5), right: Config.xMargin(context, 5.8), top: Config.yMargin(context, 2.2)), //26, 16
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33), vertical: Config.yMargin(context, 2.31)), //24, 16
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Interations", style: TextStyle(color: boldTextColor, fontWeight: FontWeight.w600, fontSize: Config.textSize(context, 3.7))),
                  Icon(Icons.expand_more, ),
                  ],
                ),
              ),
            ),

            //Overdose Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Config.yMargin(context, 2.57)), //20
                ),
              margin: EdgeInsets.only(left: Config.xMargin(context, 5.5), right: Config.xMargin(context, 5.8), top: Config.yMargin(context, 2.2)), //26, 16
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 5.33), vertical: Config.yMargin(context, 2.31)), //24, 16
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Overdose", style: TextStyle(color: boldTextColor, fontWeight: FontWeight.w600, fontSize: Config.textSize(context, 3.7))),
                  Icon(Icons.expand_more, ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ),
    );
  }
}