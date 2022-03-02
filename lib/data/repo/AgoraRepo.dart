

//"https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/agoratoken?appointment_id=bem1njo3cjg7&session=1&type=1"
import 'package:mental_health/models/GetAgoraToken.dart';
import 'package:http/http.dart' as http;

class AgoraRepo {
  static Future<GetAgoraToken> getAgoraToken(String appointmentId, String session, String type) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/agoratoken?appointment_id=$appointmentId&session=$session&type=$type';
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return getAgoraTokenModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}