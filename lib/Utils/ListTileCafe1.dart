import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/UI/Cafe3.dart';
import 'package:mental_health/UI/CallPage2.dart';
import 'package:mental_health/UI/Callpage.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:permission_handler/permission_handler.dart';
class listTileCafe1 extends StatefulWidget{
  var slot;
  var id;
  var appointmentid;
  dynamic appointment;
  var photo;
  var gender;
  BuildContext   context;
  var contactName;
  var type;
  var time;
  var date;
  var timec;
  var olddate;
  var index;
  listTileCafe1({this.index,this.slot,this.olddate,this.id,this.photo,this.gender,this.appointment,this.timec,this.appointmentid,this.context,this.contactName,this.type,this.time,this.date});
  @override
  _listTileCafe1State createState() => _listTileCafe1State();
}

class _listTileCafe1State extends State<listTileCafe1> {
  var startTime;
  var diff;
  var moodstatic = [
    "12:00 AM",
    "00:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    '08:00 PM',
    '08:30 PM',
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 AM"
  ];
  var today ;
  var yesterday;
  var tomorrow;
   List months =
  ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];
  @override
  void initState() {
    final now = DateTime.now();
     today = DateTime(now.year, now.month, now.day);
     yesterday = DateTime(now.year, now.month, now.day - 1);
     tomorrow = DateTime(now.year, now.month, now.day + 1);
    startTime = DateTime(
        int.parse(
            widget.date.toString().substring(0, 4)),
        int.parse(
        widget.date.toString().substring(5, 7)),
    int.parse(widget.date
        .toString()
        .substring(8, 10)));
    // print("+---------"+(int.parse(moodstatic[int.parse(widget.timec)].toString().substring(0,1))).toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return widget.index==0?InkWell(
      onTap: () {
        print("--------------"+ today.toString());
        if(int.parse(widget.timec)<=22){

          startTime = DateTime(
              int.parse(
                  widget.date.toString().substring(0, 4)),
              int.parse(
                  widget.date.toString().substring(5, 7)),
              int.parse(widget.date
                  .toString()
                  .substring(8, 10)),

              int.parse(
                  moodstatic[int.parse(widget.timec)]
                      .toString()
                      .substring(0, 2)),
              int.parse(
                  moodstatic[int.parse(widget.timec)]
                      .toString()
                      .substring(3, 5)));
          print("PMPMPOMPM"+startTime.toString());
        }
        else{
          if(int.parse(widget.timec)==23||int.parse(widget.timec)==24){
            print("AMAMAMAMA");
            startTime = DateTime(
                int.parse(
                    widget.date.toString().substring(0, 4)),
                int.parse(
                    widget.date.toString().substring(5, 7)),
                int.parse(widget.date
                    .toString()
                    .substring(8, 10)),

                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(0, 2)),
                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(3, 5)));
            print("AMAMAMAMA"+startTime.toString());
          }
          else{
            print("AMAMAMAMA");
            startTime = DateTime(
                int.parse(
                    widget.date.toString().substring(0, 4)),
                int.parse(
                    widget.date.toString().substring(5, 7)),
                int.parse(widget.date
                    .toString()
                    .substring(8, 10)),
                12 +
                    int.parse(
                        moodstatic[int.parse(widget.timec)]
                            .toString()
                            .substring(0, 2)),
                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(3, 5)));
            print("AMAMAMAMA"+startTime.toString());
          }
        }
        var currentTime = DateTime.now();
        diff = startTime.difference(currentTime).inMinutes;
        print("________________"+diff.toString());
        Navigator.of(context).push((MaterialPageRoute(
            builder: (context) => Cafe3(
                appointment: widget.appointment,
                photo: widget.photo,
                firstname: widget.contactName,
                gender: widget.gender,
                dif:diff
            ))));
      },
      child: Container(
        //color: Colors.blue[900],
        margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 2,
            right: SizeConfig.screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.olddate==today.toString().substring(0,10)?
            Text("TODAY",
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),) ):
            widget.olddate==tomorrow.toString().substring(0,10)?
          Text("TOMORROW",
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),) ):
            widget.index==0?Text(DateFormat("yMMMMd").format(DateTime.parse(widget.olddate)).toString(),style: GoogleFonts.openSans(
              color: Color(fontColorGray),) ):  widget.olddate==widget.date?SizedBox(height: 0,):Text(DateFormat("yMMMMd").format(DateTime.parse(widget.date)).toString(),
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),) ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.1,
                  child: Text(
                    "${widget.time}",
                    style: GoogleFonts.openSans(
                        color: Color(fontColorGray), fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.45,
                  child: Text(
                    "${widget.contactName}",
                    style: GoogleFonts.openSans(
                        color: Color(fontColorGray), fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print(widget.timec);
                          await _handleCameraAndMic(Permission.camera);
                          await _handleCameraAndMic(Permission.microphone);
                          // push video page with given channel name
                          if(int.parse(widget.timec)<=22){

                            startTime = DateTime(
                                int.parse(
                                    widget.date.toString().substring(0, 4)),
                                int.parse(
                                    widget.date.toString().substring(5, 7)),
                                int.parse(widget.date
                                    .toString()
                                    .substring(8, 10)),

                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(0, 2)),
                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(3, 5)));
                            print("PMPMPOMPM"+startTime.toString());
                          }
                          else{
                            if(int.parse(widget.timec)==23||int.parse(widget.timec)==24){
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),

                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            else{
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),
                                  12 +
                                      int.parse(
                                          moodstatic[int.parse(widget.timec)]
                                              .toString()
                                              .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                          }
                          var currentTime = DateTime.now();
                          diff = startTime.difference(currentTime).inMinutes;
                          print("________________"+diff.toString());
                          if(diff==0||diff<=0&&diff>=-59){
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
                          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("--------"+ moodstatic[25]);
                          print("--------"+ moodstatic[24]);
                          await _handleCameraAndMic(Permission.camera);
                          await _handleCameraAndMic(Permission.microphone);
                          // push video page with given channel name
                          if(int.parse(widget.timec)<=22){

                            startTime = DateTime(
                                int.parse(
                                    widget.date.toString().substring(0, 4)),
                                int.parse(
                                    widget.date.toString().substring(5, 7)),
                                int.parse(widget.date
                                    .toString()
                                    .substring(8, 10)),

                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(0, 2)),
                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(3, 5)));
                            print("PMPMPOMPM"+startTime.toString());
                          }
                          else{
                            if(int.parse(widget.timec)==25||int.parse(widget.timec)==24){
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),

                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            else{
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),
                                  12 +
                                      int.parse(
                                          moodstatic[int.parse(widget.timec)]
                                              .toString()
                                              .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            print("AMAMAMAMA"+startTime.toString());
                          }
                          var currentTime = DateTime.now();
                          diff = startTime.difference(currentTime).inMinutes;
                          print("________________"+diff.toString());
                          if(startTime.difference(currentTime).inSeconds==0||startTime.difference(currentTime).inSeconds<=0&&startTime.difference(currentTime).inSeconds>=-3600){
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallPage(
                                  session: "1",type: "1",
                                  channelName:widget.appointment['appointment_id'] ,
                                  cname: widget.contactName,
                                  name: "VideoCall",
                                  role: ClientRole.Broadcaster,
                                  dif:startTime.difference(currentTime).inSeconds,
                                ),
                              ),
                            );
                          }
                          else{
                            Fluttertoast.showToast(msg: "Call button will be activated at the scheduled time");
                          }
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
                          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ):InkWell(
      onTap: () {
        print("--------------"+ today.toString());
        if(int.parse(widget.timec)<=22){

          startTime = DateTime(
              int.parse(
                  widget.date.toString().substring(0, 4)),
              int.parse(
                  widget.date.toString().substring(5, 7)),
              int.parse(widget.date
                  .toString()
                  .substring(8, 10)),

              int.parse(
                  moodstatic[int.parse(widget.timec)]
                      .toString()
                      .substring(0, 2)),
              int.parse(
                  moodstatic[int.parse(widget.timec)]
                      .toString()
                      .substring(3, 5)));
          print("PMPMPOMPM"+startTime.toString());
        }
        else{
          if(int.parse(widget.timec)==23||int.parse(widget.timec)==24){
            print("AMAMAMAMA");
            startTime = DateTime(
                int.parse(
                    widget.date.toString().substring(0, 4)),
                int.parse(
                    widget.date.toString().substring(5, 7)),
                int.parse(widget.date
                    .toString()
                    .substring(8, 10)),

                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(0, 2)),
                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(3, 5)));
            print("AMAMAMAMA"+startTime.toString());
          }
          else{
            print("AMAMAMAMA");
            startTime = DateTime(
                int.parse(
                    widget.date.toString().substring(0, 4)),
                int.parse(
                    widget.date.toString().substring(5, 7)),
                int.parse(widget.date
                    .toString()
                    .substring(8, 10)),
                12 +
                    int.parse(
                        moodstatic[int.parse(widget.timec)]
                            .toString()
                            .substring(0, 2)),
                int.parse(
                    moodstatic[int.parse(widget.timec)]
                        .toString()
                        .substring(3, 5)));
            print("AMAMAMAMA"+startTime.toString());
          }
        }
        var currentTime = DateTime.now();
        diff = startTime.difference(currentTime).inMinutes;
        print("________________"+diff.toString());
        Navigator.of(context).push((MaterialPageRoute(
            builder: (context) => Cafe3(
                appointment: widget.appointment,
                photo: widget.photo,
                firstname: widget.contactName,
                gender: widget.gender,
                dif:diff
            ))));
      },
      child: Container(
        //color: Colors.blue[900],
        margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 2,
            right: SizeConfig.screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.date==today.toString().substring(0,10)?
            widget.olddate==widget.date?SizedBox(): Text("TODAY",
          style: GoogleFonts.openSans(
            color: Color(fontColorGray),) ):
           widget.date==tomorrow.toString().substring(0,10)?
            widget.olddate==widget.date?SizedBox():Text("TOMORROW",
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),) ):
          widget.index==0?Text(DateFormat("yMMMMd").format(DateTime.parse(widget.olddate)).toString(),style: GoogleFonts.openSans(
            color: Color(fontColorGray),) ):  widget.olddate==widget.date?SizedBox(height: 0,):Text(DateFormat("yMMMMd").format(DateTime.parse(widget.date)).toString(),
                style: GoogleFonts.openSans(
                  color: Color(fontColorGray),) ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.1,
                  child: Text(
                    "${widget.time}",
                    style: GoogleFonts.openSans(
                        color: Color(fontColorGray), fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.45,
                  child: Text(
                    "${widget.contactName}",
                    style: GoogleFonts.openSans(
                        color: Color(fontColorGray), fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print(widget.timec);
                          await _handleCameraAndMic(Permission.camera);
                          await _handleCameraAndMic(Permission.microphone);
                          // push video page with given channel name
                          if(int.parse(widget.timec)<=22){

                            startTime = DateTime(
                                int.parse(
                                    widget.date.toString().substring(0, 4)),
                                int.parse(
                                    widget.date.toString().substring(5, 7)),
                                int.parse(widget.date
                                    .toString()
                                    .substring(8, 10)),

                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(0, 2)),
                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(3, 5)));
                            print("PMPMPOMPM"+startTime.toString());
                          }
                          else{
                            if(int.parse(widget.timec)==23||int.parse(widget.timec)==24){
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),

                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            else{
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),
                                  12 +
                                      int.parse(
                                          moodstatic[int.parse(widget.timec)]
                                              .toString()
                                              .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                          }
                          var currentTime = DateTime.now();
                           diff = startTime.difference(currentTime).inMinutes;
                          print("________________"+diff.toString());
                          if(diff==0||diff<=0&&diff>=-59){
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
                          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("--------"+ moodstatic[25]);
                          print("--------"+ moodstatic[24]);
                          await _handleCameraAndMic(Permission.camera);
                          await _handleCameraAndMic(Permission.microphone);
                          // push video page with given channel name
                          if(int.parse(widget.timec)<=22){

                            startTime = DateTime(
                                int.parse(
                                    widget.date.toString().substring(0, 4)),
                                int.parse(
                                    widget.date.toString().substring(5, 7)),
                                int.parse(widget.date
                                    .toString()
                                    .substring(8, 10)),

                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(0, 2)),
                                int.parse(
                                    moodstatic[int.parse(widget.timec)]
                                        .toString()
                                        .substring(3, 5)));
                            print("PMPMPOMPM"+startTime.toString());
                          }
                          else{
                            if(int.parse(widget.timec)==25||int.parse(widget.timec)==24){
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),

                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            else{
                              print("AMAMAMAMA");
                              startTime = DateTime(
                                  int.parse(
                                      widget.date.toString().substring(0, 4)),
                                  int.parse(
                                      widget.date.toString().substring(5, 7)),
                                  int.parse(widget.date
                                      .toString()
                                      .substring(8, 10)),
                                  12 +
                                      int.parse(
                                          moodstatic[int.parse(widget.timec)]
                                              .toString()
                                              .substring(0, 2)),
                                  int.parse(
                                      moodstatic[int.parse(widget.timec)]
                                          .toString()
                                          .substring(3, 5)));
                              print("AMAMAMAMA"+startTime.toString());
                            }
                            print("AMAMAMAMA"+startTime.toString());
                          }
                          var currentTime = DateTime.now();
                           diff = startTime.difference(currentTime).inMinutes;
                          print("________________"+diff.toString());
                          if(startTime.difference(currentTime).inSeconds==0||startTime.difference(currentTime).inSeconds<=0&&startTime.difference(currentTime).inSeconds>=-3600){
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallPage(
                                  session: "1",type: "1",
                                  channelName:widget.appointment['appointment_id'] ,
cname: widget.contactName,
                                  name: "VideoCall",
                                  role: ClientRole.Broadcaster,
                                  dif:startTime.difference(currentTime).inSeconds,
                                ),
                              ),
                            );
                          }
                          else{
                            Fluttertoast.showToast(msg: "Call button will be activated at the scheduled time");
                          }
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
                          padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

Future<void> _handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  print(status);
}
