import 'dart:ffi';

class QuestionModel {

  int question_id;
  String question_name;

 List<Options> options;



  QuestionModel(this.question_id,
  this.question_name,
  this.options);


}

class Options {
  String option;
  String optionInitials;
  bool isCorrect;

  Options(this.option,
      this.isCorrect,
      this.optionInitials);
}

