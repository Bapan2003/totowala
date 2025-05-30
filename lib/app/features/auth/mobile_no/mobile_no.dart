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
import '../../../../domain/features/auth/mobile_no/mobile_no_state.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppText.welcome,style: kTextStyleColor600(size: 45))),
              TotoImage(),
              NumberInputField(controller: _controller),
              StreamBuilder<MobileInputState>(
                  stream: widget.viewModel.state,
                  initialData: widget.viewModel.currentState,
                  builder: (context,snapshot){
                    final state = snapshot.data!;
                    return state.error!=null && state.error!.isNotEmpty?Text(state.error??'',style: kTextStyleColor500(isBold: false,color: AppColors.redColor),maxLines: 2,overflow: TextOverflow.ellipsis,):const SizedBox.shrink();
                  }),
              SizedBox(height: 20),
              StreamBuilder<MobileInputState>(
                  stream: widget.viewModel.state,
                  initialData: widget.viewModel.currentState,
                  builder: (context,snapshot){
                    final state = snapshot.data!;

                    if (state.isSubmitted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        widget.viewModel.resetSubmission();
                        context.push("${AppRoute.verifyOtpScreen}?mobileNo=${state.mobile}");
                      });
                    }

                    return CommonWidget.button(context,AppText.submit, (){

                        widget.viewModel.onSubmit();


                    },isLoading: state.loading??false);
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
