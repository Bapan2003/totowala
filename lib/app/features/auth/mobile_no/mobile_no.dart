// ui/mobile_input_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:totowala/app/features/auth/mobile_no/widget/num_keyboard.dart';
import 'package:totowala/app/features/auth/mobile_no/widget/number_input_field.dart';
import 'package:totowala/app/features/auth/mobile_no/widget/toto_image.dart';
import 'package:totowala/core/common_widget/common_widget.dart';
import 'package:totowala/core/library/images.dart';
import 'package:totowala/core/theme/typography.dart';

import '../../../../core/library/app_text.dart';
import '../../../../core/theme/colors.dart';
import '../../../../domain/auth/mobile_no/mobile_no_state.dart';
import '../../../navigation/app_route.dart';
import '../../screen_export.dart';


class MobileNoScreen extends StatefulWidget {
  final MobileNoViewModel viewModel;
  const MobileNoScreen({super.key,required this.viewModel});

  @override
  State<MobileNoScreen> createState() => _MobileNoScreenState();
}

class _MobileNoScreenState extends State<MobileNoScreen> {
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      widget.viewModel.onMobileChanged(_controller.text);

    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppText.welcome,style: kTextStyleColor600(size: 45))),
              TotoImage(),
              NumberInputField(controller: _controller),
              SizedBox(height: 20),
              StreamBuilder<MobileInputState>(
                  stream: widget.viewModel.state,
                  initialData: widget.viewModel.currentState,
                  builder: (context,snapshot){
                    final state = snapshot.data!;
                    return CommonWidget.button(AppText.submit, (){
                      state.isValid ? widget.viewModel.onSubmit :null;
                      state.isValid?context.push("${AppRoute.verifyOtpScreen}?mobileNo=${state.mobile}"):null;
                    });
                  }),
              SizedBox(height: 20,),
              NumericKeypad(controller: _controller,length: 10,)
      
            ],
          ),
        ),
      ),
    );
  }
}
