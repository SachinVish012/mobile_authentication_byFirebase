import 'package:flutter/material.dart';

import '../../../res/app_localization_text/app_localization_text.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/custom_text.dart';

class MobileTitileWidget extends StatelessWidget {
  const MobileTitileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.centerLeft,
      child: CustomTextWidget(
        text: AppLocalizationText.mobile_title,
        fontWeight: FontWeight.bold,
        color: AppColors.textBlack,
        fontSize: 18,
      ),
    );
  }
}
