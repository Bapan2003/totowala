import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:totowala/app/features/dashboard/page/home/home_screen.dart';
import 'package:totowala/app/navigation/app_route.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/theme/typography.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/domain/dashboard/home/home_bloc.dart';

import '../../../core/library/app_text.dart';
import '../../../core/theme/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final _pageController = PageController(initialPage: 0);

  final pageList=[
    HomeScreen(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: _appBar(),
      // drawer: _leftDrawer(),
      body: pageList[0],
    );
  }

  AppBar _appBar(){
    return AppBar(
      backgroundColor: AppColors.white,
      leadingWidth: 60,
      leading: Builder(
        builder: (context) => Container(
          width: 40,
          height: 40,
          decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.primary, AppColors.black,isCircle: true),
          margin: const EdgeInsets.only(left: 15,top: 8,bottom: 8),
          child: Center(
            child: IconButton(
              alignment: Alignment.center,
              icon: const Icon(Icons.widgets_outlined,color: AppColors.black,size: 22,), // Hamburger icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens the drawer
              },
            ),
          ),
        ),
      ),
      actions: [
        Container(
          width: 40,
          height: 40,
          decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.primary, AppColors.black,isCircle: true),
          margin: const EdgeInsets.only(right: 15,top: 8,bottom: 8),
          child: Center(
            child: Text(
              'A',
                style: kTextStyleColor600(size: 20, cairo: true)
            ),
          ),
        )
      ],
    );
  }

}
