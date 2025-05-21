import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:totowala/app/features/dashboard/page/home/home_view_model.dart';
import 'package:totowala/app/features/search/widget/google_place_suggestion.dart';
import 'package:totowala/app/features/search/widget/pickup_drop_line.dart';
import 'package:totowala/domain/dashboard/home/home_bloc.dart';
import 'package:totowala/domain/dashboard/home/home_state.dart';

import '../../../core/decoration/app_decoration.dart';
import '../../../core/library/app_text.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SearchScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  const SearchScreen({super.key,required this.viewModel});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppText.drop,),
        titleSpacing: 0.0,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,).copyWith(bottom: 15,top: 4),
        child: Column(
          children: [
            _pickUpAndDrop(),

          ],
        ),
      ),
    );
  }

  Widget _pickUpAndDrop(){
    return Container(
      decoration: AppDecoration.kCustomBoxDecorationWithShadow(10, AppColors.white, AppColors.white,AppColors.black),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DOTS + LINE COLUMN
          PickupDropLine(),
          const SizedBox(width: 12),
          // PICKUP & DROP FIELDS
          Expanded(
            child: _pickupAndDropField(),
          ),
        ],
      ),
    );
  }

  Widget _pickupAndDropField(){
    return Column(
      children: [
        // Pickup Field
        Container(
          width:double.infinity,
          decoration: AppDecoration.kCustomBoxDecorationWithShadow(
              15, AppColors.white, AppColors.grey, AppColors.black),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(AppText.pickUp,
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              StreamBuilder(
                  stream: viewModel.state,
                  builder: (context,snapshot)=>Text(
                    snapshot.data?.address??'',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.black87,),
                  )),

            ],
          ),
        ),
        const SizedBox(height: 10),

        // Drop Field
        Container(
          width:double.infinity,
          decoration: AppDecoration.kCustomBoxDecorationWithShadow(
              15, AppColors.white, AppColors.primary, AppColors.black),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(AppText.drop,
                  style: TextStyle(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              GooglePlaceSuggestion()
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: AppText.enterDropLocationHere,
              //     hintStyle: TextStyle(color: Colors.black87,),
              //     border: InputBorder.none,
              //     isDense: true,
              //     contentPadding:  EdgeInsets.symmetric(vertical: 0),
              //   ),
              //   cursorColor: AppColors.primary,
              //   style: TextStyle(color: AppColors.black87,),
              // ),
            ],
          ),
        ),
      ],
    );
  }


}

