import 'package:meta/meta.dart';

class SurveyAnswerEntity {
  final String image;
  final String answer;
  final int percent;
  final bool isCurrentAnswer;

  SurveyAnswerEntity({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAnswer,
  });
}
