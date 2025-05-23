import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:totowala/core/library/images.dart';

import '../../../../../../core/decoration/app_decoration.dart';
import '../../../../../../core/library/app_text.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../../../core/utils/app_settings.dart';

import '../../../../../navigation/app_route.dart';
import '../../../widget/driver_mode.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {

  bool isOnDuty=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: _leftDrawer(context),
      body: Column(
        children: [
          _appBar(),
          const Divider(),

          Center(
            child: Lottie.asset(AppImages.earnMoney),
          ),

        ],
      ),
    );
  }

  Widget _appBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: kToolbarHeight-10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => Container(
              width: 45,
              height: 45,
              decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.white, AppColors.black,isCircle: true),
              margin: const EdgeInsets.only(top: 8,bottom: 8,right: 10),
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
          Container(
            decoration: AppDecoration.kCustomBoxDecoration(25, AppColors.transparent, isOnDuty?AppColors.greenColor:AppColors.grey),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isOnDuty?AppText.onDuty:AppText.offDuty,style: kTextStyleColor500(color:isOnDuty?AppColors.greenColor:AppColors.grey),),
                Switch(
                    inactiveTrackColor: AppColors.lightGreyColor,
                    activeColor: AppColors.greenColor,
                    value: isOnDuty, onChanged: (newValue){

                      isOnDuty=newValue;
                      setState(() {

                      });
                })
              ],
            ),
          ),

          Container(
            width: 45,
            height: 45,
            decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.white, AppColors.black,isCircle: true),
            margin: const EdgeInsets.only(top: 8,bottom: 8,left: 10),
            child: Center(
              child: Text(
                  'A',
                  style: kTextStyleColor600(size: 20, cairo: true)
              ),
            ),
          )
        ],
      ),
    );
  }

  Drawer _leftDrawer(BuildContext context){
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children:  [
                SizedBox(
                  height: 110,
                  child: DrawerHeader(

                    decoration: BoxDecoration(color: AppColors.primary),
                    child: Text(
                      '${AppText.welcome} Abhijit',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.lightGreyColor,child: Icon(Icons.home,color: AppColors.black87,)),
                  title: Text('Home'),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.lightGreyColor,child: Icon(Icons.credit_card,color: AppColors.black87,)),
                  title: Text('My Earnings'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.lightGreyColor,child: Icon(Icons.person,color: AppColors.black87,)),
                  title: Text('My Profile'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.lightGreyColor,child: Icon(Icons.logout,color: AppColors.black87,)),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), // Cancel
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              AppSettings.clearAll();
                              context.go(AppRoute.mobileNoScreen); // Navigate
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.lightGreyColor,child: Icon(Icons.info_outline,color: AppColors.black87,)),
                  title: Text('Version 1.0.0'),
                ),
                const Divider(thickness: 2,),
                // const Spacer()
              ],
            ),
          ),

          DriverPassengerModeToggle(),

        ],
      ),
    );
  }
}
