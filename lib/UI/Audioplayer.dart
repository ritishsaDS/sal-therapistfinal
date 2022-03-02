import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mental_health/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:mental_health/models/GetContent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerPage extends StatefulWidget {
  final ContentsArticle data;
  dynamic likedcontent;

  PlayerPage({Key key, this.likedcontent, this.data}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  ContentsArticle data;
  String basePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';
  Size size;

  final audioPlayer = AudioPlayer();

  AudioPlayerController _playerController = Get.put(AudioPlayerController());
  RxBool isLikeStatus = false.obs;
  void initState() {
    super.initState();
    if (widget.likedcontent == null) {
      widget.likedcontent = [];
    } else {
      if (widget.likedcontent.contains(widget.data.contentId)) {
        print("nkldfnklsdvnkl");
        setState(() {
          isLikeStatus = true.obs;
        });
      }
    }
    super.initState();
    _playerController.setCompleteDuration(0);
    _playerController.setIsRepeat(false);

    _playerController.setTotalDuration(100);
    data = widget.data;

    playAudio();
  }

  Future<void> playAudio() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('TherapistId:${preferences.getString('therapistid')}');
    Duration duration = await audioPlayer.setUrl(
      basePath + data.content,
    );
    audioPlayer.play();

    _playerController.setIsPlay(true);

    _playerController.setTotalDuration(duration.inSeconds);

    audioPlayer.createPositionStream().listen((event) {
      _playerController.setCompleteDuration(event.inSeconds);

      if (event.inSeconds >= duration.inSeconds) {
        if (_playerController.isRepeat.value) {
          audioPlayer.seek(Duration());
          return;
        }
        _playerController.setIsPlay(false);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer?.stop();
    audioPlayer?.dispose();

    super.dispose();
  }

  Duration convertIntToDuration(int value) {
    int second = (value % 60).floor();
    int minute = (value / 60).floor();
    int hour = (minute / 60).floor();
    return Duration(hours: hour, minutes: minute, seconds: second);
  }

  String convertDurationString(int value) {
    int second = (value % 60).floor();
    int minute = (value / 60).floor();
    int hours = (minute / 60).floor();
    if (hours == 0) {
      return set0Value(minute) + ':' + set0Value(second);
    } else {
      return set0Value(hours) +
          ':' +
          set0Value(minute) +
          ':' +
          set0Value(second);
    }
  }

  String set0Value(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Image(
                image: NetworkImage(basePath + data.photo),
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
              Positioned(
                left: 0,
                top: 30,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 220,
                  width: Get.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black87,
                        Colors.black87,
                        Colors.black54,
                        Colors.black45,
                        Colors.black38,
                        Colors.black12,
                        Colors.black12.withOpacity(0.0),
                      ])),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 220,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data?.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GetBuilder<AudioPlayerController>(
                            builder: (controller) {
                              return IconButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.getString("cleintid") == null) {
                                    Get.showSnackbar(GetBar(
                                      message: 'Please First Login',
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }
                                  String response;
                                  print(
                                      'Status:${controller.isLikeStatus.value}');
                                  if (isLikeStatus.value) {
                                    response = await ExploreLikeUnlikeRepo
                                        .exploreUnLike(data.contentId);
                                    setState(() {
                                      isLikeStatus = false.obs;
                                    });
                                  } else {
                                    response =
                                        await ExploreLikeUnlikeRepo.exploreLike(
                                            data.contentId);
                                    setState(() {
                                      isLikeStatus = true.obs;
                                    });
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
                                  isLikeStatus.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLikeStatus.value
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      GetBuilder<AudioPlayerController>(
                        builder: (controller) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                                value: controller.completeDuration.value
                                    .toDouble(),
                                min: 0,
                                max: controller.totalDuration.value.toDouble(),
                                onChanged: (value) {
                                  audioPlayer.seek(
                                      convertIntToDuration(value.floor()));
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${convertDurationString(controller.completeDuration.value)}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${convertDurationString(controller.totalDuration.value)}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GetBuilder<AudioPlayerController>(
                            builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () {
                                    // _playerController.setIsPlay(true);
                                    //
                                    // audioPlayer.seek(Duration());
                                    _playerController.setIsRepeat(
                                        !controller.isRepeat.value);
                                  },
                                  child: Image(
                                    image:
                                        AssetImage('assets/icons/Repeat.png'),
                                    color: controller.isRepeat.value
                                        ? Colors.yellow[800]
                                        : Colors.white,
                                  )),
                              InkWell(
                                  onTap: () {
                                    int duration =
                                        controller.completeDuration.value;
                                    int updateDue = duration - 10;
                                    if (updateDue < 0) {
                                      audioPlayer.seek(Duration());
                                      return;
                                    }
                                    audioPlayer
                                        .seek(convertIntToDuration(updateDue));
                                  },
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/backword.png'))),
                              InkWell(
                                  onTap: () {
                                    if (controller.isPlay.value) {
                                      audioPlayer.pause();
                                    } else {
                                      if (controller.completeDuration.value >=
                                          controller.totalDuration.value) {
                                        audioPlayer.seek(Duration());
                                        _playerController.setIsPlay(true);
                                        return;
                                      }
                                      audioPlayer.play();
                                    }
                                    _playerController
                                        .setIsPlay(!controller.isPlay.value);
                                  },
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/${controller.isPlay.value ? "Pause.png" : "Play.png"}'))),
                              InkWell(
                                  onTap: () {
                                    int duration =
                                        controller.completeDuration.value;
                                    int updateDue = duration + 10;
                                    if (updateDue >
                                        controller.totalDuration.value) {
                                      audioPlayer.seek(convertIntToDuration(
                                          controller.totalDuration.value));
                                      _playerController.setIsPlay(false);
                                      return;
                                    }

                                    audioPlayer
                                        .seek(convertIntToDuration(updateDue));
                                  },
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/forword.png'))),
                              Opacity(
                                opacity: 0.6,
                                child: InkWell(
                                    onTap: () {},
                                    child: Image(
                                        image: AssetImage(
                                            'assets/icons/Shuffle.png'))),
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AudioPlayerController extends GetxController {
  RxBool _isRepeat = false.obs;

  RxBool get isRepeat => _isRepeat;

  void setIsRepeat(bool value) {
    _isRepeat = value.obs;
    update();
  }

  RxBool _isLikeStatus = false.obs;

  RxBool get isLikeStatus => _isLikeStatus;

  void setIsLikeStatus() {
    _isLikeStatus.toggle();
    update();
  }

  RxBool _isPlay = false.obs;

  RxBool get isPlay => _isPlay;

  void setIsPlay(bool value) {
    _isPlay = value.obs;
    update();
  }

  RxInt _totalDuration = 100.obs;
  RxInt _completeDuration = 0.obs;

  RxInt get totalDuration => _totalDuration;

  void setTotalDuration(int value) {
    _totalDuration = value.obs;
    update();
  }

  RxInt get completeDuration => _completeDuration;

  void setCompleteDuration(int value) {
    _completeDuration = value.obs;
    update();
  }
}
