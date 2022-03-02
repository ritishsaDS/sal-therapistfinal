import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/UI/Home2.dart';
import 'package:mental_health/UI/NotificationScreen.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/DrawerMenu.dart';
import 'package:mental_health/Utils/NavigationBar.dart';
import 'package:mental_health/Utils/SharedPref.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/Utils/TimeAgoWidget.dart';
import 'package:mental_health/constant/AppColor.dart';
import 'package:mental_health/data/repo/GetCounillordetailRepo.dart';
import 'package:mental_health/data/repo/Getlistenerdetailrepo.dart';
import 'package:mental_health/data/repo/UpcomingAppointmentRepo.dart';
import 'package:mental_health/data/repo/getHomeContentRepo.dart';
import 'package:mental_health/data/repo/getTherapistDetailRepo.dart';
import 'package:mental_health/models/AppointmentModal.dart';
import 'package:mental_health/models/GetCounsillormodel.dart';
import 'package:mental_health/models/GetHomeContentModal.dart';
import 'package:mental_health/models/Getlistenermodel.dart';
import 'package:mental_health/models/getTherapistDetailModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Articledetail.dart';
bool isKyc=false;
bool priceset=false;
var image;
Therapist getTherapistData;

class HomeMain extends StatefulWidget {
  const HomeMain({Key key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<void> _launched;
  bool isloading = false;
  var getHomeContent = GetHomePageContentRepo();
  var getHomeContentModal = GetHomeContentModal();
  var upcomintAppointments = UpcomingAppointmentRepo();
  List<Appointment> appointments = new List();
  var first;
  var last;
  var moodstatic = [
    "0:30",
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
  bool isloding = false;
  List<Color> colors = [
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(48, 37, 33, 0.75),
    Color.fromRGBO(42, 138, 163, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
    Color.fromRGBO(0, 90, 100, 0.75),
  ];

  var getprofilecontent = GetTherapistDetailRepo();
  var getlistenercontent = GetListenerDetailRepo();
  var counsellor = GetCounsellorDetailRepo();
  var getprofilemodel = GetTherapistDetailModal();
  var getlistenermodel = GetListenerDetailModal();
  var getCounsellormodel = GetcounsellorDetailModal();
  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("sdvvs" + prefs.getString("therapistid"));
  setState(() {
    first=prefs.getString("firstname");
    last=prefs.getString("lastname");
  });
    //print("klnll"+last);
    // SharedPreferencesTest().saveuserdata("get").then((value) async {
    //   if (value != null && value != "") {
    //     setState(() {
    //       Map userupdateddata = json.decode(value);
    //       getTherapistData = Therapist.fromJson(userupdateddata);
    //     });
    //   }
    // });
  }

  getTherapistId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("sdvvs" + prefs.getString("therapistid"));
    setState(() {
      therapistId = prefs.getString("therapistid");
    });
    SharedPreferencesTest().getTherapistId().then((value) async {
      print("val" + value.toString());
      getHomeContent
          .getHomeContent(
        context: context,
      )
          .then((value) {
        if (value != null) {
          if (value.meta.status == "200") {
            setState(() {
              isloading = false;
              getHomeContentModal = value;
            });
          }
          else {
            print("jkvsdvnklsdvkl");
            setState(() {
              isloading = false;
            });
            showAlertDialog(
              context,
              value.meta.message,
              "",
            );
          }
        }
        else {
          setState(() {
            isloading = false;
          });
          print("jkvsdvnklsdvkl");
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      }).catchError((error) {
        setState(() {
          isloading = false;
        });
        print("jkvsdvnklsdvkl");
        showAlertDialog(
          context,
          error.toString(),
          "",
        );
      });
    });
  }

  @override
  void initState() {
    getTherapistname();
    super.initState();
    isloading = true;
   getUserData();
    getTherapistId();

    upcomintAppointments
        .upcomingAppointmentRepo(
      context,
    )
        .then((value) {
      if (value != null) {
        if (value.meta.status == "200") {
          setState(() {
            isloading = false;
          });
          appointments.addAll(value.appointments);
          //toast(value.meta.message);
          /*  SharedPreferencesTest().checkIsLogin("0");
                                          SharedPreferencesTest()
                                              .saveToken("set", value: value.token);*/

          /*  Navigator.push(context,
              MaterialPageRoute(
                  builder: (conext) {
                    return OTPScreen(
                      phoneNumber: mobileController.text,
                    );
                  }));*/
        } else {
          showAlertDialog(
            context,
            value.meta.message,
            "",
          );
        }
      } else {}
    }).catchError((error) {
      showAlertDialog(
        context,
        error.toString(),
        "",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child = SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/bg/Frame.png'),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        actions: [
                          GestureDetector(
                            onTap: () {
                              Get.to(NotificationsScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 5),
                              child: Icon(
                                Icons.notifications_none_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                           ),
                        child: Text("Hello,",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.blockSizeVertical * 3)),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(" ${first}",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.blockSizeVertical * 3.5)),
                      ),
                      !isKyc?
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/KYC');
                          },
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockSizeVertical * 5,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical,
                            ),
                            decoration: BoxDecoration(
                                color: Color(0XffE4F0F8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Complete your KYC to Start taking bookings",
                              style: GoogleFonts.openSans(
                                  color: Color(backgroundColorBlue),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ):SizedBox(),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed('/KYC');
                      //   },
                      //   child: Container(
                      //     width: SizeConfig.screenWidth,
                      //     height: SizeConfig.blockSizeVertical * 5,
                      //     alignment: Alignment.center,
                      //     margin: EdgeInsets.symmetric(
                      //       horizontal: SizeConfig.screenWidth * 0.05,
                      //       vertical: SizeConfig.blockSizeVertical,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         color: Colors.blueAccent,
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Text(
                      //       "Complete your KYC to Start taking bookings",
                      //       style: GoogleFonts.openSans(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.25),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(65)),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3.5,
                      ),
                      // appointments != null && appointments.length > 0
                      //     ? ListView.builder(
                      //         shrinkWrap: true,
                      //         itemBuilder: (context, index) {
                      //           return appointments != null &&
                      //                   appointments.length > 0
                      //               ? listTileCafe1(
                      //                   context,
                      //                   appointments.elementAt(index).clientId,
                      //                   moodstatic.elementAt(index), () {
                      //                   setState(() {
                      //                     _launched = makePhoneCall();
                      //                   });
                      //                 })
                      //               : Container(
                      //                   child: Center(
                      //                       child: Text(
                      //                     "No Upcoming Appointments",
                      //                     style: TextStyle(color: Colors.black),
                      //                   )),
                      //                 );
                      //         },
                      //         itemCount: appointments.length,
                      //       ):
                      Container(
                        child: Center(
                            child: Text(
                          "No Upcoming Appointments",
                          style: TextStyle(color: Colors.black),
                        )),
                      ),
                      /* Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05,
                          vertical: SizeConfig.blockSizeVertical
                        ),
                        child: Text("UPCOMING APPOINTMENTS",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray)
                        ),),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical * 2
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              listTileAppointment(context, "Kriti Singh", "17:00", (){
                                setState(() {
                                  _launched = makePhoneCall();
                                });
                              }),
                              listTileAppointment(context, "Kriti Singh", "17:00", (){
                                setState(() {
                                  _launched = makePhoneCall();
                                });
                              }),
                            ],
                          )),*/
                      appointments != null && appointments.length > 0
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.05,
                                  vertical: SizeConfig.blockSizeVertical * 2),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Cafe1');
                                },
                                minWidth: SizeConfig.screenWidth,
                                height: SizeConfig.blockSizeVertical * 6,
                                child: Text(
                                  "See All",
                                  style: GoogleFonts.openSans(
                                      color: Color(backgroundColorBlue)),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                      color: Color(backgroundColorBlue)),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical * 2),
                        child: Text(
                          "LEARN",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              color: Color(fontColorGray)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.02,
                            vertical: SizeConfig.blockSizeVertical * 1),
                        child: getHomeContentModal != null &&
                                getHomeContentModal.articles != null &&
                                getHomeContentModal.articles.length > 0
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  /* if(colors.length < getHomeContentModal.articles.length){
                                    colors.addAll(colors);
                                  }*/
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ArticleDetail(
                                                  image:
                                                      "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                                                          getHomeContentModal
                                                              .articles
                                                              .elementAt(index)
                                                              .photo,
                                                  title: getHomeContentModal
                                                      .articles
                                                      .elementAt(index)
                                                      .title,
                                                  bg: getHomeContentModal
                                                      .articles
                                                      .elementAt(index)
                                                      .photo,
                                                  created_by:getHomeContentModal
                                                      .articles
                                                      .elementAt(index)
                                                      .createdBy ,
                                                  content: getHomeContentModal
                                                      .articles
                                                      .elementAt(index)
                                                      .content,
                                                  description:
                                                      getHomeContentModal
                                                          .articles
                                                          .elementAt(index)
                                                          .description)));
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth * 0.4,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: getHomeContentModal != null &&
                                                  getHomeContentModal
                                                          .articles.length >
                                                      0 &&
                                                  getHomeContentModal.articles
                                                          .elementAt(index)
                                                          .photo !=
                                                      null &&
                                                  getHomeContentModal.articles
                                                          .elementAt(index)
                                                          .photo !=
                                                      ""
                                              ? CachedNetworkImageProvider(
                                                  "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                                                      getHomeContentModal
                                                          .articles
                                                          .elementAt(index)
                                                          .photo)
                                              : AssetImage(
                                                  "assets/bg/gridCard1.png",
                                                ),
                                        ),
                                      ),
                                      child: Container(
                                        width: SizeConfig.screenWidth,
                                        padding: EdgeInsets.only(
                                            left: SizeConfig.screenWidth * 0.02,
                                            right:
                                                SizeConfig.screenWidth * 0.02),
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                42, 138, 163, 0.75),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                getHomeContentModal != null &&
                                                        getHomeContentModal
                                                                .articles
                                                                .length >
                                                            0
                                                    ? getHomeContentModal
                                                        .articles
                                                        .elementAt(index)
                                                        .title
                                                    : "",
                                                maxLines: 2,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2),
                                              ),
                                            ),
                                            Text(
                                              timeAgo(DateTime.parse(
                                                  getHomeContentModal.articles
                                                      .elementAt(index)
                                                      .createdAt)),
                                              style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      1.7),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: getHomeContentModal.articles !=
                                            null &&
                                        getHomeContentModal.articles.length > 0
                                    ? getHomeContentModal.articles.length
                                    : 0,
                              )
                            : Container(
                                child: Center(child: Text("No content found")),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      bottomNavigationBar: NavigationBar(
        index: 0,
      ),
    ));

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

  getTherapistname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("sdvvs" + prefs.getString("therapistid"));
    setState(() {
      therapistId = prefs.getString("therapistid");
    });
    if (prefs.getString("type") == "Therapist") {
      getprofilecontent
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
              getprofilemodel = value;
              print(getprofilemodel.accessToken);
              first = getprofilemodel.therapist.firstName;
              last = getprofilemodel.therapist.lastName;

            if(getprofilemodel.therapist.bankAccountNo=="String"||getprofilemodel.therapist.bankAccountNo==""){
              setState(() {
              prefs.setBool("ISKYC", false);
              isKyc=prefs.getBool('ISKYC');
            });}
            else{
              setState(() {
                prefs.setBool("ISKYC", true);
                isKyc=prefs.getBool('ISKYC');
              });
            }
              if(getprofilemodel.therapist.price=="String"||getprofilemodel.therapist.price=="0"){
                setState(() {
                  prefs.setBool("priceset", false);
                  priceset=prefs.getBool('priceset');
                });}
              else{
                setState(() {
                  prefs.setBool("priceset", true);
                  priceset=prefs.getBool('priceset');
                });
              }
              image=getprofilemodel.mediaUrl+getprofilemodel.therapist.photo;
              prefs.setString("BankAccount",getprofilemodel.therapist.bankAccountNo);
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
                image=getCounsellormodel.mediaUrl+getCounsellormodel.counsellor.photo;
                if(getCounsellormodel.counsellor.bankAccountNo=="String"||getCounsellormodel.counsellor.bankAccountNo==""){
                  setState(() {
                    prefs.setBool("ISKYC", false);
                    isKyc=prefs.getBool('ISKYC');
                  });}
                else{
                  setState(() {
                    prefs.setBool("ISKYC", true);
                    isKyc=prefs.getBool('ISKYC');
                  });
                }
                if(getCounsellormodel.counsellor.price=="String"||getCounsellormodel.counsellor.price=="0"){
                  setState(() {
                    prefs.setBool("priceset", false);
                    priceset=prefs.getBool('priceset');
                  });}
                else{
                  setState(() {
                    prefs.setBool("priceset", true);
                    priceset=prefs.getBool('priceset');
                  });
                }
                prefs.setString("BankAccount",getCounsellormodel.counsellor.bankAccountNo);
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
              image=getlistenermodel.mediaUrl+getlistenermodel.listener.photo;
              if(getlistenermodel.listener.bankAccountNo=="String"||getlistenermodel.listener.bankAccountNo==""){
                setState(() {
                  prefs.setBool("ISKYC", false);
                  isKyc=prefs.getBool('ISKYC');
                });}
              else{
                setState(() {
                  prefs.setBool("ISKYC", true);
                  isKyc=prefs.getBool('ISKYC');
                });
              }
              if(getlistenermodel.listener.price=="String"||getlistenermodel.listener.price=="0"){
                setState(() {
                  prefs.setBool("priceset", false);
                  priceset=prefs.getBool('priceset');
                });}
              else{
                setState(() {
                  prefs.setBool("priceset", true);
                  priceset=prefs.getBool('priceset');
                });
              }
              prefs.setString("BankAccount",getlistenermodel.listener.bankAccountNo);
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

}
