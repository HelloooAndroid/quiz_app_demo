import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz_app_demo/api/ApiResponse.dart';
import 'package:quiz_app_demo/courses/CoursesRepository.dart';
import 'package:quiz_app_demo/models/CoursesModel.dart';

class CoursesBloc {
  CoursesRepository _coursesRepository;

  StreamController _coursesListController;

  StreamSink<ApiResponse<CoursesModel>> get coursesListSink =>
      _coursesListController.sink;

  Stream<ApiResponse<CoursesModel>> get coursesListStream =>
      _coursesListController.stream;

  CoursesBloc(BuildContext context) {
    _coursesListController = StreamController<ApiResponse<CoursesModel>>();
    _coursesRepository = CoursesRepository();
    fetchCoursesList(context);
  }

  fetchCoursesList(BuildContext context) async {
    coursesListSink.add(ApiResponse.loading('Fetching courses. Please wait.'));
    try {
      CoursesModel courses = await _coursesRepository.fetchCoursesList(context);
      coursesListSink.add(ApiResponse.completed(courses));
    } catch (e) {
      coursesListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _coursesListController?.close();
  }
}