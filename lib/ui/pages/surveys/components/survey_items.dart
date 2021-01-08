import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../surveys.dart';
import './components.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModels;

  SurveyItems(this.viewModels);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 1,
        ),
        items: viewModels.map((viewModel) => SurveyItem(viewModel)).toList(),
      ),
    );
  }
}
