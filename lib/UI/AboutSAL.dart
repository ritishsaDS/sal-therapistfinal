import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:mental_health/UI/webview.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSAL extends StatefulWidget {
  const AboutSAL({Key key}) : super(key: key);

  @override
  _AboutSALState createState() => _AboutSALState();
}

class _AboutSALState extends State<AboutSAL> {
  List<String> to = [];
  List<String> cc = [];
  List<String> bcc = [];
  String subject = '';
  String body = '';
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
          "About SAL",
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
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                "Heading",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(backgroundColorBlue)),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(

                "Salubrium Private Limited (SAL) was formed with the purpose of providing emotional well-being solutions for the people. Our constant endeavour is to educate people and reduce stigma around mental health through our various initiatives."
                    "\n"
                    "\n" " We equip people to deal with situations in their life and help them in preventing mental health issues. In the process, our goal is to elevate their emotional wellbeing by providing all such free & paid services under one roof by a team of Listener volunteers & Therapist, respectively."
                    "\n"
                    "\n"
                    "We hold that hand that’s slipping out, say a kind word to those in distress or just hear them out so that people can feel better by managing their emotions in a confidential environment.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(fontColorSteelGrey),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                "Connect with SAL",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(backgroundColorBlue)),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.005),
              alignment: Alignment.center,
              child: ListTileTheme(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    "SAL Email Id",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap:() async {

                        // final url = Mailto(
                        //   to: ['reachus@sal.foundation'],
                        //
                        // ).toString();
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   print(";jklsdv;jhklsdv");
                        //   // showCupertinoDialog(
                        //   //   context: context,
                        //   //   builder: MailClientOpenErrorDialog(url: url).build,
                        //   // );
                        // }
                      },
                      child: ListTile(
                        title: Text(
                          "reachus@sal.foundation",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02, vertical: 0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewClass(
                            link: "https://sal-foundation.com/about-sal")));
              },
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.005),
                alignment: Alignment.centerLeft,
                child: ExpansionTile(
                  title: Text(
                    "SAL Website",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(fontColorSteelGrey),
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "www.sal-foundation.com",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                  ),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                "Legal",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(backgroundColorBlue)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewClass(
                            link: "https://salapp.sal-foundation.com/app_tos/",)));
              },
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.03),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewClass(
                                link: "https://salapp.sal-foundation.com/app_tos")));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Terms Of Services",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(fontColorSteelGrey),
                              fontSize: SizeConfig.blockSizeVertical * 1.5),

                      ),
                      Icon(Icons.chevron_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical*2,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewClass(
                          link: "https://salapp.sal-foundation.com/app_pp/",)));
              },
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.03),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewClass(
                                link: "https://salapp.sal-foundation.com/app_pp/",)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(fontColorSteelGrey),
                            fontSize: SizeConfig.blockSizeVertical * 1.5),

                      ),
                      Icon(Icons.chevron_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  _launchURLApp() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> openEmailApp(BuildContext context,subject) async {
    List<String> tooo=['ritishs39@gmail.com'] ;
    final url = Mailto(

      to: tooo,
      subject: "",
    ).toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showCupertinoDialog(
        context: context,
        builder: MailClientOpenErrorDialog(url: url).build,
      );
    }

  }
}
class MailClientOpenErrorDialog extends StatelessWidget {
  final String url;

  const MailClientOpenErrorDialog({Key key, @required this.url})
      : assert(url != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Launch Error'),
      content: Text('We could not launch the following url:\n$url'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
