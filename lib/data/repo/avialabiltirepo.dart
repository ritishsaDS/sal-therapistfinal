import 'package:dio/dio.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/avalabilitymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Avalabilityrepo extends BaseRepository {
  static Future<AvailabiltiyModel> avialabilityRepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("therapistid");
    print('IDsss:$id');
    var uri='';
    if (prefs.getString("type") == "Therapist"){
       uri =
          'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/availability?therapist_id=$id';

    }
    else if(prefs.getString("type") == "Counsellor"){
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/availability?counsellor_id=$id';

    }
    else {
      uri =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/availability?listener_id=$id';

    }
    print('ers type:${uri}');
     var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    print('ers type:${uri}');
    print('ers:${AvailabiltiyModel.fromJson(response.data)}');
    AvailabiltiyModel result = AvailabiltiyModel.fromJson(response.data);
    return result;
/*
    try {
      if (response.data != null) {
        final passEntity = availabiltiyFromJson(response.data);
        return passEntity;
      } else {
        return response.data;
      }
    } catch (error, stacktrace) {
      print(error);
    }*/
  }
}
