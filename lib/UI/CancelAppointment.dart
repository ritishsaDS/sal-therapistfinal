import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Appointmentcancel.dart';

class CancelAppointment extends StatefulWidget {
  var id;
   CancelAppointment({this.id}) ;

  @override
  _CancelAppointmentState createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  int radioGroup = 1;
  var reason="";
  TextEditingController aboutController = TextEditingController();
bool visible=false;
  @override
  void initState() {
    print(widget.id);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Cancel Appointment",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05),
              child: Text(
                "Please tell us the reason for cancelling the appointment",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    color: Color(fontColorSteelGrey),
                    fontSize: SizeConfig.blockSizeVertical * 2.5),
              ),
            ),
            RadioListTile(
                value: 1,
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  "I have an emergency",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    radioGroup = value;
                    reason="I have an emergency";
                    visible=false;

                  });
                }),
            RadioListTile(
                value: 2,
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  "I am not available at the set time",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    radioGroup = value;
                    reason="I am not available at the set time";
                    visible=false;

                  });
                }),
            RadioListTile(
                value: 3,
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  "I don't want to contact the person",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    radioGroup = value;
                    reason="I don't want to contact the person";
                    visible=false;
                  });
                }),
            RadioListTile(
                value: 4 - 1214,
                groupValue: radioGroup,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  "Other",
                  style: GoogleFonts.openSans(
                    color: Color(fontColorSteelGrey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    radioGroup = value;

                    visible=true;
                  });
                }),
            Visibility(
              visible:visible ,
              maintainState: visible,
              child: Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                //height: SizeConfig.blockSizeVertical * 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: aboutController,
                  decoration: InputDecoration(
                      hintText: "Enter here",
                      hintStyle: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding:
                      EdgeInsets.all(SizeConfig.blockSizeVertical * 1)),
                  maxLines: 3,
                  maxLength: 500,
                  onFieldSubmitted: (term) {
                    setState(() {

                    });
                  },
                  onChanged: (term) {
                    setState(() {
reason=term;
                    });
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/CancelAppointment');
                    },
                    color: Colors.white,
                    minWidth: SizeConfig.screenWidth * 0.4,
                    child: Text(
                      "DON'T",
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
                    onPressed: () {
                      cancelReason();
                      // Fluttertoast.showToast(
                      //     msg: 'Appointment Cancel successfully');
                      //
                      // Navigator.of(context).pushNamed('/');
                    },
                    color: Colors.blue,
                    minWidth: SizeConfig.screenWidth * 0.4,
                    child: Text(
                      "CANCEL",
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
          ],
        ),
      ),
    ));
  }
  void cancelReason() async {
    Map<String, dynamic> data= {
      "cancellation_reason": reason.toString()
    };
    var url;
    setState(() {
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/cancellationreason?appointment_id=${widget.id}&sessions=2";

    });


    try {
      final response = await put(Uri.parse(
          url),body: jsonEncode(data));
      print("bjkb" + response.body.toString());
      print("bjkb"+data.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);


        setState(() {
          cancelAppointment();
        });
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointmentcancel()));

      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  void cancelAppointment() async {
    setState(() {
print(widget.id);
    });

    var url="";
print(url);
SharedPreferences preferences =await SharedPreferences.getInstance();

if(preferences.getString("type")=="Therapist"){
  url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/appointment?appointment_id=${widget.id}";
}
else if(preferences.getString("type")=="Listener"){
  url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/appointment?appointment_id=${widget.id}";
}
else{
  url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment?appointment_id=${widget.id}";
}
    try {
      final response = await delete(Uri.parse(
          url));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);


        setState(() {

        });
        if(responseJson['meta']['status']=="200"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointmentcancel()));
        }
        else{
          showAlertDialog(
            context,
            responseJson['meta']['message'].toString(),
            "",
          );
        }
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
}
