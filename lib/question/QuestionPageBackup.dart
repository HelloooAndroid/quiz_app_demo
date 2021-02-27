import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OptionWidget.dart';
import 'QuestionModel.dart';

class QuestionPage extends StatelessWidget {
    final String title;
  final int currentQuestion = 0;
  final List<QuestionModel> questionModel = new List<QuestionModel>();

  QuestionPage(this.title);

  @override
  Widget build(BuildContext context) {
    getData();

    var size = MediaQuery.of(context).size;
    final double itemWidthHeight = size.width / 2;

    return Scaffold(
        resizeToAvoidBottomPadding: false, //for overriding pixel bt keypad
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(title),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                //for loader
                  child:TimeCircularCountdown(
                    unit: CountdownUnit.second,
                    countdownTotal: 3,
                    onUpdated: (unit, remainingTime) => print('Updated'),
                    onFinished: () => print('Countdown finished'),
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(questionModel[currentQuestion].question_name,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              new Expanded(
                  child: GridView.count(
                childAspectRatio: (itemWidthHeight / itemWidthHeight),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.all(20),
                children: List.generate(
                    questionModel[currentQuestion].options.length, (index) {
                  return OptionWidget(
                      options: questionModel[currentQuestion].options[index]);
                }),
              ))
            ],
          ),
        ));
  }

  getData() {
    questionModel.clear();

    var options1 = new List<Options>();
    options1.add(new Options("OptionA", false,"A"));
    options1.add(new Options("OptionB", false,"B"));
    options1.add(new Options("OptionC", false,"C"));
    options1.add(new Options("OptionD", true,"D"));
    questionModel.add(new QuestionModel(001, "Question Name 2", options1));

    var options2 = new List<Options>();
    options2.add(new Options("OptionA 2", false,"A"));
    options2.add(new Options("OptionB 2", false,"B"));
    options2.add(new Options("OptionC 2", false,"C"));
    options2.add(new Options("OptionD 2", true,"D"));
    questionModel.add(new QuestionModel(001, "Question Name 2", options2));
  }
}
