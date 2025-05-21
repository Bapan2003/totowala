import 'package:flutter/material.dart';
import 'package:totowala/app/features/search/search_view_model.dart';

import '../../../../core/library/app_text.dart';
import '../../../../core/theme/colors.dart';

class GooglePlaceSuggestion extends StatefulWidget {
  const GooglePlaceSuggestion({super.key});

  @override
  State<GooglePlaceSuggestion> createState() => _GooglePlaceSuggestionState();
}

class _GooglePlaceSuggestionState extends State<GooglePlaceSuggestion> {
  final TextEditingController controller=TextEditingController();

  late SearchViewModel _viewModel;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel=SearchViewModel();

  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
          decoration: InputDecoration(
            hintText: AppText.enterDropLocationHere,
            hintStyle: TextStyle(color: Colors.black87,),
            border: InputBorder.none,
            isDense: true,
            contentPadding:  EdgeInsets.symmetric(vertical: 0),
          ),
          onChanged: (val){
            _viewModel.onChange(val);
          },
          cursorColor: AppColors.primary,
          style: TextStyle(color: AppColors.black87,),
        );
  }

}
