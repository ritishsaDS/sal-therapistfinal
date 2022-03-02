import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/models/get_assessments_response_model.dart';

import 'assessment_info.dart';

class AssessmentInstruction extends StatefulWidget {
  final Assessment data;

  const AssessmentInstruction({Key key, this.data}) : super(key: key);

  @override
  _AssesmantState createState() => _AssesmantState();
}

class _AssesmantState extends State<AssessmentInstruction> {
  double size = 18;
  Assessment data;
  final List<String> _listViewData = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Assessments Instruction",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  data.title ?? 'N/A',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  data.subtitle ?? 'N/A',
                  style: TextStyle(color: Color(fontColorGray), fontSize: 14),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Text(
                  "Instruction",
                  style: TextStyle(
                      color: Color(fontColorGray),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  data.instruction ?? 'N/A',
                  style: TextStyle(color: Color(fontColorGray), fontSize: 14),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        10,
                        (index) => Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(_listViewData[index]),
                              ],
                            )),
                  )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "STRONGLY\nDISAGREE",
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 12),
                    ),
                    Text(
                      "SOMEWHAT\nDISAGREE",
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 12),
                    ),
                    Text(
                      "STRONGLY\nDISAGREE",
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              MaterialButton(
                color: Color(0xff0066B3),
                height: 48,
                minWidth: Get.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  Get.to(AssessmentInfo(
                    data: data,
                  ));
                },
                child: Text(
                  'START',
                  style: TextStyle(color: Colors.white, letterSpacing: 0.5),
                ),
              ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: RaisedButton(
//                   child: Text("Start"),
//                   textColor: Colors.white,
//                   color: Colors.blue,
//                   onPressed: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => AssesmantDetail(
// // //title:appointments.elementAt(index).title,
// //                                 id: widget.id,
// //                                 title: widget.title,
// //                                 subtitle: widget.subtitle)));
//                   },
//                 ),
//               )
            ],
          ),
        ),
      ),
    );
  }
}
