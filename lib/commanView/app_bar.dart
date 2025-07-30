import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../constants/size_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: AppColors.colorBlack.withValues(alpha: 0.2),
      elevation: deviceWidth * 0.05,
      backgroundColor: AppColors.colorWhite,
      surfaceTintColor: AppColors.colorWhite,
      foregroundColor: AppColors.colorBlack,
      leadingWidth: deviceWidth * 0.01,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.arrow_back_outlined,
            color: AppColors.colorBlack,
          ),
          SizedBox(
            width: deviceWidth * 0.04,
          ),
          Image.asset(
            'assets/images/location.png',
            fit: BoxFit.fill,
            width: deviceWidth * 0.08,
          ),
          SizedBox(
            width: deviceWidth * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppString.yourLocation,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: averageSize * 0.018,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorBlack.withValues(alpha: 0.4),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: deviceWidth * 0.65,
                    child: Text(
                      AppString.currentsLocation * 2,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: averageSize * 0.02,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorBlack,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: averageSize * 0.03,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(deviceHeight * 0.06);
}
