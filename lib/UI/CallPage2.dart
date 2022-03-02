import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/Utils/Agorautils.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/AgoraRepo.dart';
import 'package:mental_health/models/GetAgoraToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*import 'Rating.dart';*/

class CallPage2 extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;
  final String session;
  final String type;

  /// non-modifiable client role of the page
  final ClientRole role;
  var name;
  var id;
  var dif;
  var ctype;
  var counsellorname;

  /// Creates a call page with given channel name.
  CallPage2(
      {Key key,
        this.session,
        this.type,
        this.ctype,
        this.counsellorname,
        this.channelName,
        this.id,
        this.name,
        this.dif,
        this.role})
      : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage2> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool callshow = false;
  RtcEngine _engine;
  String agoraToken;
  var username = "";
  int _uid;
  int minutes;
  String minutesStr = "";
  bool isParent = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _callStart();

    startTimer();
    name();
    String value = widget.dif.toString();
    final withoutSub = value.replaceAll(RegExp('-'), '');
    print(">>>>>>>>>>>>>>>>." + widget.dif.toString());
    print(">>>>>>>>>>>>>>>>." + withoutSub);
    print("Name>>>>>>>>>>" + widget.counsellorname.toString());
    // initialize agora sdk
    initialize();
  }

  Timer _timer;
  int _start = 00000000000;
  var d;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        String value = widget.dif.toString();
        final withoutSub = value.replaceAll(RegExp('-'), '');
        if (_start == 0) {
          setState(() {
            d = Duration(
                days: 0,
                hours: 0,
                minutes: int.parse(withoutSub),
                seconds: _start);
            d.toString();
            _start++;

            print("-------" + _start.toString());
          });
        } else {
          setState(() {
            d = Duration(
                days: 0,
                hours: 0,
                minutes: int.parse(withoutSub),
                seconds: _start);
            d.toString();
            _start++;
            print("-------" + _start.toString());
          });
        }
      },
    );
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _getArogaToken();
    await _waitForToken();
  }

  _waitForToken() async {
    await _initAgoraRtcEngine();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);

    await _engine.joinChannel(agoraToken, widget.channelName, null, _uid);
    _addAgoraEventHandlers();
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onErrorsssss: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Container(height: MediaQuery.of(context).size.height, child: view);
  }

  Widget _videoViewLocal(view) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (!isParent) {
              isParent = true;
            } else {
              isParent = false;
            }
          });
        },
        child: Container(
            alignment: Alignment.topRight,
            height: 150,
            width: 150,
            child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    if(views.length>3) {
      switch (views.length) {
        case 1:
          return Container(
              child: Column(
                children: <Widget>[_videoView(views[0])],
              ));

        case 2:
          return Container(
              child: Stack(
                children: [
                  _videoView(isParent == false
                      ? views[1]
                      : callshow == false
                      ? views[0]
                      : Container(
                    decoration: new BoxDecoration(color: Colors.black),
                  )),

                  /*: Positioned(
              left: 10,
              top: 80,
              child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Text(
                    "Name: " + username.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  )),
            ),*/
                  /*(isParent == false)
                ? Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Text(
                    "Name: " + username.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  )),
            )
                : Positioned(
              left: 10,
              top: 80,
              child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Text(
                    widget.ctype == "4"
                        ? "Therapist" +
                        " Name: " +
                        widget.counsellorname.toString()
                        : widget.ctype ==
                        "2" +
                            " Name: " +
                            widget.counsellorname.toString()
                        ? "Listener"
                        : "Counsellor" +
                        " Name: " +
                        widget.counsellorname.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  )),
            ),*/
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth -
                            SizeConfig.blockSizeHorizontal * 40),
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeHorizontal * 60,
                    child: _videoViewLocal(isParent == false
                        ? callshow == false
                        ? views[0]
                        : Container(
                      decoration: new BoxDecoration(color: Colors.black),
                    )
                        : views[1]),
                  ),
                ],
              ) /*Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        )*/
          );
        case 3:
          return Container(
              child: Column(
                children: <Widget>[
                  _expandedVideoRow(views.sublist(0, 2)),
                  _expandedVideoRow(views.sublist(2, 3))
                ],
              ));
        case 4:
          return Container(
              child: Column(
                children: <Widget>[
                  _expandedVideoRow(views.sublist(0, 2)),
                  _expandedVideoRow(views.sublist(2, 4))
                ],
              ));
        default:
      }
    }else{
      return _myGridView(context, _getRenderViews());
    }

    return Container();
  }

  Widget _myGridView(BuildContext context, List<Widget> list) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: list[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) {
      return Container();
    } else {
      return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RawMaterialButton(
              onPressed: _onTogglecall,
              child: Icon(
                callshow
                    ? Icons.missed_video_call_outlined
                    : Icons.video_call_outlined,
                color: callshow ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: callshow ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
            _start >= 300
                ? RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            )
                : RawMaterialButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Please Wait For Counsellor To Join The call");
              },
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.red[200],
              padding: const EdgeInsets.all(15.0),
            ),
            RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
            // RawMaterialButton(
            //   onPressed: _onSwitchCamera,
            //   child: Icon(
            //     Icons.switch_camera,
            //     color: Colors.blueAccent,
            //     size: 20.0,
            //   ),
            //   shape: CircleBorder(),
            //   elevation: 2.0,
            //   fillColor: Colors.white,
            //   padding: const EdgeInsets.all(12.0),
            // )
          ],
        ),
      );
    }
  }

  /// Info panel to show logs
  /*Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }*/

  void _onCallEnd(BuildContext context) {
    setState(() {
      _timer.cancel();
      _callEnd();
    });
    Navigator.pop(context);
/*
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Rating(appointmentid: widget.channelName,counsellorid:widget.id ,)));
*/
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onTogglecall() {
    setState(() {
      callshow = !callshow;
    });
    if (callshow) {
      _engine.enableLocalVideo(false);
    } else {
      _engine.enableLocalVideo(true);
    }
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name == "Call") {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: <Widget>[
              // _viewRows(),
              //_panel(),
              _toolbar(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              _viewRows(),
              // _panel(),
              _toolbar(),
              Positioned(
                  left: 10,
                  top: 35,
                  child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Text(
                        d.toString().substring(0, 7),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ))),
              Positioned(
                  left: 10,
                  top: 80,
                  child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Text(
                        isParent == false
                            ? "Name: " + username.toString()
                            : widget.ctype == "4"
                            ? "Therapist" +
                            " Name: " +
                            widget.counsellorname.toString()
                            : widget.ctype ==
                            "2" +
                                " Name: " +
                                widget.counsellorname.toString()
                            ? "Listener"
                            : "Counsellor" +
                            " Name: " +
                            widget.counsellorname.toString(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ))),
              (_getRenderViews().length == 2)
                  ? Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Text(
                      isParent == false
                          ? widget.ctype == "4"
                          ? "Therapist" +
                          " Name: " +
                          widget.counsellorname.toString()
                          : widget.ctype ==
                          "2" +
                              " Name: " +
                              widget.counsellorname.toString()
                          ? "Listener"
                          : "Counsellor" +
                          " Name: " +
                          widget.counsellorname.toString()
                          : "Name: " + username.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    )),
              )
                  : Container(),
            ],
          ),
        ),
      );
    }
  }

  _getArogaToken() async {
    GetAgoraToken getAgoraToken = await AgoraRepo.getAgoraToken(
        widget.channelName, widget.session, widget.type);
    print("New Token>>>>>>>${getAgoraToken.token}");
    agoraToken = getAgoraToken.token;
    _uid = int.parse(getAgoraToken.UID);
  }

  _callStart() async {
    //await AgoraRepo.startCallAgora(widget.channelName);
  }

  _callEnd() async {
    // await AgoraRepo.endCallAgora(widget.channelName);
  }

  name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("name");
    });
  }
}