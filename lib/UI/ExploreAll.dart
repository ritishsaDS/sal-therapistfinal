import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/UI/Audioplayer.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/NavigationBar.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/Widgets/explorewidget.dart';
import 'package:mental_health/controller/availability_controller.dart';
import 'package:mental_health/models/GetContent.dart';
import 'package:mental_health/models/get_topics_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Articledetail.dart';
import 'SeeMoreExploreList.dart';
import 'likedExploreList.dart';

class ExploreAll extends StatefulWidget {
  @override
  _ExploreAllState createState() => _ExploreAllState();
}

class _ExploreAllState extends State<ExploreAll> {
  List<dynamic> categories = [];
  int selectedIndex = 121;
  GetTopicsResponseModel result;
  var catId;
  Status status = Status.LOADING;
  List<String> selectedList = [];
  @override
  void initState() {
    getTopics();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            upperHeader(),
            Expanded(
                child: selectedIndex == 120
                    ? LikedExploreList()
                    : AllContents(id: catId))
          ],
        ),
      ),
    );
  }

  Container upperHeader() {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeVertical * 5,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 2,
          horizontal: SizeConfig.screenWidth * 0.02),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 121;
                  catId = null;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.blockSizeVertical * 4,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4,
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                    color: selectedIndex != null && selectedIndex == 121
                        ? Color(0xff0066B3)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 3,
                    left: SizeConfig.blockSizeHorizontal),
                child: Text(
                  "All",
                  style: GoogleFonts.openSans(
                      color: selectedIndex != null && selectedIndex == 121
                          ? Colors.white
                          : Color(fontColorSteelGrey)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 120;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.blockSizeVertical * 4,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4,
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                    color: selectedIndex != null && selectedIndex == 120
                        ? Color(0xff0066B3)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 3,
                    left: SizeConfig.blockSizeHorizontal),
                child: Text(
                  "Liked",
                  style: GoogleFonts.openSans(
                      color: selectedIndex != null && selectedIndex == 120
                          ? Colors.white
                          : Color(fontColorSteelGrey)),
                ),
              ),
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      print(selectedIndex);
                      catId = categories[index]['id'];
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 4,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4,
                        vertical: SizeConfig.blockSizeVertical),
                    decoration: BoxDecoration(
                        color: selectedIndex != null && selectedIndex == index
                            ? Color(0xff0066B3)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 3,
                        left: SizeConfig.blockSizeHorizontal),
                    child: Text(
                      categories[index]['category'],
                      style: GoogleFonts.openSans(
                          color: selectedIndex != null && selectedIndex == index
                              ? Colors.white
                              : Color(fontColorSteelGrey)),
                    ),
                  ),
                );
              },
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTopics() async {
    String url =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/meta';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        categories = responseJson['content_categories'];
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
}

class AllContents extends StatefulWidget {
  var id;
  AllContents({this.id});
  @override
  _AllContentsState createState() => _AllContentsState();
}

class _AllContentsState extends State<AllContents> {
  @override
  void initState() {
    super.initState();
  }

  String imgBasePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";
  dynamic liked = new List();

  Future<GetContentsResponseModel> getAllContents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("therapistid");
    try {
      String url =
          "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content?user_id=$userId&category_id=${widget.id}";

      print('CLIENT ID:${prefs.getString("therapistid")}');
      print('URL:$url');

      http.Response response = await http.get(Uri.parse(url));
      print('satus code :${response.statusCode}');
      print('body:${response.body}');
      if (response.statusCode == 200) {
        print(response.body);
        ;
        return getContentsResponseModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetContentsResponseModel>(
        future: getAllContents(),
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
          if (snapshot.data.articles.length == 0 &&
              snapshot.data.audios.length == 0 &&
              snapshot.data.videos.length == 0) {
            return Center(
              child: Text('No Data Found'),
            );
          }

          GetContentsResponseModel result = snapshot.data;

          return SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POPULAR AUDIOS',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 140,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            4,
                            (index) => index == 3
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(SeeMoreExplore(
                                        dataList: result.audios,
                                        extension: 'Audio',
                                      ));
                                    },
                                    child:
                                        seeMoreContainer(result.audios[index]))
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(PlayerPage(
                                          data: result.audios[index],
                                          likedcontent:
                                              result.likedContentIds));
                                    },
                                    child: explorewidget(
                                        articles: result.audios[index],
                                        likedcontent: result.likedContentIds))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      'POPULAR ARTICLES',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 140,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          4,
                              (index) => index == 3
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(SeeMoreExplore(
                                      dataList: result.articles,
                                      extension: 'Articles',
                                    ));
                                  },
                                  child:
                                      seeMoreContainer(result.articles[index]))
                              : GestureDetector(
                                  onTap: () {
                                    Get.to(ArticleDetail(
                                        description:
                                            result.articles[index].description,
                                        image: result.articles[index].photo,
                                        title: result.articles[index].title,
                                        id: result.articles[index].contentId,
                                        bg: result
                                            .articles[index].backgroundPhoto,
                                        content: result.articles[index].content,
                                        created_by:
                                            result.articles[index].createdBy,
                                        likedcontent: result.likedContentIds));
                                  },
                                  child: explorewidget(
                                      articles: result.articles[index],
                                      likedcontent: result.likedContentIds)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   'POPULAR VIDEO',
                    //   style: TextStyle(
                    //       color: Color(0xff77849C),
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w600),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //   height: 140,
                    //   width: Get.width,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: List.generate(
                    //         result.videos.length ,
                    //             (index) => index == result.videos.length
                    //             ? GestureDetector(
                    //             onTap: () {
                    //               Get.to(SeeMoreExplore(
                    //                 dataList: result.videos,
                    //                 extension: 'Video',
                    //               ));
                    //             },
                    //             child: seeMoreContainer(
                    //                 result.videos[index ]))
                    //             : GestureDetector(
                    //             onTap: () {
                    //               Get.to(ButterFlyAssetVideo(
                    //                 data: result.videos[index],
                    //
                    //               ));
                    //             },
                    //             child: explorewidget(articles:result.videos[index]))),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container seeMoreContainer(ContentsArticle e) {
    return Container(
      width: SizeConfig.screenWidth * 0.45,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff0066B3).withOpacity(0.5),
        image: DecorationImage(
            image: NetworkImage(imgBasePath + e.photo), fit: BoxFit.fill),
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'SEE MORE',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
