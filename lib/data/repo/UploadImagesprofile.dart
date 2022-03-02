import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/UI/Price1.dart';
import 'package:mental_health/base/BaseRepository.dart';
import 'package:mental_health/models/UploadImagesModal.dart';

class UploadImagesProfileRepo extends BaseRepository {

  Future<UploadImagesModal> uploadImage(BuildContext context,
      {File image,String type}) async {

    FormData formData = new FormData.fromMap({"type":type == 'Therapist'?"4":type == 'Counsellor'?"1":"2" });
    print(radioValue);
    if (image != null && image != "") {
      var filename = image.path.split('/').last;
      if (!filename.contains(".")) {
        filename = filename + ".jpg";
      }
      formData.files.add(MapEntry("file",
          await MultipartFile.fromFile(image.path, filename: filename)));
    }

    try {
      final response = await dio.post(
          "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/upload",
          data: formData,
          options: Options(
            headers: {
              'content-type': 'multipart/form-data',
              "accept": "application/json"
            },
          ));
      print(response.statusCode);

      final passEntity = UploadImagesModal.fromJson(response.data);
      return passEntity;
    } catch (error, stacktrace) {
      print("error-------"+error);
      return UploadImagesModal();
    }
  }


}
