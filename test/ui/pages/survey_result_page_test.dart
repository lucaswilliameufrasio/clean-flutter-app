import 'dart:async';

import 'package:image_test_utils/image_test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import 'package:ForDev/ui/pages/survey_result/components/components.dart';
import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:ForDev/ui/pages/pages.dart';

class SurveyResultPresenterSpy extends Mock implements SurveyResultPresenter {}

void main() {
  SurveyResultPresenterSpy presenter;
  StreamController<bool> isLoadingController;
  StreamController<bool> isSessionExpiredToController;
  StreamController<SurveyResultViewModel> surveyResultController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    isSessionExpiredToController = StreamController<bool>();
    surveyResultController = StreamController<SurveyResultViewModel>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.isSessionExpiredStream)
        .thenAnswer((_) => isSessionExpiredToController.stream);
    when(presenter.surveyResultStream)
        .thenAnswer((_) => surveyResultController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    surveyResultController.close();
    isSessionExpiredToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveyResultPresenterSpy();
    initStreams();
    mockStreams();
    final surveysPage = GetMaterialApp(
      initialRoute: '/survey_result/any_survey_id',
      getPages: [
        GetPage(
            name: '/survey_result/:survey_id',
            page: () => SurveyResultPage(presenter)),
        GetPage(name: '/login', page: () => Scaffold(body: Text('fake login')))
      ],
    );

    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(surveysPage);
    });
  }

  SurveyResultViewModel makeSurveyResult() => SurveyResultViewModel(
        surveyId: 'Any id',
        question: 'Question',
        answers: [
          SurveyAnswerViewModel(
            image: 'Image 0',
            answer: 'Answer 0',
            percent: '60%',
            isCurrentAnswer: true,
          ),
          SurveyAnswerViewModel(
            answer: 'Answer 1',
            percent: '40%',
            isCurrentAnswer: false,
          ),
        ],
      );

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadSurveyResult on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(null);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if surveyResultStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveyResultController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo de errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Question'), findsNothing);
  });

  testWidgets('Should call LoadSurveyResult on reload button tap',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveyResultController.addError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should present valid data if surveyResultStream succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveyResultController.add(makeSurveyResult());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    expect(find.text('Algo de errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Question'), findsOneWidget);
    expect(find.text('Answer 0'), findsOneWidget);
    expect(find.text('Answer 1'), findsOneWidget);
    expect(find.text('60%'), findsOneWidget);
    expect(find.text('40%'), findsOneWidget);
    expect(find.byType(ActiveIcon), findsOneWidget);
    expect(find.byType(DisabledIcon), findsOneWidget);
    final image =
        tester.widget<Image>(find.byType(Image)).image as NetworkImage;
    expect(image.url, 'Image 0');
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    isSessionExpiredToController.add(true);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/login');
    expect(find.text('fake login'), findsOneWidget);
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    isSessionExpiredToController.add(false);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/survey_result/any_survey_id');

    isSessionExpiredToController.add(null);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/survey_result/any_survey_id');
  });
}
