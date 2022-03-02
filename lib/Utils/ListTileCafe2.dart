import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/UI/Cafe3.dart';
import 'package:mental_health/Utils/SizeConfig.dart';

import 'Colors.dart';
class listTileCafe2 extends StatefulWidget{



    String contactName;
    String time;
    dynamic appointment;
    String photo;
    String gender;
    var date;
    var olddate;
    var index;
listTileCafe2({
      this.contactName,this.index,this.date,this.olddate,this.time,this.photo,this.gender,this.appointment
});
  @override
  _listtilecafe2State createState() => _listtilecafe2State();
}

class _listtilecafe2State extends State<listTileCafe2> {
  var startTime;
  var endtime;
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

      SizeConfig().init(context);
      return widget.index==0?InkWell(
        onTap: () {
          print(widget.photo);
          Navigator.of(context).push((MaterialPageRoute(
              builder: (context) => Cafe3(
                  appointment: widget.appointment,
                  photo: widget.photo==null?"":widget.photo,
                  firstname: widget.contactName,
                  gender: widget.gender==null?"":widget.gender))));
        },
        child: Container(
          //color: Colors.blue[900],
          margin: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical * 2,
              right: SizeConfig.screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.time,
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray), fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.45,
                    child: Text(
                      widget.contactName,
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray), fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.25,
                    height: SizeConfig.blockSizeVertical * 5,
                    alignment: Alignment.center,
                    child: Text(
                      "",
                      style: GoogleFonts.openSans(color: Colors.blue),
                    ),

                  ),
                ],
              ),
            ],
          ),
        ),
      ):InkWell(
        onTap: () {
          print(widget.photo);
          Navigator.of(context).push((MaterialPageRoute(
              builder: (context) => Cafe3(
                  appointment: widget.appointment,
                  photo: widget.photo==null?"":widget.photo,
                  firstname: widget.contactName,
                  gender: widget.gender==null?"":widget.gender))));
        },
        child: Container(
          //color: Colors.blue[900],
          margin: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical * 2,
              right: SizeConfig.screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.time,
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray), fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.45,
                    child: Text(
                      widget.contactName,
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray), fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.25,
                    height: SizeConfig.blockSizeVertical * 5,
                    alignment: Alignment.center,
                    child: Text(
                      "",
                      style: GoogleFonts.openSans(color: Colors.blue),
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
