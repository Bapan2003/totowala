import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/library/images.dart';
import 'package:totowala/core/theme/typography.dart';


import '../../../../../core/library/app_text.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/app_helper.dart';
import '../../../../../core/utils/app_settings.dart';
import '../../../../../domain/features/dashboard/home/home_bloc.dart';
import '../../../../../domain/features/dashboard/home/home_state.dart';
import '../../../../navigation/app_route.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final homeBloc = HomeBloc();
    _viewModel = HomeViewModel(homeBloc);
 
  }
  void _onMapCreated(GoogleMapController controller) async {
    _viewModel.createMapController(controller);
    _viewModel.fetchLocation();
    // _mapController.animateCamera(cameraUpdate)
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
      drawer: _leftDrawer(),
      body: Stack(
        children: [

          StreamBuilder<HomeState>(
              stream: _viewModel.state,
              builder: (context, snapshot){
                final state=snapshot.data;
                return Stack(
                  children: [
                    Stack(
                      children: [
                        GoogleMap(
                          padding: EdgeInsets.only(bottom: btnHeight),
                          initialCameraPosition: CameraPosition(
                            target: LatLng(22.5726, 88.3639), // Kolkata coordinates (example)
                            zoom: 12,
                          ),
                          onMapCreated:_onMapCreated,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          markers: state?.markers??{},
                        ),

                        // Gradient overlay
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black87,      // top dark
                                Colors.transparent,  // middle transparent
                                Colors.transparent,  // more transparency
                                Colors.white10       // soft white at bottom if needed
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Custom floating button
                    Positioned(
                      right: 20,
                      bottom: btnHeight,
                      child: FloatingActionButton(
                        heroTag: 'locationBtn',
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: ()=>_viewModel.fetchLocation(),
                        elevation: 4,
                        child: const Icon(Icons.my_location),
                      ),
                    ),

                    Positioned(
                        left: 20,
                        top: kToolbarHeight-10,
                        right: 20,
                        child:  Row(

                          children: [
                            Builder(
                              builder: (context) => Container(
                                width: 45,
                                height: 45,
                                decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.white, AppColors.black,isCircle: true),
                                margin: const EdgeInsets.only(top: 8,bottom: 8),
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
                            Expanded(
                                child: Center(child: Text(state?.address??'',textAlign:TextAlign.center,style: kTextStyleColor500(color: AppColors.white),))
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.white, AppColors.black,isCircle: true),
                              margin: const EdgeInsets.only(top: 8,bottom: 8),
                              child: Center(
                                child: Text(
                                    'A',
                                    style: kTextStyleColor600(size: 20, cairo: true)
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                );
              }),

          
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
                    Text("Hello there, Abhijit ", style: kTextStyleColor700(color: AppColors.white,size: 24,)),
                    const SizedBox(height: 10),


                    Row(
                      children: [

                        Expanded(
                          child: Container(
                            decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.grey.withOpacity(0.7),AppColors.black),
                            height: 150,
                          ),
                        ),

                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, AppColors.white, AppColors.grey.withOpacity(0.7),AppColors.black),
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Container(
                      decoration: AppDecoration.kCustomBoxDecorationWithShadow(
                          25, AppColors.white, AppColors.transparent, AppColors.black),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10,),
                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                context.push(AppRoute.searchScreen);
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration:  InputDecoration(
                                    hintText: 'Where are you going?',
                                    hintStyle: kTextStyleColor800(size: 17,isBold: false),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0), // Reduce vertical padding

                                  ),
                                  style: TextStyle(height: 1.4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )


                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Drawer _leftDrawer(){
    return Drawer(
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
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
            leading: Icon(Icons.info_outline),
            title: Text('Version 1.0.0'),
          ),
          const Divider(thickness: 2,),
          // const Spacer()
        ],
      ),
    );
  }
}
