import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/AppointmentModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingAppointmentRepo extends BaseRepository {
  Future<Appointmentmodel> upcomingAppointmentRepo(
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("sdvvs" + prefs.getString("therapistid"));
    var uri ="";
    if(prefs.getString("type")=="Counsellor"){
       uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment/upcoming?counsellor_id=${prefs.getString("therapistid")}';

    }
    else if(prefs.getString("type")=="Listener"){
       uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment/upcoming?listener_id=${prefs.getString("therapistid")}';

    }
    else{
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/appointment/upcoming?therapist_id=${prefs.getString("therapistid")}';

    }
      var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print("hweinnowen");
      print(response.data);
      if (response.data != null) {
        final passEntity = Appointmentmodel.fromJson(response.data);
        return passEntity;
      } else {
        return Appointmentmodel(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
