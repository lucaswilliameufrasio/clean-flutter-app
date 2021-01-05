import 'package:ForDev/ui/pages/pages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';
import 'surveys_presenter.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    presenter.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          return StreamBuilder<List<SurveyViewModel>>(
              stream: presenter.loadSurveysStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(snapshot.error),
                      RaisedButton(
                        child: Text(R.strings.reload),
                        onPressed: null,
                      )
                    ],
                  );
                }

                if (snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        aspectRatio: 1,
                      ),
                      items: snapshot.data
                          .map((viewModel) => SurveyItem(viewModel))
                          .toList(),
                    ),
                  );
                }

                return SizedBox(height: 0);
              });
        },
      ),
    );
  }
}
