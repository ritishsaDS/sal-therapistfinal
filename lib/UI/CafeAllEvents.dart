import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/UI/CafeEventsDetails.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeAllevents extends StatefulWidget {
  @override
  _CafeAlleventsState createState() => _CafeAlleventsState();
}

class _CafeAlleventsState extends State<CafeAllevents> {
  List<String> images = [
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg',
    'https://wallpaperaccess.com/full/1691795.jpg',
    'https://luna1.co/020fe1.png',
    'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2019/11/parenting-hacks-1574674152.jpg'
  ];

  List<String> topic = [
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop',
    'Work & Stress Workshop',
    'Mental Health Workshop',
    'Parenting Workshop'
  ];
  var moodstatic = [

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
  bool isError = false;
  bool isLoading = false;
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
    getAllevents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.02,
            vertical: SizeConfig.blockSizeVertical * 2),
        child: ListView(
          children: eventWidget(),
        ));
  }

  dynamic event = new List();
  void getAllevents() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var type;
    if (prefs.getString("type") == "Therapist") {
      type = "therapist";
    }
    else if(prefs.getString("type") == "Listener"){
      type="listener";
    }
    else {
      type = "counsellor";
    }
    print(type);
    try {
      final response = await get(Uri.parse(
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/${type}/events'));
      print("bjkb" + response.request.url.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        event = responseJson['events'];
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

  List<Widget> eventWidget() {
    List<Widget> eventlist = new List();
    for (int i = 0; i < event.length; i++) {
      eventlist.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CafeEventsDetails(id: event[i]['order_id'])));
          },
          child: Container(
            margin:
                EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
            width: SizeConfig.screenWidth * 0.4,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: Image.network(
                          "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                              event[i]['photo'])
                      .image,
                  fit: BoxFit.cover),
            ),
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.25,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.02,
                    right: SizeConfig.screenWidth * 0.02),
                height: SizeConfig.blockSizeVertical * 8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: colors[2],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event[i]['title'],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${DateFormat('EEEE').format(DateTime.parse(event[i]['date'].toString()))}" +
                              ", " +
                              (event[i]['date'].toString().split("-")[2]) +
                              " ${DateFormat('MMMM').format(DateTime.parse(event[i]['date'].toString()))}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeVertical * 1.5),
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          moodstatic[int.parse(event[i]['time'])],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeVertical * 1.8,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "₹" + event[i]['price'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeVertical * 1.8,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return eventlist;
  }
}
