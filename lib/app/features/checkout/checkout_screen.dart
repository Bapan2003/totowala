import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:totowala/app/features/checkout/checkout_view_model.dart';
import 'package:totowala/core/theme/typography.dart';
import 'package:totowala/domain/features/checkout/checkout_bloc.dart';
import 'package:totowala/domain/features/checkout/checkout_state.dart';

import '../../../core/common_widget/common_widget.dart';
import '../../../core/decoration/app_decoration.dart';
import '../../../core/library/app_text.dart';
import '../../../core/theme/colors.dart';

class CheckoutScreen extends StatefulWidget {
  final LatLng? src;
  final LatLng? dest;
  const CheckoutScreen({super.key,required this.src,required this.dest});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  late CheckoutViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final checkoutBloc = CheckoutBloc();
    _viewModel = CheckoutViewModel(checkoutBloc);
    if(widget.src!=null && widget.dest!=null){
      _viewModel.loadRoute(widget.src!, widget.dest!); // 👈 ViewModel calling BLoC
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double btnHeight=size.height*0.43;
    return Scaffold(
      body: Stack(
        children: [

          Stack(
            children: [
              StreamBuilder<CheckoutState>(
                  stream: _viewModel.state,
                  builder: (context,snapshot){
                    if(snapshot.data==null)return const SizedBox.shrink();
                    Set<Polyline> polyLines = {};
                    final state=snapshot.data!;

                    if (state.polylinePoints.isNotEmpty) {
                      polyLines.add(Polyline(
                        polylineId: PolylineId('route'),
                        color: Colors.blue,
                        width: 5,
                        points: state.polylinePoints,
                      ));
                    }
                    return GoogleMap(
                      padding: EdgeInsets.only(bottom: btnHeight),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(22.5726, 88.3639), // Kolkata coordinates (example)
                        zoom: 12,
                      ),
                      onMapCreated: (controller) => _viewModel.createMapController(controller),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                      polylines: polyLines,
                      circles: state.circles,
                      markers: state.markers,
                    );
                  }),
              Positioned(
                  top: kToolbarHeight-10,
                left: 20,
                child:  CommonWidget.backButton(context,isShadow: true,bgColor: AppColors.white,borderColor: AppColors.lightGreyColor),

              ),
            ],
          ),
          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.4, // Min height
            minChildSize: 0.4,
            maxChildSize: 0.95, // Max height

            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:[
                        AppColors.grey,
                        AppColors.lightGreyColor,
                        AppColors.white
                      ]),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black26,offset: Offset(0, -10))],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                      child: Container(
                        width: 100,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: AppDecoration.kCustomBoxDecoration(4, AppColors.white, AppColors.transparent),
                      ),
                    ),
                    Center(child: Text(AppText.chooseRide,style: kTextStyleColor500(size: 18),)),
                    const Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context,index){
                          return Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.lightGreyColor, AppColors.black),
                            child: Text('50'),
                          );
                        }
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CommonWidget.button(AppText.confirm, (){}),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
