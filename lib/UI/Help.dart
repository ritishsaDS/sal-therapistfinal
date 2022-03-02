import 'package:flutter/material.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';

class Help extends StatefulWidget {
  const Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Help",
          style: TextStyle(
              color: Color(midnightBlue), fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical),
              child: Text(
                "Frequently Asked Questions",
                style: TextStyle(
                    color: Color(backgroundColorBlue),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    "How do I cancel my booking?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  children: [
                    Text("You can cancel your upcoming session by clicking on the My Sessions area in the Menu. Next step is to click on the counsellor name and then click on the cancel button on the bottom of your screen.")
                  ],
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02, vertical: 0),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    "How do I use my remaining sessions?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02, vertical: 0),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    "Is my information safe?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  children: [
                    Text("All your audio/video data is encrypted on the servers. We use state-of-the-art technology to ensure your data is secured. The SAL mobile app requires you to enter a unique passcode (OTP) for extra security. You can visit our Privacy Policy for more information.")
                  ],
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02, vertical: 0),
                ),


              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    "Frequently asked Question ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02, vertical: 0),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,

              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child:  Text(
                    "Connect with SAL",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(backgroundColorBlue),
                    ),
                  ),

              ),
            ),
            Container(
              width: SizeConfig.screenWidth,

              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: ExpansionTile(title: Text(
                "Sal Email Id",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(fontColorSteelGrey),
                    fontSize: SizeConfig.blockSizeVertical * 1.5),
              ),
              children: [
                ListTile(
                  title: Text(
                    "reachus@sal.foundation",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
