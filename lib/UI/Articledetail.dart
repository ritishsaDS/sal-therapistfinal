import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health/UI/webview.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDetail extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String description;
  final String bg;
  final String content;
  final String created_by;
  dynamic likedcontent;

  ArticleDetail(
      {Key key,
      this.id,
      this.likedcontent,
      this.bg,
      this.created_by,
      this.title,
      this.image,
      this.description,
      this.content})
      : super(key: key);

  @override
  _EventSummaryState createState() => _EventSummaryState();
}

class _EventSummaryState extends State<ArticleDetail> {
  String basePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";

  RxBool isLike = false.obs;

  @override
  void initState() {
    if (widget.likedcontent == null) {
      widget.likedcontent = [];
    } else {
      if (widget.likedcontent.contains(widget.id.toString())) {
        print("nkldfnklsdvnkl");
        setState(() {
          isLike = true.obs;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Material(
      child: Column(
        children: [
          Container(
            height: Get.height / 2,
            decoration: BoxDecoration(
                color: Color(0xffD8DFE9),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                            widget.bg),
                    fit: BoxFit.fill)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Obx(() => IconButton(
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
                              response =
                                  await ExploreLikeUnlikeRepo.exploreUnLike(
                                      widget.id);
                            } else {
                              response =
                                  await ExploreLikeUnlikeRepo.exploreLike(
                                      widget.id);
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
                            isLike.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isLike.value ? Colors.red : Colors.white,
                          ),
                        ))
                  ],
                ),
                Spacer(),
                Text(
                  widget.title ?? 'N/A',
                  style: TextStyle(fontSize: 22, color: Color(0xff445066)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xffFAFAFA),
                      backgroundImage: NetworkImage(
                        basePath + widget.image,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.created_by,
                      style: TextStyle(fontSize: 14, color: Color(0xff445066)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Expanded(
              child: WebViewClass(
            link: widget.content,
          ))
        ],
      ),
    ));
  }
}
