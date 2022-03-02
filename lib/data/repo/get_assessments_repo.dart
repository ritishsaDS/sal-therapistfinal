import 'package:http/http.dart' as http;
import 'package:mental_health/models/get_assessments_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAssessmentsRepo {
  static Future<GetAssessmentsResponseModel> getAssessment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String therapistId = pref.getString('therapistid');
    String url ='';
    if(pref.getString("type")=="Therapist"){
      url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/assessments?therapist_id=$therapistId';

    }
    else if(pref.getString("type")=="Counsellor"){
      url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/assessments?counsellor_id=$therapistId';

    }
    else {
      url='https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener/assessments?listener_id=$therapistId';

    }
    // String url =
    //     'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor/assessments';
  print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return getAssessmentsResponseModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
