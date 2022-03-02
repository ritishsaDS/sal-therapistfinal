import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/UI/CancelAppointment.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/CommonWidgets.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Callpage.dart';

class Cafe3 extends StatefulWidget {
  dynamic appointment;
  var gender;
  var photo;
  var firstname;
  var dif;
  Cafe3({this.appointment,this.dif, this.gender, this.photo, this.firstname});
  @override
  _Cafe3State createState() => _Cafe3State();
}

class _Cafe3State extends State<Cafe3> {
  Future<void> _launched;
  var moodstatic = [
    "12:00 AM",
    "0:30 AM",
    "1:00 AM",
    "1:30 AM",
    "2:00 AM",
    "2:30 AM",
    "3:00 AM",
    "3:30 AM",
    "4:00 AM",
    "4:30 AM",
    "5:00 AM",
    "5:30 AM",
    "6:00 AM",
    "6:30 AM",
    "7:00 AM",
    "7:30 AM",
    "8:00 AM",
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "1:30 PM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
    "5:30 PM",
    "6:00 PM",
    "6:30 PM",
    "7:00 PM",
    "7:30 PM",
    '8:00 PM',
    '8:30 PM',
    "9:00 PM",
    "9:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
        "12:00 PM"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Details",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.05,
          right: SizeConfig.screenWidth * 0.05,
          top: SizeConfig.blockSizeVertical * 3,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.5,
                blurRadius: 0.9,
                offset: Offset.fromDirection(2, 1),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push((MaterialPageRoute(
                    builder: (context) => CancelAppointment(id:widget.appointment['appointment_id']))));              },
              color: Colors.white,
              minWidth: SizeConfig.screenWidth * 0.4,
              child: Text(
                "CANCEL",
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(fontColorGray)),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                  if(widget.dif==0||widget.dif<=0&&widget.dif>=-59){
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallPage(
                          session: "1",type: "1",
                          channelName:widget.appointment['appointment_id'] ,
dif:widget.dif==0 ,
                          name: "Call",
                          role: ClientRole.Broadcaster,
                        ),
                      ),
                    );
                  }
                  else{
                    Fluttertoast.showToast(msg: "Please Wait For Events Correct Time");
                  }

                //     Navigator.of(context).pushNamed('/');
              },
              color: Colors.blue,
              minWidth: SizeConfig.screenWidth * 0.4,
              child: Text(
                "CALL",
                style: GoogleFonts.openSans(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 3,
              ),
              child: CircleAvatar(
                radius: SizeConfig.blockSizeVertical * 8,
                backgroundImage: NetworkImage(
                    "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                        widget.photo),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1.5,
              ),
              child: Text(
                widget.firstname,
                style: GoogleFonts.openSans(
                  color: Color(fontColorSteelGrey),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Container(
                width: SizeConfig.screenWidth * 0.25,
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 1.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(widget.dif==0||widget.dif<=0&&widget.dif>=-59){
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallPage(
                                session: "1",type: "1",
                                channelName:widget.appointment['appointment_id'] ,

                                name: "Call",
                                role: ClientRole.Broadcaster,
                              ),
                            ),
                          );
                        }
                        else{
                          Fluttertoast.showToast(msg: "Please Wait For Events Correct Time");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/icons/Ellipse 3.png'),
                                fit: BoxFit.cover)),
                        child: Image.asset(
                          'assets/icons/call.png',
                          scale: SizeConfig.blockSizeVertical * 0.5,
                        ),
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {

                        await _handleCameraAndMic(Permission.camera);
                        await _handleCameraAndMic(Permission.microphone);
                        // push video page with given channel name
                        if(widget.dif==0||widget.dif<=0&&widget.dif>=-59){
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallPage(
                                session: "1",type: "1",
                                channelName:widget.appointment['appointment_id'] ,

                                name: "VideoCall",
                                role: ClientRole.Broadcaster,
                              ),
                            ),
                          );
                        }
                        else{
                          Fluttertoast.showToast(msg: "Please Wait For Events Correct Time");
                        }
                        // toast("In Progress");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/icons/Ellipse 3.png'),
                                fit: BoxFit.cover)),
                        child: Image.asset(
                          'assets/icons/video call.png',
                          scale: SizeConfig.blockSizeVertical * 0.5,
                        ),
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeVertical * 1.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical * 1.5,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ABOUT THE CLIENT",
                    style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "AGE:",
                            style: GoogleFonts.openSans(
                              color: Color(fontColorGray),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " 28",
                            style: GoogleFonts.openSans(
                              color: Color(fontColorGray),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "GENDER:",
                            style: GoogleFonts.openSans(
                              color: Color(fontColorGray),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.gender,
                            style: GoogleFonts.openSans(
                              color: Color(fontColorGray),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Text(
                    "APPOINTMENT DETAILS",
                    style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    children: [
                      Text(
                        "DATE:",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (widget.appointment['date'].toString().split("-")[2]) +
                            " ${DateFormat('MMMM').format(DateTime.parse(widget.appointment['date'].toString()))}",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    children: [
                      Text(
                        "TIME:",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        moodstatic[int.parse(widget.appointment['time'])] +
                            "-" +
                            moodstatic[
                                int.parse(widget.appointment['time']) + 2],
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    children: [
                      Text(
                        "COMMENTS:",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " \t Edit",
                        style: GoogleFonts.openSans(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    "Not Available",
                    style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    children: [
                      Text(
                        "ATTACHMENTS:",
                        style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " \t Edit",
                        style: GoogleFonts.openSans(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Text(
                    "Not Available",
                    style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Text(
                    "ASSESSMENTS TAKEN:",
                    style: GoogleFonts.openSans(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}

