import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:totowala/app/features/auth/verify_otp/verify_otp_view_model.dart';
import 'package:totowala/core/common_widget/common_widget.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/decoration/pin_theme.dart';
import 'package:totowala/core/di/service_locator.dart';
import 'package:totowala/core/library/images.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_bloc.dart';
import 'package:totowala/domain/features/auth/verify_otp/verify_otp_state.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';

import '../../../../core/common_widget/app_toast.dart';
import '../../../../core/library/app_text.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../navigation/app_route.dart';
import '../mobile_no/widget/num_keyboard.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String mobileNo;
  const VerifyOtpScreen({super.key,required this.mobileNo});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final TextEditingController _otpController = TextEditingController();
  String enterOtp = '';
  // bool isTimerEnded = false; // to track timer's end
  late final VerifyOtpViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final verifyOtpBloc=VerifyOTPBloc(getIt<MobileNoRepository>());
    _viewModel=VerifyOtpViewModel(verifyOtpBloc);
  }


  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
    _otpController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppText.otpVerification,
                    style: kTextStyleCustomSemiBold(
                      cairo: true,
                      size: 30
                    ),
                  ),

                 CommonWidget.backButton(context,isCross: true)
                ],
              ),
              SizedBox(height:10),
              Expanded(
                child: SvgPicture.asset(
                  AppImages.otpVerify,
                  fit: BoxFit.contain,
                  
                  
                ),
              ),
              Text(
                '6 digit OTP number has been sent to +91${widget.mobileNo??''}',
                style: kTextStyleColor800(color: AppColors.blackRussianColor,isBold: false),
              ),
              SizedBox(height:12),
              Text(
                textAlign: TextAlign.start,
                AppText.typeYourOtpNumber,
                style: kTextStyleColor800(color:AppColors.grey,  isBold: false),
              ),
              SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PinCodeTextField(
                  cursorColor: Colors.white,
                  controller: _otpController,
                  length: 6,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.none,
                  obscureText: false,
                  // obscuringWidget: Text('☆',style: kTextStyleColor500(size: 22,color: AppColors.white),),
                  autoDisposeControllers: false,
                  textStyle: kTextStyleColor800(
                      color: AppColors.white, size: 20, isBold: false),
                  animationType: AnimationType.fade,
                  pinTheme: AppPinTheme.pinTheme(),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    enterOtp = v;
                  },
                  onChanged: (value) {
                    enterOtp = value;

                  },
                  appContext: context,
                ),
              ),

              SizedBox(height: 10,),
              StreamBuilder<VerifyOTPState>(
                  stream: _viewModel.state,
                  initialData: _viewModel.currentState,
                  builder: (context,snapshot){
                    final state=snapshot.data!;
                    if (state.isSubmitted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _viewModel.resetSubmission();
                        context.go(AppRoute.dashboard);
                      });
                    }
                    return CommonWidget.button(context,AppText.verify, (){

                      if(enterOtp.length==6){
                        /// todo fcm token
                        _viewModel.verifyOtp(enterOtp, widget.mobileNo??'', '');

                      }else{
                        AppToast.toastMessage(context, AppText.pleaseEnter6DigitOtp);
                      }
                    },isLoading: state.isLoading);
                  }),

              SizedBox(height: 30,),
              NumericKeypad(
                controller: _otpController, length: 6,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
