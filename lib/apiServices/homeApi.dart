import 'package:flutter/material.dart';
import 'package:infocom_task/apiServices/apiHelper.dart';
import 'package:infocom_task/constants/apiConstant.dart';

class HomeApi {
  dogImagesApi(BuildContext context) async {
    var response;
    var jsonMap;
    var url;
    url = RANDOM_DOG_IMAGES;
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    print(response);
    return response;
  }

//profile
  profileApi(BuildContext context) async {
    var response;
    var jsonMap;
    var url;
    url = PROFILE_SCREEN;
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    print(response);
    return response;
  }
}
