import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/UI/Result.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/models/get_assessment_que_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum STATUS { LOADING, ERROR, COMPLETE }

class AssesmantDetail extends StatefulWidget {
  final String id;
  final String title;
  final String subtitle;
  final String name;
  final String age;
  final String gender;
  final String type;

  const AssesmantDetail(
      {this.id,
      this.title,
      this.subtitle,
      this.name,
      this.age,
      this.gender,
      this.type});
  @override
  _AssesmantState createState() => _AssesmantState();
}

class _AssesmantState extends State<AssesmantDetail> {
  bool isAddLoading = false;
  STATUS status = STATUS.LOADING;
  GetAssessmentsQueResponseModel result;
  Map<String, String> selectedQueOption = {};

  @override
  void initState() {
    getAssessmentQuestion();
    super.initState();
  }

  Future<void> postAssessment(List<Map<String, String>> detail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String phone = pref.getString('phone');
    String therapistId = pref.getString('therapistid');
    print('Phone:$phone');
    print('Therapist Id:$therapistId');
    Map<String, dynamic> body = {
      "age": widget.age,
      "assessment_id": widget.id,
      "details": detail,
      "gender": widget.gender,
      "name": widget.name,
      "phone": phone,
      "user_id": therapistId
    };
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/assessment';
    print('URL : $url');
    print('BODY REQ :${jsonEncode(body)}');
    setState(() {
      isAddLoading = true;
    });
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      setState(() {
        isAddLoading = false;
      });
      print('Status Code :${response.statusCode}');
      print('Response :${response.body}');
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        if (result['meta']['status'] == '200') {
          selectedQueOption.clear();
          setState(() {});
          Get.to(Result(
            therapistId: therapistId,
            assessmentId: widget.id,
          ));
          print(result['assessment_result_id']);
        }
      }
    } catch (e) {
      setState(() {
        isAddLoading = false;
      });
      print('Post Assessment Error :$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Assessments Detail",
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
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      widget.subtitle,
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: status == STATUS.LOADING
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : status == STATUS.ERROR
                            ? Center(
                                child: Text('Server Error '),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: ListView(
                                  //  physics: NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      result.questions.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Question ${index + 1}',
                                                  style: TextStyle(
                                                      color:
                                                          Color(fontColorGray),
                                                      fontSize: 14),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(result
                                                      .questions[index]
                                                      .question),
                                                ),
                                                widget.type == '1'
                                                    ? result
                                                                .questionOptions[result
                                                                    .questions[
                                                                        index]
                                                                    .assessmentQuestionId]
                                                                .length ==
                                                            5
                                                        ? questionType3(index)
                                                        : questionType1(index)
                                                    : widget.type == '2'
                                                        ? questionType2(index)
                                                        : questionType3(index)
                                              ],
                                            ),
                                          )),
                                ),
                              ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      color: Color(0xff0066B3),
                      height: 48,
                      minWidth: Get.width,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        if (result != null) {
                          print('QUESTION LENGTH :${result.questions.length} ');
                          print(
                              'SELECTED QUESTION Length:${selectedQueOption.values.length}');
                          if (result.questions.length !=
                              selectedQueOption.values.length) {
                            Get.showSnackbar(GetBar(
                              message: 'Please attend all question',
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                          List<Map<String, String>> detail = [];
                          selectedQueOption.keys.forEach((element) {
                            QuestionOption question =
                                result.questionOptions[element].firstWhere(
                                    (e) =>
                                        e.option == selectedQueOption[element],
                                    orElse: () => null);
                            if (question != null) {
                              detail.add({
                                "assessment_question_id":
                                    question.assessmentQuestionId,
                                "assessment_question_option_id":
                                    question.assessmentQuestionOptionId,
                                "score": question.score
                              });
                            }
                          });
                          log('LIST DETAIL:$detail');
                          log('LIST DETAIL LENGTH:${detail.length}');
                          postAssessment(detail);
                        }
                      },
                      child: Text(
                        'DONE',
                        style:
                            TextStyle(color: Colors.white, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
              isAddLoading
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black26,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Column questionType2(int index) {
    return Column(
      children:
          result.questionOptions[result.questions[index].assessmentQuestionId]
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            String queId =
                                result.questions[index].assessmentQuestionId;
                            setState(() {
                              if (selectedQueOption.containsKey(queId)) {
                                selectedQueOption[queId] = e.option;
                              } else {
                                selectedQueOption.addAll({queId: e.option});
                              }
                            });
                          },
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                                color: selectedQueOption.isEmpty
                                    ? Colors.grey
                                    : selectedQueOption.containsKey(result
                                            .questions[index]
                                            .assessmentQuestionId)
                                        ? selectedQueOption[result
                                                    .questions[index]
                                                    .assessmentQuestionId] ==
                                                e.option
                                            ? Colors.blue
                                            : Colors.grey
                                        : Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '${e.option}',
                            style: TextStyle(
                                color: selectedQueOption.isEmpty
                                    ? Colors.grey
                                    : selectedQueOption.containsKey(result
                                            .questions[index]
                                            .assessmentQuestionId)
                                        ? selectedQueOption[result
                                                    .questions[index]
                                                    .assessmentQuestionId] ==
                                                e.option
                                            ? Colors.blue
                                            : Colors.grey
                                        : Colors.grey,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
    );
  }

  Column questionType1(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                10,
                (subIndex) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              String queId =
                                  result.questions[index].assessmentQuestionId;
                              setState(() {
                                if (selectedQueOption.containsKey(queId)) {
                                  selectedQueOption[queId] =
                                      (subIndex + 1).toString();
                                } else {
                                  selectedQueOption.addAll(
                                      {queId: (subIndex + 1).toString()});
                                }
                              });
                            },
                            child: Container(
                              height: selectedQueOption.isEmpty
                                  ? 15
                                  : selectedQueOption.containsKey(result
                                          .questions[index]
                                          .assessmentQuestionId)
                                      ? selectedQueOption[result
                                                  .questions[index]
                                                  .assessmentQuestionId] ==
                                              (subIndex + 1).toString()
                                          ? 18
                                          : 15
                                      : 15,
                              width: selectedQueOption.isEmpty
                                  ? 15
                                  : selectedQueOption.containsKey(result
                                          .questions[index]
                                          .assessmentQuestionId)
                                      ? selectedQueOption[result
                                                  .questions[index]
                                                  .assessmentQuestionId] ==
                                              (subIndex + 1).toString()
                                          ? 18
                                          : 15
                                      : 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: (selectedQueOption.isEmpty
                                      ? Colors.grey
                                      : selectedQueOption.containsKey(result
                                              .questions[index]
                                              .assessmentQuestionId)
                                          ? selectedQueOption[result
                                                      .questions[index]
                                                      .assessmentQuestionId] ==
                                                  (subIndex + 1).toString()
                                              ? Colors.blue
                                              : Colors.grey
                                          : Colors.grey),
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${subIndex + 1}',
                            style: TextStyle(
                                color: Color(0xff77849C), fontSize: 12),
                          ),
                        ],
                      ),
                    )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Strongly\nDisagree',
              'Somewhat\nAgree',
              'Strongly\nAgree'
            ]
                .map((e) => Text(
                      e,
                      style: TextStyle(color: Color(0xff77849C), fontSize: 11),
                      textAlign: TextAlign.center,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Column questionType3(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                5,
                (subIndex) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              String queId =
                                  result.questions[index].assessmentQuestionId;
                              setState(() {
                                if (selectedQueOption.containsKey(queId)) {
                                  selectedQueOption[queId] =
                                      (subIndex + 1).toString();
                                } else {
                                  selectedQueOption.addAll(
                                      {queId: (subIndex + 1).toString()});
                                }
                              });
                            },
                            child: Container(
                              height: selectedQueOption.isEmpty
                                  ? 15
                                  : selectedQueOption.containsKey(result
                                          .questions[index]
                                          .assessmentQuestionId)
                                      ? selectedQueOption[result
                                                  .questions[index]
                                                  .assessmentQuestionId] ==
                                              (subIndex + 1).toString()
                                          ? 18
                                          : 15
                                      : 15,
                              width: selectedQueOption.isEmpty
                                  ? 15
                                  : selectedQueOption.containsKey(result
                                          .questions[index]
                                          .assessmentQuestionId)
                                      ? selectedQueOption[result
                                                  .questions[index]
                                                  .assessmentQuestionId] ==
                                              (subIndex + 1).toString()
                                          ? 18
                                          : 15
                                      : 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: (selectedQueOption.isEmpty
                                      ? Colors.grey
                                      : selectedQueOption.containsKey(result
                                              .questions[index]
                                              .assessmentQuestionId)
                                          ? selectedQueOption[result
                                                      .questions[index]
                                                      .assessmentQuestionId] ==
                                                  (subIndex + 1).toString()
                                              ? Colors.blue
                                              : Colors.grey
                                          : Colors.grey),
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${subIndex + 1}',
                            style: TextStyle(
                                color: Color(0xff77849C), fontSize: 12),
                          ),
                        ],
                      ),
                    )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Strongly\nDisagree',
              'Somewhat\nAgree',
              'Strongly\nAgree'
            ]
                .map((e) => Text(
                      e,
                      style: TextStyle(color: Color(0xff77849C), fontSize: 11),
                      textAlign: TextAlign.center,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Future<void> getAssessmentQuestion() async {
    print(widget.id);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String therapistId = pref.getString('therapistid');
      final String url =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/assessment?assessment_id=${widget.id}';
      print('URL:$url');
      print('Therapist Id :$therapistId');
      final response = await get(Uri.parse(url));
      print('STATUS CODE :${response.statusCode}');
      // print('Response :${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          status = STATUS.COMPLETE;
        });
        GetAssessmentsQueResponseModel data =
            getAssessmentsQueResponseModelFromJson(response.body);
        result = data;
      } else {
        setState(() {
          status = STATUS.ERROR;
        });
      }
    } catch (e) {
      print('get question ERROR :$e');
      setState(() {
        status = STATUS.ERROR;
      });
    }
  }
}
