import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/UI/Occupation.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/Updatetherapistprofile.dart';
import 'package:mental_health/models/getlangaugeresponsemodel.dart';
import 'package:http/http.dart'as http;
import 'Price1.dart';

List<String> selectedVal = new List();
List<String> selectedlangauge = new List();
Map<String, bool> values = {
  'English': false,
  'Hindi': false,
  'Tamil': false,
  'Gujarati': false,
  'Telugu': false,
  'Urdu': false,
  'Punjabi': false,
  'Bengali': false,
  'Marathi': false,
  'Kannada': false,
  'Odia': false,
  'Malayalam': false,
  'Asamese': false,
  'Maithili': false,
  'Sanskrit': false
};
Map<String, bool> langs = {
  'English': false,
  'Hindi': false,
  'Tamil': false,
  'Gujarati': false,
  'Telugu': false,
  'Urdu': false,
  'Punjabi': false,
  'Bengali': false,
  'Marathi': false,
  'Kannada': false,
  'Odia': false,
  'Malayalam': false,
  'Asamese': false,
  'Maithili': false,
  'Sanskrit': false
};
List<String> languagess=[];
enum Status { LOADING, ERROR, COMPLETE }

class Price3 extends StatefulWidget {
  const Price3({Key key}) : super(key: key);

  @override
  _Price3State createState() => _Price3State();
}

class _Price3State extends State<Price3> {
  bool selected = false;
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
          selectedList=languagess;
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
    // TODO: implement initState
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
                "3/8",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              value: 0.3,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.15,
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child: Text(
                "What languages do you speak?",
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
            ):
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: result.languages.map((key) {
                return new CheckboxListTile(
                  title: Text(key.language),
                  value: values[key.language],
                  onChanged: (bool value) {
                    setState(() {
                      values[key.language] = value;

                      values.forEach((keys, value) {
                       // print('${keys}: ${value}');
                        if (selectedVal.contains(key.id)) {
                          selectedVal.remove(key.id);
                          selectedlangauge.remove(key.language);
                          print(selectedVal);

                          if (value) {}
                          selected = true;
                        }
                        else{
                          selectedVal.add(key.id);
                          selectedlangauge.add(key.language);
                          setState(() {

                          });
                        }
                        setState(() {

                        });
                      });
                    });
                  },
                );
              }).toList(),
            ),
/*            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children: [
                CheckboxListTile(value: engCheckBox, onChanged: (bool val){
                  setState(() {
                    engCheckBox = val;
                    selected = true;
                  });
                },
                 title: Text("English"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: hindiCheckBox, onChanged: (bool val){
                  setState(() {
                    hindiCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Hindi"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: tamilCheckBox, onChanged: (bool val){
                  setState(() {
                    tamilCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Tamil"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: gujaratiCheckBox, onChanged: (bool val){
                  setState(() {
                    gujaratiCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Gujarati"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: teluguCheckBox, onChanged: (bool val){
                  setState(() {
                    teluguCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Telugu"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: urduCheckBox, onChanged: (bool val){
                  setState(() {
                    urduCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Urdu"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: punjabiCheckBox, onChanged: (bool val){
                  setState(() {
                    punjabiCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Punjabi"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: bengaliCheckBox, onChanged: (bool val){
                  setState(() {
                    bengaliCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Bengali"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: marathiCheckBox, onChanged: (bool val){
                  setState(() {
                    marathiCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Marathi"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: kannadaCheckBox, onChanged: (bool val){
                  setState(() {
                    kannadaCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Kannada"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: odiaCheckBox, onChanged: (bool val){
                  setState(() {
                    odiaCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Odia"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: malayalamCheckBox, onChanged: (bool val){
                  setState(() {
                    malayalamCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Malayalam"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: assamCheckBox, onChanged: (bool val){
                  setState(() {
                    assamCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Assamese"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: maithiliCheckBox, onChanged: (bool val){
                  setState(() {
                    maithiliCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Maithili"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
                CheckboxListTile(value: sanskritCheckBox, onChanged: (bool val){
                  setState(() {
                    sanskritCheckBox = val;
                    selected = true;
                  });
                },
                  title: Text("Sanskrit"),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                ),
              ],
            )*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        backgroundColor: selected == true ? Colors.blue : Colors.grey,
        onPressed: () {
          if (selected) if (radioValue.toString() == "Listener") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Occupation()));
          } else {
            Navigator.of(context).pushNamed('/ProfessionalInfo1');
          }
          else
            Fluttertoast.showToast(msg: "Please select language");
        },
      ),
    ));
  }
}
