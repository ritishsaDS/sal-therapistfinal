import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/DrawerMenu.dart';
import 'package:mental_health/Utils/ListTileCafe2.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/constant/AppColor.dart';
import 'package:mental_health/data/repo/PastAppointsmentsRepo.dart';
import 'package:mental_health/models/PastAppointmentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cafe2 extends StatefulWidget {
  const Cafe2({Key key}) : super(key: key);
  @override
  _Cafe2State createState() => _Cafe2State();
}

class _Cafe2State extends State<Cafe2> {
  var pastAppointmentsRepo = PastAppointmentsRepo();
  bool isloading = false;
  List<Appointment> appointments = new List();
  List<Client> client = new List();
  var moodstatic = [
    "12:00",
    "12:30",
    "1:00",
    "1:30",
    "2:00",
    "2:30",
    "3:00",
    "3:30",
    "4:00",
    "4:30",
    "5:00",
    "5:30",
    "6:00",
    "6:30",
    "7:00",
    "7:30",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    '20:00',
    '20:30',
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
    "24:00"
  ];
  @override
  void initState() {
    super.initState();

    // upcomintAppointments
    //     .upcomingAppointmentRepo(
    // context,
    // )
    //     .then((value) {
    //       print("value");
    //       print(value);
    //   if (value != null) {
    //     if (value.meta.status == "200") {
    //       setState(() {
    //         isloading = false;
    //       });
    //       print("jnjnjonaeno");
    //       appointments.addAll(value.appointments);
    //       //toast(value.meta.message);
    //       /*  SharedPreferencesTest().checkIsLogin("0");
    //                                       SharedPreferencesTest()
    //                                           .saveToken("set", value: value.token);*/
    //
    //     /*  Navigator.push(context,
    //           MaterialPageRoute(
    //               builder: (conext) {
    //                 return OTPScreen(
    //                   phoneNumber: mobileController.text,
    //                 );
    //               }));*/
    //     } else {
    //       showAlertDialog(
    //         context,
    //         value.meta.message,
    //         "",
    //       );
    //     }
    //   } else {
    //     showAlertDialog(
    //       context,
    //       "No data found",
    //       "",
    //     );
    //   }
    // }).catchError((error) {
    //   showAlertDialog(
    //     context,
    //     error.toString(),
    //     "",
    //   );
    // });
    upcomingAppointmentRepo(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child = SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*     Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("UPCOMING",style: GoogleFonts.openSans(
                    color: Color(0XFF0066B3),
                    fontWeight: FontWeight.w700
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/Cafe2');
                    },
                    child: Text("PAST",style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w600
                    ),),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.45,
                  height: SizeConfig.blockSizeVertical * 0.3,
                  color: Color(backgroundColorBlue),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.45,
                  height: SizeConfig.blockSizeVertical * 0.3,
                  color: Color(fontColorGray),
                ),
              ],
            ),*/

              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              GestureDetector(
                onTap: () {
                  // print(appointments.elementAt(i).time.toString());
                },
                child: Container(
                    height: SizeConfig.blockSizeVertical * 70,
                    child:appointmen.length==0?
                    Center(child: Text("No Past Appointment"),)
                        : ListView(children: homewidget(),)
                ),
              )
            ],
          ),
        ),
        drawer: DrawerMenu(),
      ),
    );
    widgetList.add(child);
    if (isloading) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }



  dynamic appointmen = new List();
  dynamic clients = new List();

  List<Widget> homewidget() {
    List<Widget> homitemlist = new List();
    for (int i = 0; i <appointmen.length; i++) {
      print("hbdk");
      homitemlist.add(listTileCafe2(

        contactName: clients[appointmen[i]['client_id']]
          ['first_name'],
         time: moodstatic[
          int.parse(appointmen[i]['time'])],
        appointment:appointmen[i],
       photo:clients[appointmen[i]['client_id']]
        ['photo'],
       gender: clients[appointmen[i]['client_id']]
        ['gender'],
          date:appointmen[i]['date'] ,

          olddate:i!=0?appointmen[i-1]['date']:appointmen[i]['date']
             ,
      index:i));

    }
    return homitemlist;
  }

  Future<PassApointment> upcomingAppointmentRepo(
      BuildContext context,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri ="";
    print("sdvvs" + prefs.getString("type"));
    if(prefs.getString("type")=="Therapist"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/appointment/past?therapist_id=${prefs.getString("therapistid")}';

    }
    else if(prefs.getString("type")=="Listener"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/appointment/past?listener_id=${prefs.getString("therapistid")}';

    }
    else if(prefs.getString("type")=="Counsellor"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment/past?counsellor_id=${prefs.getString("therapistid")}';

    }


    print("sdvvs" + uri.toString());
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print("hweinnowen");
      print(response.data);
      if (response.data != null) {
        setState(() {
          appointmen = response.data['appointments'];
          clients = response.data['clients'];
          print("=========" + appointmen.toString());
          print("=========" + clients[appointmen[0]['client_id']]
          ['first_name'],);
        });
      } else {
        return PassApointment(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}

