import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/Dialogs.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/GetTopics.dart';
import 'package:mental_health/data/repo/Updatetherapistprofile.dart';
import 'package:mental_health/models/getlangaugeresponsemodel.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeMain.dart';
import 'Myprofile.dart';

enum Status { LOADING, ERROR, COMPLETE }
List<String> selectedInterestList = [];

class AllAvailableLanguage extends StatefulWidget {
  const AllAvailableLanguage({Key key}) : super(key: key);

  @override
  _ProfessionalInfo1State createState() => _ProfessionalInfo1State();
}

class _ProfessionalInfo1State extends State<AllAvailableLanguage> {
  Langaugeresponsemodel result;
  bool isError = false;
  bool isLoading = false;
  Status status = Status.LOADING;
  List<String> selectedList = [];
  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var createUser = Updatetherapistprofile();
  Future<void> getTopics() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/language';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Langaugeresponsemodel data =
        langaugeresponsemodelFromJson(response.body);
        print('Response :${response.body}');
        print('Response Meta:${data.meta?.status}');
        if (data.meta.status == '200') {
          result = data;
          status = Status.COMPLETE;
          selectedList=selectedInterestList;
          setState(() {});
          return;
        }
        result = null;
        status = Status.ERROR;
      } else {
        result = null;
        status = Status.ERROR;
      }
    } catch (e) {
      print('get topic error :$e');
      result = null;
      status = Status.ERROR;
    }

    setState(() {});
  }

  @override
  void initState() {
    getTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.screenWidth * 0.05,
                  ),
                  child: Text(
                    "Please Select Your Langauge",
                    style: GoogleFonts.openSans(
                        fontSize: SizeConfig.blockSizeVertical * 4,
                        fontWeight: FontWeight.bold,
                        color: Color(fontColorSteelGrey)),
                  ),
                ),

                status == Status.ERROR
                    ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text('Server Error'),
                  ),
                )
                    : status == Status.LOADING
                    ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 10,
                    children: result.languages
                        .map((e) => GestureDetector(
                      onTap: () {
                        if (selectedList.contains(e.id)) {
                          selectedList.remove(e.id);
                        } else {
                          selectedList.add(e.id);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding:
                        EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          e.language ?? 'N/A',
                          style: GoogleFonts.openSans(
                              color: selectedList.isEmpty
                                  ? Color(fontColorGray)
                                  : selectedList.contains(e.id)
                                  ? Colors.white
                                  : Color(fontColorGray),
                              fontSize:
                              SizeConfig.blockSizeVertical *
                                  2),
                          textAlign: TextAlign.center,
                        ),
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: selectedList.isEmpty
                                ? Colors.white
                                : selectedList.contains(e.id)
                                ? Colors.blue
                                : Colors.white,
                            borderRadius:
                            BorderRadius.circular(8),
                            border: Border.all(
                                color: selectedList.isEmpty
                                    ? Color(fontColorGray)
                                    : selectedList
                                    .contains(e.id)
                                    ? Colors.blue
                                    : Color(fontColorGray),
                                width: 1.0)),
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                    ))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            backgroundColor: selectedList.isNotEmpty ? Colors.blue : Colors.grey,
            onPressed: () {
              if (selectedList.isNotEmpty) {
                selectedInterestList = selectedList;
                print(selectedInterestList);

                uploadkyc();
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => HomeMain()));
              } else {
                //toast("Please Select Value first");
              }
            },
          ),
        ));
  }
  Future<void> uploadkyc() async {

    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body={
      "aadhar": "",
      "about":"",
      "bank_account_no": "",
      "bank_account_type": "",
      "bank_name": "",
      "branch_name": "",
      "certificate": "",
      "device_id": "",
      "education":"" ,
      "experience":"",
      "first_name": prefs.getString("firstname"),
      "gender":  "",
      "ifsc": "",
      "phone":"",
      "language_ids":selectedInterestList.toString().replaceAll("]", "").replaceAll("[", ""),
      "last_name": "",
      "linkedin": "",
      "pan": "",
      "payee_name": "",
      "payout_percentage": "",
      "photo": "",
      "price": "",
      "price_3": "",
      "price_5": "",
      "resume": "",
      "timezone": "GMT+5:30",
      "topic_ids": ""
    };

    print(prefs.getString("type"));
    print(body);
    var url='';
    if(prefs.getString("type")=="Therapist"){
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist?therapist_id=${prefs.getString('therapistid')}";
    }
    else if(prefs.getString("type")=="Listener"){
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener?listener_id=${prefs.getString('therapistid')}";
    }
    else{
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor?counsellor_id=${prefs.getString('therapistid')}";
    }
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "accept": "application/json"

    };

    try {
      final response = await put(Uri.parse(url),headers: requestHeaders,



          body:json.encode(body));
      print("bjkb" + response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        Navigator.of(context).pushNamed('/HomeMain');
        print(responseJson);
        // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
        //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);
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
