import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/app/features/dashboard/dashboard_view_model.dart';
import 'package:totowala/app/my_app.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_event.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_state.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_bloc.dart';
import 'package:totowala/domain/features/dashboard/driver_home/driver_home_event.dart';

import '../../../../core/library/app_text.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/app_helper.dart';
import '../../../../core/utils/app_settings.dart';
import '../../../../domain/features/dashboard/dashboard/dashboard_bloc.dart';

class DriverPassengerModeToggle extends StatefulWidget {

  const DriverPassengerModeToggle({super.key});

  @override
  _DriverPassengerModeToggleState createState() => _DriverPassengerModeToggleState();
}

class _DriverPassengerModeToggleState extends State<DriverPassengerModeToggle> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: AppDecoration.kCustomBoxDecoration(0, AppColors.lightGreyColor,AppColors.lightGreyColor, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppText.driverMode,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Switch(
                activeColor: AppColors.greenColor,
                value: state.isDriver,
                onChanged: (bool newValue) {
                  context.read<DashboardBloc>().add(ChangeDriverPassengerModeEvent(isDriver: newValue));
                  context.read<DriverHomeBloc>().add(ChangeDutyModeEvent(isOnDuty: false));
                },
              );
            },
          )

        ],
      ),
    );
  }
}
