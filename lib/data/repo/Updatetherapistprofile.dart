import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/Updateprofilemodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Updatetherapistprofile extends BaseRepository {
  Future<UpdateProfileModel> createCounsellor(
      {String aadhar,
      String about,
      String certificate,
      String device_id,
      String education,
      String email,
      String experience,
      String first_name,
      String gender,
      String language_ids,
      String last_name,
      String linkedin,
      String phone,
      String photo,
      String price,
      String price_3,
      String price_5,
        String multiple_sessions,
      String resume,

      String topic_ids}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url='';
    var id = prefs.getString("therapistid");
    if(prefs.getString("type")=="Therapist"){
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist?therapist_id=${id}";
    }
    else if(prefs.getString("type")=="Counsellor"){
      url= "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor?counsellor_id=${id}";
    }
    else if(prefs.getString("type")=="Listener"){
      url= "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener?listener_id=${id}";
    }

    final response = await dio.put(
url,
        data: {
          "bank_account_no": "",
          "bank_account_type": "",
          "bank_name": "",
          "branch_name": "",
          "photo": photo,
          "aadhar":aadhar,
          "about":about,
"certificate":certificate,
          "device_id": "",
          "education": education,
          "email": email,
          "experience": experience,
          "first_name": first_name,
          "gender": gender,
          "ifsc": "",
          "language_ids": language_ids,
          "last_name": last_name,
          "linkedin": linkedin,
          "pan": "",
          "multiple_sessions":multiple_sessions,
          "payee_name": "",
          "payout_percentage": "",
          "phone": "$phone",
          "price": price,
          "price_3": price_3,
          "price_5": price_5,
          "timezone": "GMT+5:30",
          "topic_ids": topic_ids
        });
    {
      try {
        if (response.statusCode != null) {
          final passEntity = UpdateProfileModel.fromJson(response.data);

          return passEntity;
        } else {
          return UpdateProfileModel(meta: response.data);
        }
      } catch (error, stacktrace) {
        return UpdateProfileModel();
      }
    }
  }
}
