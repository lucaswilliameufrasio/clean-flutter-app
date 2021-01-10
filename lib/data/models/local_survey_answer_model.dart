import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

class LocalSurveyAnswerModel {
  final String image;
  final String answer;
  final int percent;
  final bool isCurrentAnswer;

  LocalSurveyAnswerModel({
    this.image,
    @required this.answer,
    @required this.percent,
    @required this.isCurrentAnswer,
  });

  factory LocalSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(['answer', 'percent', 'isCurrentAnswer'])) {
      throw Exception();
    }
    return LocalSurveyAnswerModel(
      image: json['image'],
      answer: json['answer'],
      isCurrentAnswer: json['isCurrentAnswer'].toLowerCase() == 'true',
      percent: int.parse(json['percent']),
    );
  }

  factory LocalSurveyAnswerModel.fromEntity(SurveyAnswerEntity entity) =>
      LocalSurveyAnswerModel(
        image: entity.image,
        answer: entity.answer,
        percent: entity.percent,
        isCurrentAnswer: entity.isCurrentAnswer,
      );

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
        image: image,
        answer: answer,
        percent: percent,
        isCurrentAnswer: isCurrentAnswer,
      );

  Map<String, String> toJson() => {
        'image': image,
        'answer': answer,
        'percent': percent.toString(),
        'isCurrentAnswer': isCurrentAnswer.toString(),
      };
}
