import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz_app_demo/api/ApiResponse.dart';

import 'QuestionModel.dart';

class QuestionsPageBloc {
  final List<QuestionModel> questionModel = new List<QuestionModel>();
  int currentQuestion = -1;

  StreamController _questionListController;

  StreamSink<ApiResponse<QuestionModel>> get questionListSink =>
      _questionListController.sink;

  Stream<ApiResponse<QuestionModel>> get questionListStream =>
      _questionListController.stream;

  QuestionsPageBloc(BuildContext context) {
    _questionListController = StreamController<ApiResponse<QuestionModel>>();
    questionListSink.add(ApiResponse.loading('Fetching data. Please wait.'));
    fetchQuestionList(context);
    startLoader();

  }

  fetchQuestionList(BuildContext context) async {
    try {
      var options1 = new List<Options>();
      options1.add(new Options("Horse", false,"A"));
      options1.add(new Options("Monkey", false,"B"));
      options1.add(new Options("Lion", false,"C"));
      options1.add(new Options("Cheetah", true,"D"));
      questionModel.add(new QuestionModel(001, "What is the fastest animal on Earth", options1));

      var options2 = new List<Options>();
      options2.add(new Options("Giraffe", true,"A"));
      options2.add(new Options("Turtle", false,"B"));
      options2.add(new Options("Cow", false,"C"));
      options2.add(new Options("Rabit", false,"D"));
      questionModel.add(new QuestionModel(001, "Which animal do not make sound", options2));

      var options3 = new List<Options>();
      options3.add(new Options("Dog", false,"A"));
      options3.add(new Options("Rat", false,"B"));
      options3.add(new Options("Elephant", true,"C"));
      options3.add(new Options("Dolphin", false,"D"));
      questionModel.add(new QuestionModel(001, "What animal has worse memory", options3));

    } catch (e) {
      questionListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  loadNextQuestion() {
    if (currentQuestion + 1 != questionModel.length) {
      currentQuestion = currentQuestion + 1;
      questionListSink
          .add(ApiResponse.completed(questionModel[currentQuestion]));
    }else{
      //show result
      print("show result");
    }
  }

  startLoader(){
    questionListSink
        .add(ApiResponse.loading("message"));
  }

  dispose() {
    _questionListController?.close();
  }
}