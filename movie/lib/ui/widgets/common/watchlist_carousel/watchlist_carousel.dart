import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie/constants.dart';
import 'package:movie/ui/widgets/common/movie_carousel/movie_card.dart';
import 'package:stacked/stacked.dart';

import 'watchlist_carousel_model.dart';

class WatchlistCarousel extends StackedView<WatchlistCarouselModel> {
  const WatchlistCarousel({super.key});

  @override
  Widget builder(
    BuildContext context,
    WatchlistCarouselModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
          onPageChanged: (value) {
            viewModel.setCurrentPage(value);
          },
          controller: viewModel.pageController,
          physics: const ClampingScrollPhysics(),
          itemCount: viewModel.watchList.length,
          itemBuilder: (context, index) => MovieCard(
            movie: viewModel.watchList[index],
          ),
        ),
      ),
    );
  }

  @override
  WatchlistCarouselModel viewModelBuilder(
    BuildContext context,
  ) =>
      WatchlistCarouselModel();

    @override
  void onViewModelReady(WatchlistCarouselModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
