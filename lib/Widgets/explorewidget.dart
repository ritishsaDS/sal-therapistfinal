import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mental_health/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class explorewidget extends StatefulWidget {
  dynamic articles;
  dynamic likedcontent;
  explorewidget({this.articles, this.likedcontent});
  @override
  _explorewidgetState createState() => _explorewidgetState();
}

class _explorewidgetState extends State<explorewidget> {
  RxBool isLike = false.obs;
  String imgBasePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";
  @override
  void initState() {
    // TODO: implement initState
    print("articles:" + widget.articles.contentId.toString());
    if (widget.likedcontent == null) {
      widget.likedcontent = [];
    } else {
      if (widget.likedcontent.contains(widget.articles.contentId.toString())) {
        print("nkldfnklsdvnkl");
        setState(() {
          isLike = true.obs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Stack(
        children: [
          Container(
            height: 140,
            width: 190,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(imgBasePath + widget.articles.photo),
                    fit: BoxFit.fill)),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.articles.title ?? ''}',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 5,
            child: Obx(() => IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.getString("therapistid") == null) {
                      Get.showSnackbar(GetBar(
                        message: 'Please First Login',
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }
                    String response;

                    if (isLike.value) {
                      response = await ExploreLikeUnlikeRepo.exploreUnLike(
                          widget.articles.contentId.toString());
                    } else {
                      response = await ExploreLikeUnlikeRepo.exploreLike(
                          widget.articles.contentId.toString());
                    }
                    if (response != null) {
                      Get.showSnackbar(GetBar(
                        message: response,
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      isLike.toggle();
                    }
                  },
                  icon: Icon(
                    isLike.value ? Icons.favorite : Icons.favorite_border,
                    color: isLike.value ? Colors.red : Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
