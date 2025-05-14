import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/theme/typography.dart';
import '../screen_export.dart';


class SplashScreen extends StatefulWidget {
  final SplashScreenViewModel viewModel;
  const SplashScreen({super.key,required this.viewModel});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_)async{
      await Future.delayed(const Duration(milliseconds: 2500));
       if(mounted){
         widget.viewModel.gotoDashboard(context);
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Totowala',style: AppTypography.title,)));
  }
}
