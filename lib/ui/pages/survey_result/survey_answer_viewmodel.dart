import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerViewModel extends Equatable {
  final String image;
  final String answer;
  final String percent;
  final bool isCurrentAnswer;

  List get props => [image, answer, percent, isCurrentAnswer];

  SurveyAnswerViewModel({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAnswer,
  });
}
