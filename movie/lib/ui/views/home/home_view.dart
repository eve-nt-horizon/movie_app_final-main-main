import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/constants.dart';
import 'package:movie/ui/views/home/components/body.dart';
import 'package:movie/ui/views/home/components/drawer.dart';
import 'package:movie/ui/views/sign_in/sign_in_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    viewModel.resetPage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(viewModel, context),
      drawer: const MovieAppDrawer(),
      body: StreamBuilder<User?>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            if (snapshot.data?.uid == null) return const SignInView();
            return const Body();
          }),
    );
  }

  AppBar buildAppBar(HomeViewModel model, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   padding: const EdgeInsets.only(left: kDefaultPadding),
      //   icon: SvgPicture.asset('assets/icons/menu.svg'),
      //   onPressed: () {},
      // ),
      title: TextField(controller: model.searchController),
      actions: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: SvgPicture.asset('assets/icons/search.svg'),
          onPressed: () async {
            await model.search();
          },
        )
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
