import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:totowala/app/features/checkout/checkout_screen.dart';
import 'package:totowala/app/features/search/search_view_model.dart';
import 'package:totowala/app/features/search/widget/pickup_drop_line.dart';
import 'package:totowala/app/navigation/app_route.dart';
import 'package:totowala/core/common_widget/common_widget.dart';
import 'package:totowala/domain/features/search/search_bloc.dart';
import 'package:totowala/domain/features/search/search_event.dart';
import 'package:totowala/domain/features/search/search_state.dart';
import 'package:uuid/uuid.dart';


import '../../../core/decoration/app_decoration.dart';
import '../../../core/library/app_text.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_helper.dart';
import '../dashboard/page/passenger/home/home_view_model.dart';

class SearchScreen extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final SearchViewModel searchViewModel;
   SearchScreen({super.key,required this.homeViewModel,required this.searchViewModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CommonWidget.backButton(context,title: AppText.drop),
          ],
        ),
        titleSpacing: 20,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric().copyWith(bottom: 15,top: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _pickUpAndDrop(context),
            ),

            Expanded(
              child: _suggestedList(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _pickUpAndDrop(BuildContext context){
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
            child: _pickupAndDropField(context),
          ),
        ],
      ),
    );
  }

  Widget _pickupAndDropField(BuildContext context){
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              StreamBuilder(
                  stream: widget.homeViewModel.state,
                  builder: (context,snapshot){
                    if(snapshot.data==null)return const SizedBox.shrink();
                    widget.searchViewModel.selectPickUpLocation(snapshot.data?.address??'', snapshot.data!.currentPosition?.latitude??0, snapshot.data!.currentPosition?.longitude??0);
                    return Text(
                      snapshot.data?.address??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.black87,),
                    );
                  }),

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
              StreamBuilder<SearchState>(
                  stream: widget.searchViewModel.state,
                  builder: (context,snapshot){
                    return TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: AppText.enterDropLocationHere,
                        hintStyle: TextStyle(color: Colors.black87,),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:  EdgeInsets.symmetric(vertical: 0),
                      ),
                      onChanged: (val){
                        widget.searchViewModel.onChange(val);
                      },
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      cursorColor: AppColors.primary,
                      style: TextStyle(color: AppColors.black87,),
                    );
                  }),


            ],
          ),
        ),
      ],
    );
  }
  
  Widget _suggestedList(BuildContext context){
    return StreamBuilder<SearchState>(
        stream: widget.searchViewModel.state,
        builder: (context,snapshot){
          final state=snapshot.data;
          if( state==null||state.suggestedPlace==null){
            return const SizedBox.shrink();
          }

          if(state.isLoading){
            return SizedBox.shrink();
          }
          if(state.error.isNotEmpty){
            return Text(state.error);
          }
          return ListView.separated(
              shrinkWrap: true,
              itemCount: state.suggestedPlace!.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              separatorBuilder: (_,__)=>Divider(color: AppColors.grey400,thickness: 1,),
              itemBuilder: (context,index){
                String des=AppHelper.cropTitleFromWhole(state.suggestedPlace?[index].description??'', state.suggestedPlace?[index].mainText??'');
                return GestureDetector(
                  onTap: ()async{
                    try{
                      LatLng coordinate=await AppHelper.getCoordinatesFromAddress(state.suggestedPlace![index].description??'');
                      if (!mounted) return;
                      widget.searchViewModel.selectDropLocation(state.suggestedPlace![index].description??'', coordinate.latitude, coordinate.longitude);
                      _controller.text=state.suggestedPlace?[index].description??'';
                        context.push('${AppRoute.checkoutScreen}?src=${state.pickUp?.latLng?.latitude??''},${state.pickUp?.latLng?.longitude??''}&dest=${coordinate.latitude??''},${coordinate.longitude??''}',);

                    }catch(e){
                      debugPrint(e.toString());
                    }

                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      decoration: AppDecoration.kCustomBoxDecorationWithShadow(0, AppColors.white, AppColors.transparent,AppColors.black87),
                      child:Row(
                        children: [
                          CircleAvatar(child: Icon(Icons.location_on_outlined)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.suggestedPlace?[index].mainText??'',style: kTextStyleColor500(),),
                                SizedBox(height: 2),
                                Text(des,maxLines: null,),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              }
          );
        }
    );
  }
}

