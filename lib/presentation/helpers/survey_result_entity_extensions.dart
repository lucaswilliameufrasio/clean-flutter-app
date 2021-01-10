import '../../domain/entities/entities.dart';

import '../../ui/pages/pages.dart';

extension SurveyResultEntityExtension on SurveyResultEntity {
  SurveyResultViewModel toViewModel() => SurveyResultViewModel(
        surveyId: surveyId,
        question: question,
        answers: answers.map((answer) => answer.toViewModel()).toList(),
      );
}

extension SurveyAnswerEntityExtension on SurveyAnswerEntity {
  SurveyAnswerViewModel toViewModel() => SurveyAnswerViewModel(
        image: image,
        answer: answer,
        percent: '$percent',
        isCurrentAnswer: isCurrentAnswer,
      );
}
