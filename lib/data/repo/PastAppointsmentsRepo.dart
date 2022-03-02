import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/UI/Home2.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/AppointmentModal.dart';
import 'package:mental_health/models/PastAppointmentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastAppointmentsRepo extends BaseRepository {
  Future<PassApointment> pastAppointmentRepo(
    BuildContext context,
  ) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var uri =
        '';



    if(prefs.getString("type")=="Therapist"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/appointment/past?therapist_id=${therapistId}';

    }
    else if(prefs.getString("type")=="Listener"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/appointment/past?listener_id=${therapistId}';
    }
    else if(prefs.getString("type")=="Counsellor"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment/past?counsellor_id=${therapistId}';

    }print(uri);
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = PassApointment.fromJson(response.data);
        return passEntity;
      } else {
        return PassApointment(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
