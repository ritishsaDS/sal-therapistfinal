import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedEvents extends StatefulWidget {
  @override
  _BookedEventsState createState() => _BookedEventsState();
}

class _BookedEventsState extends State<BookedEvents> {
  bool isError = false;
  bool isLoading = false;
  @override
  void initState() {
    getMyEventy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Eventslist.length == 0
          ? Container(
              child: Center(child: Text("No Book Events")),
            )
          : Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/CafeEventsDetails');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical),
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: Image.network(
                                          "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                                              Eventslist[index]['photo'])
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
                                    color: Color.fromRGBO(42, 138, 163, 0.75),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Eventslist[index]['title'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      Eventslist[index]['duration'] + " mins",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                physics: BouncingScrollPhysics(),
                primary: true,
                itemCount: Eventslist.length,
                shrinkWrap: true,
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
    print(id);
    var url='';
    if(prefs.getString("type")=="Counsellor"){
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/event/booked?counsellor_id=${id}';
;

    }
    else if(prefs.getString("type")=="Therapist"){
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/event/booked?therapist_id=${id}';

    }
    else {
      url= 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/event/booked?listener_id=${id}';

    }
    try {
      final response = await get(Uri.parse(
         url));
      print("bjkb" + url);
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
}
