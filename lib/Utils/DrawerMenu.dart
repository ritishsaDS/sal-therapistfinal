import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/UI/Home2.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/GetCounillordetailRepo.dart';
import 'package:mental_health/data/repo/Getlistenerdetailrepo.dart';
import 'package:mental_health/data/repo/getTherapistDetailRepo.dart';
import 'package:mental_health/models/GetCounsillormodel.dart';
import 'package:mental_health/models/Getlistenermodel.dart';
import 'package:mental_health/models/getTherapistDetailModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AlertDialog.dart';
import 'Colors.dart';
import 'SharedPref.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool isloding = false;
  var getHomeContent = GetTherapistDetailRepo();
  var getHomeContentModal = GetTherapistDetailModal();
  var getprofilecontent = GetTherapistDetailRepo();
  var getlistenercontent = GetListenerDetailRepo();
  var getprofilemodel = GetTherapistDetailModal();
  var getlistenermodel = GetListenerDetailModal();
  var getCounsellormodel = GetcounsellorDetailModal();
  var counsellor = GetCounsellorDetailRepo();
  var first;
  var last;
  var profile = 0;
  var type;
  @override
  void initState() {
    getprofile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.28,
              color: Color(backgroundColorBlue),
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: CircleAvatar(
                      radius: SizeConfig.blockSizeVertical * 5,
                      child: getprofilemodel.therapist != null ||
                          getlistenermodel.listener!=null||getCounsellormodel.counsellor!=null

                          ? ClipOval(
                              child: Image.network(

                                    type=="Listener"?getlistenermodel.mediaUrl +getlistenermodel.listener.photo:type=="Counsellor"?getCounsellormodel.mediaUrl +getCounsellormodel.counsellor.photo:getprofilemodel.mediaUrl +getprofilemodel.therapist.photo,

                              ),
                            )
                          : ClipOval(
                              child: Image.network(
                                  'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png'),
                            ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: Text(
                      first.toString() + " " + last.toString(),
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    child: Text(
                      profile == 0
                          ? "Complete your profile (20%)"
                          : profile == 1
                              ? "Complete your profile (40%)"
                              : profile == 2
                                  ? "Complete your profile (60%)"
                                  : profile == 3
                                      ? "Complete your profile (80%)"
                                      : "Profile Completed",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 1.5,
                      left: SizeConfig.screenWidth * 0.2,
                      right: SizeConfig.screenWidth * 0.2,
                    ),
                    child: LinearProgressIndicator(
                      backgroundColor: Color(midnightBlue),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      value: profile == 0
                          ? 0.2
                          : profile == 1
                              ? 0.2
                              : profile == 2
                                  ? 0.6
                                  : profile == 3
                                      ? 0.8
                                      : 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            ListTile(
              title: Text("My Profile"),
              leading: ImageIcon(Image.asset('assets/icons/user.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/MyProfile');
              },
            ),
            ListTile(
              title: Text("My Availability"),
              leading:
                  ImageIcon(Image.asset('assets/icons/availability.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/Availability1');
              },
            ),
            ListTile(
              title: Text("My Content"),
              leading: ImageIcon(Image.asset('assets/icons/content.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/MyContent');
              },
            ),
            ListTile(
              title: Text("Assessments"),
              leading:
                  ImageIcon(Image.asset('assets/icons/assessments.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/Assessments');
              },
            ),
            ListTile(
              title: Text("Payments"),
              leading: ImageIcon(Image.asset('assets/icons/payment.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/Payments');
              },
            ),
            ListTile(
              title: Text("Help"),
              leading: ImageIcon(Image.asset('assets/icons/help.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/Help');
              },
            ),
            ListTile(
              title: Text("About SAL"),
              leading: ImageIcon(Image.asset('assets/icons/about.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/AboutSAL');
              },
            ),
            ListTile(
              title: Text("Settings"),
              leading:
                  ImageIcon(Image.asset('assets/icons/settings.png').image),
              onTap: () {
                Navigator.of(context).pushNamed('/Settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      first = prefs.getString("firstname");
      last = prefs.getString("lastname");
      profile = prefs.getInt("profileval");
      type=prefs.getString("type");
    });
    print("klnll" + last);
    getTherapistId();
    //SharedPrfre
  }

  getTherapistId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString("type");
    });

    if (prefs.getString("type") == "Therapist") {
      getprofilecontent
          .getTherapistDetail(
        context: context,
        //  therapistId: prefs.getString("therapistid")
      )
          .then((value) async {
        if (value != null) {
          print(value.meta.status);
          if (value.meta.status == "200") {
            setState(() async {
              isloding = false;
              print(value.therapist.photo);
              getprofilemodel = value;
              print(getprofilemodel.therapist.education);
              //  print(getprofilemodel.therapist.);
              first = getprofilemodel.therapist.firstName;
              last = getprofilemodel.therapist.lastName;
              print(getprofilemodel.therapist.firstName);
              print(getprofilemodel.therapist.email);

              if (getprofilemodel.therapist.photo.toString() != null) {
                profilevalue = 2;
              }

              if (getprofilemodel.therapist.phone != null) {
                profilevalue = profilevalue + 1;
              }
              if (getprofilemodel.therapist.experience != null) {
                profilevalue = profilevalue + 1;
              }
              if (getprofilemodel.therapist.education != null) {
                profilevalue = profilevalue + 1;
              }

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt("profileval", profilevalue);
            });
          } else {
            setState(() {
              isloding = false;
            });
            showAlertDialog(
              context,
              value.meta.message,
              "",
            );
          }
        } else {
          setState(() {
            isloding = false;
          });
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      }).catchError((error) {
        print("jsfjnksdfjnk");
        setState(() {
          isloding = false;
        });
        // showAlertDialog(
        //   context,
        //   error.toString(),
        //   "",
        // );
      });
    }
    else if(prefs.getString("type") == "Counsellor"){
      {
        counsellor
            .getTherapistDetail(
          context: context,
          //  therapistId: prefs.getString("therapistid")
        )
            .then((value) {
          if (value != null) {
            print(value.meta.status);
            if (value.meta.status == "200") {
              setState(() {
                isloding = false;
                print(value.meta.messageType);
                //SharedPreferences prefs= await SharedPreferences.getInstance();

                getCounsellormodel = value;
                print(getCounsellormodel.accessToken);
                first = getCounsellormodel.counsellor.firstName;
                last = getCounsellormodel.counsellor.lastName;
                print(getCounsellormodel.counsellor.firstName);
                print(getCounsellormodel.counsellor.email);
              });
            } else {
              setState(() {
                isloding = false;
              });
              showAlertDialog(
                context,
                value.meta.message,
                "",
              );
            }
          } else {
            setState(() {
              isloding = false;
            });
            showAlertDialog(
              context,
              value.meta.message,
              "",
            );
          }
        }).catchError((error) {
          setState(() {
            isloding = false;
          });
          showAlertDialog(
            context,
            error.toString(),
            "",
          );
        });
      }
    }

    else {
      getlistenercontent
          .getTherapistDetail(
        context: context,
        //  therapistId: prefs.getString("therapistid")
      )
          .then((value) {
        if (value != null) {
          print(value.meta.status);
          if (value.meta.status == "200") {
            setState(() {
              isloding = false;
              print(value.meta.messageType);
              //SharedPreferences prefs= await SharedPreferences.getInstance();

              getlistenermodel = value;
              print(getlistenermodel.accessToken);
              first = getlistenermodel.listener.firstName;
              last = getlistenermodel.listener.lastName;
              print(getlistenermodel.listener.firstName);
              print(getlistenermodel.listener.photo);
            });
          } else {
            setState(() {
              isloding = false;
            });
            showAlertDialog(
              context,
              value.meta.message,
              "",
            );
          }
        } else {
          setState(() {
            isloding = false;
          });
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      }).catchError((error) {
        setState(() {
          isloding = false;
        });
        showAlertDialog(
          context,
          error.toString(),
          "",
        );
      });
    }

// });}}
  }
}
