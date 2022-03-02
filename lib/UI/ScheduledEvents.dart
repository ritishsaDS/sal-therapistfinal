import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:countdown_timer_simple/countdown_timer_simple.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CafeEventsDetails.dart';
import 'Callpage.dart';

class ScheduledEvents extends StatefulWidget {
  @override
  _ScheduledEventsState createState() => _ScheduledEventsState();
}

class _ScheduledEventsState extends State<ScheduledEvents> {
  var moodstatic = [
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
  List<String> images = [
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg',
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg'
  ];
  var buttonText="Starts in :";
  bool isError = false;
  bool isLoading = false;

  List<String> topic = [
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop',
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop'
  ];

  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75)
  ];
  @override
  void initState() {
    getMyEventy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/AddNewEvent');
                },
                minWidth: SizeConfig.screenWidth,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(backgroundColorBlue)),
                ),
                child: Text(
                  "SCHEDULE NEW EVENT",
                  style: TextStyle(
                      color: Color(backgroundColorBlue),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var startTime;
                  print("+---------"+(int.parse(moodstatic[int.parse(Eventslist[index]['time'])].toString().substring(0,1))).toString());

                  if(int.parse(Eventslist[index]['time'])<=22){

                    startTime = DateTime(
                        int.parse(
                            Eventslist[index]['date'].toString().substring(0, 4)),
                        int.parse(
                            Eventslist[index]['date'].toString().substring(5, 7)),
                        int.parse(Eventslist[index]['date']
                            .toString()
                            .substring(8, 10)),

                        int.parse(
                            moodstatic[int.parse(Eventslist[index]['time'])]
                                .toString()
                                .substring(0, 2)),
                        int.parse(
                            moodstatic[int.parse(Eventslist[index]['time'])]
                                .toString()
                                .substring(3, 5)));
                    print("PMPMPOMPM"+startTime.toString());
                  }
                  else{
                    startTime = DateTime(
                        int.parse(
                            Eventslist[index]['date'].toString().substring(0, 4)),
                        int.parse(
                            Eventslist[index]['date'].toString().substring(5, 7)),
                        int.parse(Eventslist[index]['date']
                            .toString()
                            .substring(8, 10)),
                        12 +
                            int.parse(
                                moodstatic[int.parse(Eventslist[index]['time'])]
                                    .toString()
                                    .substring(0, 2)),
                        int.parse(
                            moodstatic[int.parse(Eventslist[index]['time'])]
                                .toString()
                                .substring(3, 5)));
                    print("AMAMAMAMA"+startTime.toString());
                  }
                  var currentTime = DateTime.now();
                  var diff = startTime.difference(currentTime).inMinutes;
                  print(diff);
                  if(diff==0||diff<=0&&diff>=-59){
                    print("jhkbwefjn");
                    buttonText="Join";

                  }
                  else{
                    buttonText="Starts in :";
                  }
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CafeEventsDetails(
                          id:Eventslist[index]['order_id']
                          ,
                          screen:"My Events"
//title:appointments.elementAt(i).title,
                      )));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical
                          ),
                          //width: SizeConfig.screenWidth * 0.4,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: Image.network("https://sal-prod.s3.ap-south-1.amazonaws.com/"+Eventslist[index]['photo']).image,
                                fit: BoxFit.cover
                            ),
                          ),
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.25,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.02,
                                  right: SizeConfig.screenWidth * 0.02
                              ),
                              height: SizeConfig.blockSizeVertical * 8,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: colors[0],
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Eventslist[index]['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("${DateFormat('EEEE').format(DateTime.parse(Eventslist[index]['date'].toString()))}"+", "+(Eventslist[index]['date'].toString().split("-")[2])+" ${DateFormat('MMMM').format(DateTime.parse(Eventslist[index]['date'].toString()))}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: SizeConfig.blockSizeVertical * 1.5
                                        ),),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 2,
                                      ),
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 8,
                                      ),
                                      Text(moodstatic[int.parse(Eventslist[index]['time'])],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 2,
                                      ),
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,),

                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 8,
                                      ),
                                      Text("₹"+Eventslist[index]['price'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DateTime.now().toString().substring(0,10)==Eventslist[index]['date']?diff>0||diff<=0&&diff>=-59

                            ? Container(
                          decoration: BoxDecoration(color:buttonText=="Join"?Colors.white:Color(0xFF0066B3),
                              borderRadius: BorderRadius.circular(10)),

                          child: Card(
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(color: buttonText!="Join"?Colors.white:Color(0xFF0066B3),borderRadius: BorderRadius.circular(10)),


                              child:MaterialButton(
                                elevation: 0,
                                onPressed: () async {
                                  var startTime = DateTime(2021, 12, 10, 11, 30); // TODO: change this to your DateTime from firebase
                                  var currentTime = DateTime.now();
                                  var diff = startTime.difference(currentTime).inMinutes;
                                  print(diff);
                                  if(buttonText=="Join"){
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CallPage(
                                          id:Eventslist[index]['counsellor_id'],
                                          session: "2",type: "1",
                                          channelName: Eventslist[index]['order_id'],
                                          name:"VideoCall",
                                          role: ClientRole.Broadcaster,
                                        ),
                                      ),
                                    );
                                  }
                                },

                                color: buttonText!="Join"?Colors.white: Color(0xFF0066B3),
                                minWidth: SizeConfig.screenWidth ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      buttonText,
                                      style: GoogleFonts.openSans(
                                        color: buttonText!="Join"?Color(0xFF0066B3):Colors.white,
                                      ),
                                    ),
                                    DateTime.now().toString().substring(0,10)==Eventslist[index]['date']?
                                    CountdownTimerSimple(
                                        textStyle: TextStyle(color: Color(0xFF0066B3),fontSize: 14),
                                        endTime: DateTime.now().millisecondsSinceEpoch + 1000 *60*diff ,

                                        onEnd: () {

                                          setState(() {
                                            buttonText="Join";
                                          });
                                          // print(endTime+"Your time is up!");
                                        }
                                    ):SizedBox(),
                                  ],
                                ),

                              ),),
                          ),
                        ):SizedBox():SizedBox()
                      ],
                    ),
                  );
                },
                physics: BouncingScrollPhysics(),
                primary: true,
                itemCount: Eventslist.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic Eventslist = new List();
  Future<void> getMyEventy() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("therapistid");
    var url='';
    if(prefs.getString("type")=="Counsellor"){
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/event/block?counsellor_id=${id}';

    }
    else if(prefs.getString("type")=="Therapist"){
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/event/block?therapist_id=${id}';

    }
    else {
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/event/booked?listener_id=${id}';

    }
    print(id);
    try {
      final response = await get(Uri.parse(url));
      print("bjkb" + response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        Eventslist = responseJson['upcoming_events'];

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  Future<void> onJoin() async {
    // update input validation

    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: "Channel",
          role: ClientRole.Broadcaster,
        ),
      ),
    );
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
