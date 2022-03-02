import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:mental_health/models/GetContent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Audioplayer.dart';

class ButterFlyAssetVideo extends StatefulWidget {
  final ContentsArticle data;

  const ButterFlyAssetVideo({Key key, this.data}) : super(key: key);

  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<ButterFlyAssetVideo> {
  ContentsArticle data;

  String basePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";
  AudioPlayerController _playerController = Get.put(AudioPlayerController());

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        centerTitle: true,
        title: Text(
          "Videos",
          style: TextStyle(
              color: Color(midnightBlue), fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                basePath + data.content,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${data.title ?? ''}',
                    style: TextStyle(fontSize: 22, color: Color(0xff77849C)),
                  ),
                ),
                GetBuilder<AudioPlayerController>(
                  builder: (controller) {
                    return IconButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        print('CLIENT ID:${prefs.getString("therapistid")}');
                        if (prefs.getString("therapistid") == null) {
                          Get.showSnackbar(GetBar(
                            message: 'Please First Login',
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }
                        String response;
                        print('Status:${controller.isLikeStatus.value}');
                        if (controller.isLikeStatus.value) {
                          response = await ExploreLikeUnlikeRepo.exploreUnLike(
                              data.id);
                        } else {
                          response =
                              await ExploreLikeUnlikeRepo.exploreLike(data.id);
                        }
                        if (response != null) {
                          Get.showSnackbar(GetBar(
                            message: response,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          _playerController.setIsLikeStatus();
                        }
                      },
                      icon: Icon(
                        controller.isLikeStatus.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${data.description ?? ''}',
              style: TextStyle(fontSize: 16, color: Color(0xff77849C)),
            ),
          ],
        ),
      ),
    );
  }
}
