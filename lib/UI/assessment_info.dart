import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mental_health/UI/Assesmentdetail.dart';
import 'package:mental_health/models/get_assessments_response_model.dart';

class AssessmentInfo extends StatefulWidget {
  final Assessment data;

  const AssessmentInfo({Key key, this.data}) : super(key: key);

  @override
  _AssessmentInfoState createState() => _AssessmentInfoState();
}

class _AssessmentInfoState extends State<AssessmentInfo> {
  String selectedGender = 'Male';
  GlobalKey<FormState> _formKey = GlobalKey();
  String age;
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: nextBtn(),
      appBar: buildAppBar(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style:
                            TextStyle(color: Color(0xff77849C), fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '* Required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xff77849C), fontSize: 14),
                            hintText: 'Enter Name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Age',
                        style:
                            TextStyle(color: Color(0xff77849C), fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '* Required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          age = value;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xff77849C), fontSize: 14),
                            hintText: 'Enter age in years',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Gender',
                        style:
                            TextStyle(color: Color(0xff77849C), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Male')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Female')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Radio(
                      value: 'Other',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Other')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding nextBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: MaterialButton(
        color: Color(0xff0066B3),
        height: 48,
        minWidth: Get.width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Get.to(AssesmantDetail(
              title: widget.data.title,
              id: widget.data.assessmentId,
              subtitle: widget.data.subtitle,
              age: age,
              name: name,
              gender: selectedGender,
              type: widget.data.type,
            ));
          }
        },
        child: Text(
          'NEXT',
          style: TextStyle(color: Colors.white, letterSpacing: 0.5),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Assessments',
        style: TextStyle(color: Colors.black),
      ),
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 20,
        ),
        onTap: () {
          Get.back();
        },
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
    );
  }
}
