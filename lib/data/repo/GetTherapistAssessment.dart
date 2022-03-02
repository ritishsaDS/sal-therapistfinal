import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/data/api/ApiEndPoint.dart';
import 'package:mental_health/models/AssessmentModel.dart';

class GetTherapistAssessmentRepo extends BaseRepository {
  Future<AssessmentModel> assessment({
    String assessmentId,
    BuildContext context,
  }) async {
    final uri = '${ApiEndpoint.BaseUrl}assessment?assessment_id=$assessmentId';
    var response = await Dio().get(uri,
        queryParameters: {'assessment_id  ': assessmentId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          followRedirects: false,
        ));
    try {
      if (response.data != null) {
        final passEntity = AssessmentModel.fromJson(response.data);
        return passEntity;
      } else {
        return AssessmentModel(meta: response.data);
      }
    } catch (error, stacktrace) {}
  }
}
