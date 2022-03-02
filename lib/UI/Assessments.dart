import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/get_assessments_repo.dart';
import 'package:mental_health/models/get_assessments_response_model.dart';

import 'AssesmentQuiz.dart';
import 'AssessmentInstruction.dart';

class Assessments extends StatelessWidget {
  String imgBasePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body:
          _buildAssessments(context),



    );
  }

  Widget _buildAssessments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder<GetAssessmentsResponseModel>(
        future: GetAssessmentsRepo.getAssessment(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Server Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          GetAssessmentsResponseModel result = snapshot.data;
          if (result.meta.status != '200') {
            return Center(
              child: Text(result.meta.message ?? 'Assessment not found'),
            );
          }
          return ListView(
            children: result.assessments
                .map((e) => GestureDetector(
                      onTap: () {
                        Get.to(AssessmentInstruction(
                          data: e,
                        ));
                      },
                      child: Container(
                        height: 170,
                        margin: EdgeInsets.only(bottom: 10),
                        width: Get.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imgBasePath + e.photo),
                                fit: BoxFit.fill),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10))),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title ?? 'N/A',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '3-5 mins',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildHistory(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '16/03/21-12:46 pm',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '16/03/21-12:46 pm',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          Spacer(),
          MaterialButton(
            color: Color(backgroundColorBlue),
            minWidth: SizeConfig.screenWidth,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.blue),
            ),
            height: 48,
            child: Text(
              "TRY AGAIN",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 16),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AssesmentQuiz()));
            },
          )
        ],
      ),
    );
  }
}
