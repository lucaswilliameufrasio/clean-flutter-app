import 'package:meta/meta.dart';

class SurveyAnswerViewModel {
  final String image;
  final String answer;
  final String percent;
  final bool isCurrentAnswer;

  SurveyAnswerViewModel({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAnswer,
  });
}
