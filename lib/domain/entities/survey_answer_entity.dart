import 'package:meta/meta.dart';

class SurveyAnswerEntity {
  final String image;
  final String answer;
  final int percent;
  final bool isCurrentAccountAnswer;

  SurveyAnswerEntity({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAccountAnswer,
  });
}
