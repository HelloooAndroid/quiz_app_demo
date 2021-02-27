import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_demo/question/QuestionsPageBloc.dart';

import 'QuestionModel.dart';

class OptionWidget extends StatefulWidget {
  final Options options;
  final QuestionsPageBloc bloc;

  OptionWidget({this.options,this.bloc});

  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(2),
      shadowColor: Colors.grey,
      color: Colors.white,
      elevation: 4.0,
      child: GestureDetector(
        onTap: () {
          checkAnswer(context,widget.options.isCorrect,widget.bloc);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.options.optionInitials,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                widget.options.option,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void checkAnswer(BuildContext context,bool isCorrect, QuestionsPageBloc bloc) {
  print("ASDF");
  if(isCorrect){
    //_showToast(context,"Correct");
    //show success animation
    bloc.startLoader();
  }else{
    _showToast(context,"Incorrect");
  }
}

void _showToast(BuildContext context, String msg) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Clicked'),
      action: SnackBarAction(
          label: msg, onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}