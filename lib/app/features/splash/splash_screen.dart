import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/library/images.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../screen_export.dart';


class SplashScreen extends StatefulWidget {
  final SplashScreenViewModel viewModel;
  const SplashScreen({super.key,required this.viewModel});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
    SchedulerBinding.instance.addPostFrameCallback((_)async{
      await Future.delayed(const Duration(milliseconds: 2500));
      if(mounted){
        widget.viewModel.gotoNextPage(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  AppImages.totologo,
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
