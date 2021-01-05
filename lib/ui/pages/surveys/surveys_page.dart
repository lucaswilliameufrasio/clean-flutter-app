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
          presenter.loadData();

          return StreamBuilder<List<SurveyViewModel>>(
              stream: presenter.surveysStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          child: Text(R.strings.reload),
                          onPressed: presenter.loadData,
                        )
                      ],
                    ),
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
