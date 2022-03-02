import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/UI/Editprofile.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/constant/AppColor.dart';
import 'package:mental_health/data/repo/GetCounillordetailRepo.dart';
import 'package:mental_health/data/repo/Getlistenerdetailrepo.dart';
import 'package:mental_health/data/repo/getTherapistDetailRepo.dart';
import 'package:mental_health/models/GetCounsillormodel.dart';
import 'package:mental_health/models/Getlistenermodel.dart';
import 'package:mental_health/models/getTherapistDetailModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllAvialablelanguage.dart';
import 'AllLAnguages.dart';
import 'HomeMain.dart';
dynamic Topics;
dynamic langauges;
class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    getTherapistId();
    getprofile();
    isloding = true;
    // TODO: implement initState
    super.initState();
  }

  bool isloding = false;
  var getHomeContent = GetTherapistDetailRepo();
  var getCounsellormodel = GetcounsellorDetailModal();
  var counsellor = GetCounsellorDetailRepo();
  var getHomeContentModal = GetTherapistDetailModal();
  var getprofilecontent = GetTherapistDetailRepo();
  var getlistenercontent = GetListenerDetailRepo();
  var getprofilemodel = GetTherapistDetailModal();
  var getlistenermodel = GetListenerDetailModal();
  var first;
  var last;
  var type;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child = SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg/my profile bg.png'),
                        fit: BoxFit.cover),
                  ),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.4,
                ),
                Container(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBar(
                            leading: InkWell(
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            elevation: 0.0,
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "My Profile",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                            actions: [
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.getString("type") == "Therapist") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Editprofile(
                                                firstname: getprofilemodel
                                                    .therapist.firstName,
                                                lastname: getprofilemodel
                                                    .therapist.lastName,
                                                image: getprofilemodel
                                                    .therapist.photo,
                                                gender: getprofilemodel
                                                    .therapist.gender,
                                                price: getprofilemodel
                                                    .therapist.price,
                                                email: getprofilemodel
                                                    .therapist.email,
                                                multiplesession:getprofilemodel
                                                    .therapist.multiple_sessions,
                                                photo:
                                                    getprofilemodel.mediaUrl +
                                                        getprofilemodel
                                                            .therapist.photo,
                                                experience: getprofilemodel
                                                    .therapist.experience,
                                                phone: getprofilemodel
                                                    .therapist.phone)));
                                  }
                                  else if(prefs.getString("type") == "Counsellor"){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Editprofile(
                                                firstname: getCounsellormodel
                                                    .counsellor.firstName,
                                                lastname: getCounsellormodel

                                                    .counsellor.lastName,
                                                multiplesession:getCounsellormodel
                                                    .counsellor.multiple_sessions,
                                                image: getCounsellormodel
                                                    .counsellor.photo,
                                                gender: getCounsellormodel
                                                    .counsellor.gender,
                                                price: getCounsellormodel
                                                    .counsellor.price,
                                                email: getCounsellormodel
                                                    .counsellor.email,
                                                experience: getCounsellormodel
                                                    .counsellor.experience,
                                                photo:
                                                getCounsellormodel
                                                    .mediaUrl +
                                                    getCounsellormodel
                                                        .counsellor.photo,
                                                phone: getCounsellormodel
                                                    .counsellor.phone)));
                                  }
                                  else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Editprofile(
                                                firstname: getlistenermodel
                                                    .listener.firstName,
                                                lastname: getlistenermodel

                                                    .listener.lastName,
                                                multiplesession:getlistenermodel
                                                    .listener.multiple_sessions,
                                                photo: getlistenermodel
                                                    .listener.photo,
                                                gender: getlistenermodel
                                                    .listener.gender,
                                                price: getlistenermodel
                                                    .listener.price,
                                                email: getlistenermodel
                                                    .listener.email,
                                                experience: getlistenermodel
                                                    .listener.experience,
                                                phone: getlistenermodel
                                                    .listener.phone)));
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: SizeConfig.screenWidth * 0.05,
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.15),
                              width: SizeConfig.screenWidth * 0.23,
                              height: SizeConfig.screenWidth * 0.23,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                child: type == "Therapist"
                                    ?
                                getprofilemodel.therapist != null &&
                                            getprofilemodel.therapist.photo !=
                                                null &&
                                            getprofilemodel.therapist.photo !=
                                                ""
                                        ? CachedNetworkImage(
                                            imageUrl: getprofilemodel.mediaUrl +
                                                getprofilemodel.therapist.photo,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'assets/bg/profile.png',
                                            fit: BoxFit.fill,
                                          )
                                    : type == "Counsellor"?
                                getCounsellormodel.counsellor != null &&
                                    getCounsellormodel.counsellor.photo !=
                                        null &&
                                    getCounsellormodel.counsellor.photo !=
                                        ""
                                    ? CachedNetworkImage(
                                  imageUrl: getCounsellormodel.mediaUrl +
                                      getCounsellormodel.counsellor.photo,
                                  fit: BoxFit.fill,
                                )
                                    : Image.asset(
                                  'assets/bg/profile.png',
                                  fit: BoxFit.fill,
                                ):


                                getlistenermodel.listener != null &&
                                            getlistenermodel.listener.photo !=
                                                null &&
                                            getlistenermodel.listener.photo !=
                                                ""
                                        ? CachedNetworkImage(
                                            imageUrl: getlistenermodel
                                                    .mediaUrl +
                                                getlistenermodel.listener.photo,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset('assets/bg/profile.png'),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Text(
                              "${first}" + " " + "${last}",
                              style: GoogleFonts.openSans(
                                  color: Color(backgroundColorBlue),
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${type}",
                                  style: GoogleFonts.openSans(
                                    color: Color(fontColorSteelGrey),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Image.asset(
                                  'assets/bg/circle.png',
                                  height: SizeConfig.blockSizeVertical * 0.5,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal,
                                ),
                                Text(
                                  getTherapistData != null &&
                                          getTherapistData.totalRating != null
                                      ? getTherapistData.totalRating
                                      : "",
                                  style: GoogleFonts.openSans(
                                    color: Color(fontColorSteelGrey),
                                  ),
                                ),
                                Image.asset(
                                  'assets/icons/star.png',
                                  height: SizeConfig.blockSizeVertical * 2,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 4),
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: isloding == true
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.blue))
                                          : Text(
                                              type == "Therapist"
                                                  ? getprofilemodel.therapist
                                                              .price ==
                                                          "0"
                                                      ? "500"
                                                      : getprofilemodel
                                                          .therapist.price
                                                          .toString()==null?"0":getprofilemodel
                                                  .therapist.price
                                                  .toString()
                                                  : type == "Counsellor"?
                                              getCounsellormodel.counsellor
                                                  .price ==
                                                  "0"
                                                  ? "500"
                                                  : getCounsellormodel.counsellor
                                                  .price
                                                  .toString()==null?"0":getCounsellormodel.counsellor
                                                  .price
                                                  .toString()
                                                  :getlistenermodel
                                                              .listener.price ==
                                                          null
                                                      ? "0"
                                                      : "${getlistenermodel.listener.price.toString()==null?"0":getlistenermodel.listener.price.toString()}",
                                              style: GoogleFonts.openSans(
                                                  color: Color(
                                                      backgroundColorBlue),
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      4,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                    Text(
                                      "PRICE PER \nSESSION",
                                      style: GoogleFonts.openSans(
                                        color: Color(fontColorGray),
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.5,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 0.2,
                                  height: SizeConfig.blockSizeVertical * 9,
                                  color: Color(0XFFD8DFE9),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      type == "Therapist"
                                          ? getprofilemodel.therapist
                                          .price3 ==
                                          "0"
                                          ? "0"
                                          : getprofilemodel
                                          .therapist.multiple_sessions
                                          .toString()==null?"0":(int.parse(getprofilemodel
                                          .therapist.multiple_sessions)).toString()
                                          .toString()
                                          : type == "Counsellor"?
                                      getCounsellormodel.counsellor
                                          .multiple_sessions ==
                                          "0"
                                          ? "0"
                                          : getCounsellormodel.counsellor
                                          .multiple_sessions
                                          .toString()==null?"0":(int.parse(getCounsellormodel.counsellor
                                          .multiple_sessions
                                          )).toString()
                                          :getlistenermodel
                                          .listener.price3 ==
                                          null
                                          ? "0"
                                          : "${getlistenermodel.listener.price3.toString()==null?"0":(int.parse(getlistenermodel.listener.multiple_sessions)).toString()}",
                                      style: GoogleFonts.openSans(
                                          color: Color(
                                              backgroundColorBlue),
                                          fontSize: SizeConfig
                                              .blockSizeVertical *
                                              4,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "FOLLOW UP \nSESSION",
                                      style: GoogleFonts.openSans(
                                        color: Color(fontColorGray),
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.5,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 4,
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05),
                            child: Text(
                              "ABOUT",
                              style: GoogleFonts.openSans(
                                  color: Color(fontColorGray),
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical,
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05),
                            child: Text(
                              getTherapistData != null && getTherapistData != ""
                                  ? getTherapistData.about
                                  : "",
                              style: GoogleFonts.openSans(
                                  color: Color(fontColorGray),
                                  fontSize:
                                      SizeConfig.blockSizeVertical * 1.75),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2.5,
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "AREA OF EXPERTISE",
                                    style: GoogleFonts.openSans(
                                        color: Color(fontColorGray),
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllLanguage()));

                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Color(fontColorGray),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05,
                                top: SizeConfig.blockSizeVertical),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runSpacing: 5,
                              spacing: 2,
                              children:
                                moodswidget()
                              ,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2.5,
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "LANGUAGES",
                                  style: GoogleFonts.openSans(
                                      color: Color(fontColorGray),
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllAvailableLanguage()));

                                    },
                                    child: Icon(Icons.edit, color: Color(fontColorGray)))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05,
                                top: SizeConfig.blockSizeVertical),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runSpacing: 5,
                              spacing: 2,
                              children: langaugewidget(),


                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
    widgetList.add(child);
    if (isloding) {
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

  void getprofile() {
    isloding = true;

    getTherapistId();
    //SharedPrfre
  }

  getTherapistId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloding=true;
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
              isloding = false;
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
              setState(()  {
                isloding = false;
                print(value.meta.messageType);
                //SharedPreferences prefs= await SharedPreferences.getInstance();

                getCounsellormodel = value;
                print(getCounsellormodel.accessToken);
                first = getCounsellormodel.counsellor.firstName;
                last = getCounsellormodel.counsellor.lastName;
                print(getCounsellormodel.counsellor.firstName);
                print(getCounsellormodel.counsellor.email);
                if (getCounsellormodel.counsellor.photo.toString() != null) {
                  profilevalue = 2;
                }

                if (getCounsellormodel.counsellor.phone != null) {
                  profilevalue = profilevalue + 1;
                }
                if (getCounsellormodel.counsellor.experience != null) {
                  profilevalue = profilevalue + 1;
                }
                if (getCounsellormodel.counsellor.education != null) {
                  profilevalue = profilevalue + 1;
                }

                isloding = false;
                prefs.setInt("profileval", profilevalue);
                print(profilevalue);
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
              print(getlistenermodel.listener.email);
              isloding = false;
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
    print("+++++++++++++++++"+Topics.toString());
  }
  List<Widget> moodswidget() {
    var opacuit = 1.0;
    List<Widget> moodlist = new List();
    for (int i = 0; i < Topics.length; i++) {
      moodlist.add(
        Container(
          height: SizeConfig.blockSizeVertical * 6,
          width: SizeConfig.screenWidth * 0.4,
          alignment: Alignment.center,
          child: Center(
            child: Text(
            Topics[i]['topic'],
              style: GoogleFonts.openSans(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.blockSizeVertical *
                      1.50),
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0XFFE4F0F8),
              borderRadius: BorderRadius.circular(20)),
        ),
      );}
    return moodlist;
  }
  List<Widget> langaugewidget() {
    var opacuit = 1.0;
    List<Widget> moodlist = new List();
    for (int i = 0; i < langauges.length; i++) {
      moodlist.add(
        Container(
          height: SizeConfig.blockSizeVertical * 6,
          width: SizeConfig.screenWidth * 0.4,
          alignment: Alignment.center,
          child: Center(
            child: Text(
              langauges[i]['language'],
              style: GoogleFonts.openSans(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.blockSizeVertical *
                      1.50),
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0XFFE4F0F8),
              borderRadius: BorderRadius.circular(20)),
        ),
      );}
    return moodlist;
  }
// });}}
}
