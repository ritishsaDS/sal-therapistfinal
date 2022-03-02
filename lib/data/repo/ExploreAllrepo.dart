import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/Exploreallmodle.dart';

class Explorerepo extends BaseRepository {
  Future<ExploreallModel> avialabilityRepo({
    String therapistId,
    BuildContext context,
  }) async {
    print(therapistId);
    final uri =
        'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist/training?therapist_id="${therapistId}"';
    var response = await Dio().get(uri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    try {
      if (response.data != null) {
        final passEntity = ExploreallModel.fromJson(response.data);
        return passEntity;
      } else {
        return response.data;
      }
    } catch (error, stacktrace) {
      print(error);
    }
  }
}
