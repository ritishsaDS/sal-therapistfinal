import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/addAvailabilityModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAvailabilityRepo extends BaseRepository {
  static Future<AddAvailabilityResponseModel> addAvailability(
      List<Map<String, dynamic>> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("therapistid");
    print("=========" + jsonEncode(body));
    var uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/availability?therapist_id=$id';
    if (prefs.getString("type") == "Listener") {
      uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/availability?listener_id=$id';
    } else if (prefs.getString("type") == "Therapist") {
      uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/availability?therapist_id=$id';
    }
    else if (prefs.getString("type") == "Counsellor") {
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/availability?counsellor_id=$id';
    }
    print('res code :${uri}');
    var response = await Dio().put(uri,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    print('res code :${response.statusCode}');
    print('response:${response.request.baseUrl}');
    AddAvailabilityResponseModel result =
        AddAvailabilityResponseModel.fromJson(response.data);
    return result;
  }
}
