import 'package:flutter/material.dart';
import 'package:mental_health/UI/Price1.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/data/api/ApiHitter.dart';
import 'package:mental_health/models/CreateCounsellorModal.dart';

import 'CounsellorProfileModel.dart';

class CreateCounsellorProfileRepo extends BaseRepository {
  Future<CreateCounsellorModel> createCounsellor(
      {String aadhar,
        BuildContext context,
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
        String resume,
        String topic_ids}) async {
    print("NFJKLNFN"+aadhar);
    var url =
        "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist";
    if (radioValue == "Listener") {
      url =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener';
    } else if (radioValue == 'Alternative Therapist') {
      url =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist';
    } else {
      url =
      'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor';
    }

    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
        url,
        context: context,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json"
        },
        data: {
          "bank_account_no": "String",
          "bank_account_type": "String",
          "bank_name": "String",
          "branch_name": "String",
          "device_id": "6565RTYES",
          "aadhar":aadhar,
          "certificate":certificate,
          "education": education,
          "email": "",
          "experience": experience,
          "first_name": first_name,
          "gender": gender,
          "ifsc": "String",
          "language_ids": language_ids,
          "last_name": last_name,
          "linkedin": linkedin,
          "pan": "String",
          "payee_name": "String",
          "payout_percentage": "String",
          "phone": "$phone",
          "photo": photo,
          "price": "String",
          "price_3": "String",
          "price_5": "String",
          "timezone": "String",
          "topic_ids": topic_ids
        });
    {
      try {
        if (apiResponse.status) {
          final passEntity =
          CreateCounsellorModel.fromJson(apiResponse.response.data);
          return passEntity;
        } else {
          return CreateCounsellorModel(meta: apiResponse.response.data);
        }
      } catch (error, stacktrace) {
        return CreateCounsellorModel();
      }
    }
  }
}
