import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/UI/Home2.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/GetPaymentsModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPaymentsRepo extends BaseRepository {
  Future<GetPaymentsModal> getPaymentsRepo({
    BuildContext context,
  }) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var uri ='';
    if(prefs.getString("type")=="Therapist"){
       uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/payment?therapist_id=${therapistId}';

    }
    else
    if(prefs.getString("type")=="Counsellor"){
    uri =
    'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/payment?counsellor_id=${therapistId}';


    }
    else{
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/payment?listener_id=${therapistId}';

    }
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = GetPaymentsModal.fromJson(response.data);
        return passEntity;
      } else {
        return GetPaymentsModal(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
