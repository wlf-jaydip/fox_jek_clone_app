import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staging_fox_jek_clone_app/commanView/app_bar.dart';
import 'package:staging_fox_jek_clone_app/constants/app_color.dart';
import 'package:staging_fox_jek_clone_app/constants/size_constants.dart';

class ManageScreenUi extends StatefulWidget {
  const ManageScreenUi({super.key});

  @override
  State<ManageScreenUi> createState() => _ManageScreenUiState();
}

class _ManageScreenUiState extends State<ManageScreenUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(),
      body: _buildManageScreen(),
    );
  }

  Widget _buildManageScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.colorBlack,
            ),
            // padding: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.2),
            // margin: EdgeInsetsDirectional.symmetric(
            //   horizontal: deviceWidth * 0.05,
            // ),
            constraints: BoxConstraints(
              maxHeight: deviceHeight,
              maxWidth: deviceWidth,
              // minWidth: deviceWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Favorite Restuarant ',
                  textScaler: TextScaler.linear(1.37),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: averageSize * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
