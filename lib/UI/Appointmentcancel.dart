import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';

import 'HomeMain.dart';

class Appointmentcancel extends StatefulWidget{
  @override
  _AppointmentcancelState createState() => _AppointmentcancelState();
}

class _AppointmentcancelState extends State<Appointmentcancel> {
  @override
  void initState() {

    new Future.delayed(
        const Duration(seconds: 2),
            () {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeMain()),
          );
        }
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.3
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icons/circle bg.png'),
                    fit: BoxFit.cover
                ),
                shape: BoxShape.circle
            ),
            width: SizeConfig.screenWidth * 0.5,
            height: SizeConfig.screenHeight * 0.3,
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icons/blue circle bg.png'),
                        fit: BoxFit.cover
                    ),
                    shape: BoxShape.circle
                ),
                child: Image.asset('assets/icons/done.png',
                  scale: SizeConfig.blockSizeVertical * 0.5,)
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          alignment: Alignment.center,
          child: Text("Successfully Cancelled",style: GoogleFonts.openSans(
              fontSize: SizeConfig.blockSizeVertical * 3.5,
              fontWeight: FontWeight.bold,
              color: Color(fontColorSteelGrey)
          ),),
        ),

      ],
    ),);

  }
}