import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerEntity extends Equatable {
  final String image;
  final String answer;
  final int percent;
  final bool isCurrentAnswer;

  List get props => [image, answer, percent, isCurrentAnswer];

  SurveyAnswerEntity({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAnswer,
  });
}
