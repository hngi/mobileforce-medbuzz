import 'package:flutter/material.dart';


class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get Screen size
    Size screenSize = MediaQuery.of(context).size;
    //get Safe area padding
    EdgeInsets safe = MediaQuery.of(context).viewPadding;

    return SafeArea(
        child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.03,),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Create An \nAccount',
                style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontSize: 32.0,
                )
              ),
            ),
            
            Divider(
              height: screenSize.height * 0.03,
              color: Color(0xff617ADC),
              thickness: 5.0,
              endIndent: screenSize.width * 0.25,
              ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 10.0),
              child: Text(
                'Name',
                style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 27.0),
                child: TextField(
                decoration: InputDecoration(
                hintText: 'Mark'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 10.0),
              child: Text(
                'Email',
                style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 27.0),
                child: TextField(
                decoration: InputDecoration(
                
                hintText: 'abc@example.com'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 10.0),
              child: Text(
                'Password',
                style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 27.0),
                child: TextField(
                  obscureText: true,
                decoration: InputDecoration(
                hintText: '••••••••'
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)), 
                color: Color(0xff617ADC),
                ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 24, left: 24, right: 27),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: screenSize.height * 0.025,),
            Padding(
                padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(
                  'Have an account? ',
                  style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),),
                Text(
                  'Login',
                  style: TextStyle(
                  fontFamily: 'Segoe-Bold',
                  fontWeight: FontWeight.bold,
                  color: Color(0xff617ADC),
                  fontSize: 16.0,
                ),)
              ],),
            )

          ],
        )
      ),
    );
  }
}

