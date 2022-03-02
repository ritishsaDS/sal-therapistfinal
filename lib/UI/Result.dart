import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mental_health/UI/HomeMain.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/models/get_assessment_result_response_model.dart';

class Result extends StatefulWidget {
  final String assessmentId;
  final String therapistId;

  const Result({Key key, this.assessmentId, this.therapistId})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<GetAssessmentsResultResponseModel> getResult() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/assessment/history?assessment_id=${widget.assessmentId}&therapist_id=${widget.therapistId}';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        GetAssessmentsResultResponseModel result =
            getAssessmentsResultResponseModelFromJson(response.body);
        if (result.meta.status == '200') {
          return result;
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print('Get Result ERROR :$e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Result",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        // actions: [
        //   Row(
        //     children: [
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         child: Image.asset(
        //           'assets/icons/download.png',
        //           height: SizeConfig.blockSizeVertical * 3,
        //         ),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         child: Image.asset(
        //           'assets/icons/share.png',
        //           height: SizeConfig.blockSizeVertical * 3,
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MaterialButton(
          color: Color(0xff0066B3),
          height: 48,
          minWidth: Get.width,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeMain()));
            // postAssessment();
          },
          child: Text(
            'Done',
            style: TextStyle(color: Colors.white, letterSpacing: 0.5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     width: SizeConfig.screenWidth,
            //     height: SizeConfig.screenHeight * 0.15,
            //     margin: EdgeInsets.symmetric(
            //         horizontal: SizeConfig.screenWidth * 0.05,
            //         vertical: SizeConfig.blockSizeVertical * 2),
            //     alignment: Alignment.center,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: SizeConfig.blockSizeHorizontal * 5,
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       image: DecorationImage(
            //           image: AssetImage('assets/bg/result tile.png'),
            //           fit: BoxFit.cover),
            //     ),
            //     child: Text(
            //       "You can handle stress at work well!",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: SizeConfig.blockSizeVertical * 3),
            //       textAlign: TextAlign.center,
            //     )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/icons/download.png',
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/icons/share.png',
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: Text(
                "Past Assessment Result",
                style: TextStyle(
                    color: Color(midnightBlue),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2.5),
              ),
            ),
            FutureBuilder<GetAssessmentsResultResponseModel>(
                future: getResult(),
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
                  GetAssessmentsResultResponseModel result = snapshot.data;
                  return Column(
                    children: result.assessmentResults
                        .map((e) => Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.05,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('dd/MM/yyy')
                                                .format(e.createdAt),
                                            style: TextStyle(
                                              color: Color(fontColorSteelGrey),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    3,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5),
                                            child: Image.asset(
                                              'assets/icons/dot.png',
                                              width: SizeConfig
                                                  .blockSizeHorizontal,
                                            ),
                                          ),
                                          Text(
                                            DateFormat.jm().format(e.createdAt),
                                            style: TextStyle(
                                              color: Color(fontColorSteelGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                            width: SizeConfig.screenWidth,
                                            height:
                                                SizeConfig.screenHeight * 0.15,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                vertical: SizeConfig
                                                        .blockSizeVertical *
                                                    2),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/bg/result tile.png'),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Text(
                                              "You can handle stress at work well!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      3),
                                              textAlign: TextAlign.center,
                                            )),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.end,
                                        //   children: [
                                        //     Container(
                                        //       padding: EdgeInsets.all(8),
                                        //       child: Image.asset(
                                        //         'assets/icons/download.png',
                                        //         height: SizeConfig
                                        //                 .blockSizeVertical *
                                        //             3,
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       padding: EdgeInsets.all(8),
                                        //       child: Image.asset(
                                        //         'assets/icons/share.png',
                                        //         height: SizeConfig
                                        //                 .blockSizeVertical *
                                        //             3,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  );
                }),

            // Container(
            //   width: SizeConfig.screenWidth,
            //   margin: EdgeInsets.symmetric(
            //       horizontal: SizeConfig.screenWidth * 0.05,
            //       vertical: SizeConfig.blockSizeVertical),
            //   child: MaterialButton(
            //     onPressed: () {},
            //     height: SizeConfig.blockSizeVertical * 6,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     color: Color(backgroundColorBlue),
            //     child: Text(
            //       "Try Again",
            //       style: TextStyle(
            //           color: Colors.white, fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
