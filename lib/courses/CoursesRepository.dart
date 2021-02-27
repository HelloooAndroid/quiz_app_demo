import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiz_app_demo/models/CoursesModel.dart';

class CoursesRepository {

  Future<CoursesModel> fetchCoursesList(BuildContext context) async {
    //final response = await _helper.get("courses");
    var responseString = await DefaultAssetBundle.of(context).loadString("assets/jsons/courses_list.json");
    json.decode(responseString);
    var responseJson = json.decode(responseString);
    return CoursesModel.fromJson(responseJson);
  }

}
