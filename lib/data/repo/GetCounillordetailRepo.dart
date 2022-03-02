import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/UI/MyProfile.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/GetCounsillormodel.dart';
import 'package:mental_health/models/Getlistenermodel.dart';
import 'package:mental_health/models/get_topics_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCounsellorDetailRepo extends BaseRepository {
  Future<GetcounsellorDetailModal> getTherapistDetail({
    String therapistId,
    BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var therapis = prefs.getString('therapistid');
    var type;
    if (prefs.getString("type") == "Therapist") {
      type = "therapist_id";
    }
    else if(prefs.getString("type") == "Counsellor"){
      type = "counsellor_id";
    }
    else {
      type = "listener_id";
      print("hilscjkasc;jk" + type.toString().substring(0, 8));
    }

    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/${prefs.getString("type").toString().toLowerCase()}?${type}=${therapis}';
    print(uri);
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = GetcounsellorDetailModal.fromJson(response.data);
        print(response.data);
        print(response.data);
        var jsonresponse=(response.data);

        Topics=jsonresponse['topics'];
        langauges=jsonresponse['languages'];
        print("jihvdahdvivndvlsn"+Topics.toString());
        return passEntity;
      } else {
        return GetcounsellorDetailModal(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
