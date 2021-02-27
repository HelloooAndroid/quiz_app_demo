import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_demo/question/QuestionsPageBloc.dart';
import 'package:quiz_app_demo/api/ApiResponse.dart';

import 'OptionWidget.dart';
import 'QuestionModel.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: QuestionScreen());
  }
}

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionsPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = QuestionsPageBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Quiz"),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<ApiResponse<QuestionModel>>(
        stream: _bloc.questionListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                  bloc: _bloc,
                );
                break;
              case Status.COMPLETED:
                return QuestionsList(
                    questionModel: snapshot.data.data,
                    bloc:_bloc);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class QuestionsList extends StatelessWidget {
  final QuestionModel questionModel;
  final QuestionsPageBloc bloc;
  const QuestionsList({Key key, this.questionModel, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final int currentQuestion = 0;
    var size = MediaQuery.of(context).size;
    final double itemWidthHeight = size.width / 2;

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(questionModel.question_name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          new Expanded(
              child: GridView.count(
            childAspectRatio: (itemWidthHeight / itemWidthHeight),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: EdgeInsets.all(20),
            children: List.generate(
                questionModel.options.length, (index) {
              return OptionWidget(
                  options: questionModel.options[index],
              bloc:bloc);
            }),
          ))
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;
  final QuestionsPageBloc bloc;
  const Loading({Key key, this.loadingMessage,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),*/
          TimeCircularCountdown(
            unit: CountdownUnit.second,
            countdownTotal: 3,
            onUpdated: (unit, remainingTime) => {
              print('Updated')
            },
            onFinished: () => {
              //print('Countdown finished');
              bloc.loadNextQuestion()
            },
          )
        ],
      ),
    );
  }
}
