import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/Updatetherapistprofile.dart';
import 'package:mental_health/models/get_topics_response_model.dart';
import 'package:http/http.dart'as http;
import 'Price1.dart';

bool anxiety = false;
bool relationship = false;
bool depression = false;
bool grief = false;
bool lifeCoaching = false;
bool anger = false;
bool parenting = false;
bool stress = false;
bool motivation = false;
bool others = false;
bool selected = false;
var languagelist = [];
List<String>  topics=[];
List<String> topicdList = [];
enum Status { LOADING, ERROR, COMPLETE }

class ProfessionalInfo1 extends StatefulWidget {
  const ProfessionalInfo1({Key key}) : super(key: key);

  @override
  _ProfessionalInfo1State createState() => _ProfessionalInfo1State();
}

class _ProfessionalInfo1State extends State<ProfessionalInfo1> {

  GetTopicsResponseModel result;
  bool isError = false;
  bool isLoading = false;
  Status status = Status.LOADING;
  List<String> selectedList = [];

  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var createUser = Updatetherapistprofile();
  Future<void> getTopics() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/topic';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        GetTopicsResponseModel data =
        getTopicsResponseModelFromJson(response.body);
        print('Response :${response.body}');
        print('Response Meta:${data.meta?.status}');
        if (data.meta.status == '200') {
          result = data;
          status = Status.COMPLETE;
          selectedList=topicdList;
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
        centerTitle: true,
        title: radioValue.toString() == "Listener"
            ? Text(
                "4/7",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: Color(fontColorSteelGrey),
                ),
              )
            : Text(
                "4/8",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: Color(fontColorSteelGrey),
                ),
              ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:SingleChildScrollView(
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
                "What's your areas of expertise?",
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
                children: result.topics
                    .map((e) => GestureDetector(
                  onTap: () {
                    if (selectedList.contains(e.id)) {
                      print(";josdvdvkok");
                      topics.remove(e.topic);
                      selectedList.remove(e.id);
                      topicdList.remove(e.id);
                    } else {
                      topics.add(e.topic);
                      selectedList.add(e.id);
                      topicdList.add(e.id);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding:
                    EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Text(
                      e.topic ?? 'N/A',
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
            print(topicdList.toString().replaceAll("]", "").replaceAll("[", ""));
            if (radioValue.toString() == "Listener") {

              Navigator.of(context).pushNamed('/Info1');
            } else {
              Navigator.of(context).pushNamed('/ProfessionalInfo2');
            }
          } else
            Fluttertoast.showToast(msg: "Please select your expertise areas");
        },
      ),
    ));
  }
}
