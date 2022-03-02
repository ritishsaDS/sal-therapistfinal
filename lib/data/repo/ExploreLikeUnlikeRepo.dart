import 'package:dio/dio.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreLikeUnlikeRepo extends BaseRepository {
  static Future<dynamic> exploreLike(String contentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Therapist Id :${prefs.getString("therapistid")}');
    print('contentId :$contentId');
    String therapistId = prefs.getString("therapistid") ?? 'demo';
    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content/like?user_id=$therapistId&content_id=$contentId';
    print(
        'LIKE URL: https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content/like?user_id=$therapistId&content_id=$contentId');
    var response = await Dio().post(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('Response :${response.data}');
      if (response.statusCode != 200) {
        return null;
      } else {
        if (response.data['meta']['status'] != '200') {
          return response.data['meta']['message'];
        }
        return null;
      }
    } catch (error) {
      print('ERROR :$error');
      return "Like UnSuccess";
    }
  }

  static Future<String> exploreUnLike(String contentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Therapist Id :${prefs.getString("therapistid")}');
    print('contentId :$contentId');
    String therapistId = prefs.getString("therapistid") ?? 'demo';
    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content/like?user_id=$therapistId&content_id=$contentId';
    print(
        'UNLIKE URL: https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content/like?user_id=$therapistId&content_id=$contentId');

    var response = await Dio().delete(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      print('Response :${response.data}');

      if (response.statusCode != 200) {
        return "UnLike UnSuccess";
      } else {
        if (response.data['meta']['status'] != '200') {
          return response.data['meta']['message'];
        }
        return null;
      }
    } catch (error) {
      print('ERROR :$error');
      return "UnLike UnSuccess";
    }
  }
}
