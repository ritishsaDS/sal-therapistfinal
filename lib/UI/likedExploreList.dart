import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/Widgets/ExploreWidgets.dart';
import 'package:mental_health/models/LIkeresponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LikedExploreList extends StatelessWidget {
  String url =
      "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content/like?user_id=";
  String imgBasePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";

  Future<LikedExploreListResponseModel> getLikedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('CLIENT ID:${prefs.getString("therapistid")}');
    print('URL:${url + prefs.getString("therapistid")}');
    try {
      http.Response response =
          await http.get(Uri.parse(url + prefs.getString("therapistid")));
      print('satus code :${response.statusCode}');
      print('body:${response.body}');
      if (response.statusCode == 200) {
        return likedExploreListResponseModelFromJson(response.body);
      } else {
        return null;
        // Get.showSnackbar(GetBar(
        //   message: 'Liked data not found',
        //   duration: Duration(seconds: 2),
        // ));
      }
    } catch (e) {
      // Get.showSnackbar(GetBar(
      //   message: 'Liked data not found',
      //   duration: Duration(seconds: 2),
      // ));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: getLikedList(),
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
          if (snapshot.data == null) {
            return Center(
              child: Text('Server Error'),
            );
          }
          LikedExploreListResponseModel response = snapshot.data;
          if (response.videos.isEmpty &&
              response.audios.isEmpty &&
              response.articles.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: Get.height / 3),
                child: Text('No have any liked data'),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                response.videos.isEmpty ? SizedBox() : popularVideoText(),
                response.videos.isEmpty
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.02,
                            vertical: SizeConfig.blockSizeVertical),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.2,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              response.videos.map((e) => showData(e)).toList(),
                        ),
                      ),
                response.audios.isEmpty ? SizedBox() : popularAudioText(),
                response.audios.isEmpty
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.02,
                            vertical: SizeConfig.blockSizeVertical),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.2,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              response.audios.map((e) => showData(e)).toList(),
                        ),
                      ),
                response.articles.isEmpty ? SizedBox() : popularArticles(),
                response.articles.isEmpty
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.02,
                            vertical: SizeConfig.blockSizeVertical),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.2,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: response.articles
                              .map((e) => showData(e))
                              .toList(),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container showData(Article e) {
    return Container(
      width: SizeConfig.screenWidth * 0.45,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: NetworkImage(imgBasePath + e.photo), fit: BoxFit.fitWidth),
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02),
        height: SizeConfig.blockSizeVertical * 8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.title ?? '',
              style: GoogleFonts.openSans(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              "3m",
              style: GoogleFonts.openSans(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
