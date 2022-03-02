import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/UI/Articledetail.dart';
import 'package:mental_health/UI/videoplayer.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/models/GetContent.dart';

import 'Audioplayer.dart';

// ignore: must_be_immutable
class SeeMoreExplore extends StatelessWidget {
  final List<ContentsArticle> dataList;
  final String extension;

  SeeMoreExplore({Key key, this.dataList, this.extension}) : super(key: key);

  String imgBasePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";
  AudioPlayerController _playerController = Get.put(AudioPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GridView.builder(
        itemCount: dataList.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 1 / 0.9),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (extension == 'Video') {
                    Get.to(ButterFlyAssetVideo(
                      data: dataList[index],
                    ));
                  } else if (extension == 'Audio') {
                    Get.to(PlayerPage(
                      data: dataList[index],
                    ));
                  } else {
                    Get.to(ArticleDetail(
                      title: dataList[index].title,
                      description: dataList[index].description,
                      id: dataList[index].id,
                      image: dataList[index].photo,
                    ));
                  }
                },
                child: Container(
                  width: SizeConfig.screenWidth * 0.45,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image:
                            NetworkImage(imgBasePath + dataList[index].photo),
                        fit: BoxFit.contain),
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
                        Flexible(
                          child: Text(
                            dataList[index].title,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
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
                ),
              ),
              // Positioned(
              //     top: 0,
              //     right: 5,
              //     child: GetBuilder<AudioPlayerController>(
              //       builder: (controller) {
              //         return IconButton(
              //           onPressed: () async {
              //             SharedPreferences prefs =
              //                 await SharedPreferences.getInstance();
              //             print('CLIENT ID:${prefs.getString("therapistid")}');
              //             if (prefs.getString("therapistid") == null) {
              //               Get.showSnackbar(GetBar(
              //                 message: 'Please First Login',
              //                 duration: Duration(seconds: 2),
              //               ));
              //               return;
              //             }
              //             String response;
              //             print('Status:${controller.isLikeStatus.value}');
              //             if (controller.isLikeStatus.value) {
              //               response =
              //                   await ExploreLikeUnlikeRepo.exploreUnLike(
              //                       dataList[index].id);
              //             } else {
              //               response = await ExploreLikeUnlikeRepo.exploreLike(
              //                   dataList[index].id);
              //             }
              //             if (response != null) {
              //               Get.showSnackbar(GetBar(
              //                 message: response,
              //                 duration: Duration(seconds: 2),
              //               ));
              //             } else {
              //               _playerController.setIsLikeStatus();
              //             }
              //           },
              //           icon: Icon(
              //             controller.isLikeStatus.value
              //                 ? Icons.favorite
              //                 : Icons.favorite_border,
              //             color: Colors.red,
              //           ),
              //         );
              //       },
              //     )),
            ],
          );
        },
      ),
    );
  }
}
