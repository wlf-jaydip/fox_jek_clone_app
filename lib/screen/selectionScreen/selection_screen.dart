import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staging_fox_jek_clone_app/commanView/app_bar.dart';
import 'package:staging_fox_jek_clone_app/constants/app_color.dart';
import 'package:staging_fox_jek_clone_app/constants/app_string.dart';
import 'package:staging_fox_jek_clone_app/constants/size_constants.dart';
import 'package:staging_fox_jek_clone_app/screen/selectionScreen/selection_bloc.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> with SingleTickerProviderStateMixin {
  final _selectionBloc = SelectionBloc();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: CustomBackAppBar(),
        body: _buildManageScreen(),
      ),
    );
  }

  Widget _buildManageScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildUserDetails(),
        _buildTabBar(),
        _buildTabBarView(),
      ],
    );
  }

  Widget _buildUserDetails() {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight * 0.02,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(
              averageSize * 0.015,
            ),
            child: Image.asset(
              height: deviceHeight * 0.1,
              width: deviceWidth * 0.23,
              'assets/images/user.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppString.userName,
                style: GoogleFonts.lato(
                  fontSize: averageSize * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.003,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: averageSize * 0.025,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  Text(
                    AppString.location,
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.003,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    size: averageSize * 0.025,
                    color: AppColors.amber,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  Text(
                    AppString.rate,
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  Text(
                    '(${AppString.totRate})',
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.02,
                  ),
                  Text(
                    ' | ',
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.02,
                  ),
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: averageSize * 0.025,
                    color: AppColors.colorGrey,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  Text(
                    '${AppString.record}',
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.003,
              ),
              Row(
                children: [
                  Image.asset(
                    height: deviceHeight * 0.02,
                    'assets/images/beauty.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  Text(
                    AppString.beauty,
                    style: GoogleFonts.lato(
                      fontSize: averageSize * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      unselectedLabelColor: Colors.transparent,
      dividerHeight: 0,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      indicator: BoxDecoration(
        color: Colors.transparent,
      ),
      tabs: [
        Tab(
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: deviceHeight * 0.008,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorGrey, width: 1.2),
              borderRadius: BorderRadiusDirectional.circular(averageSize * 0.018),
              color: AppColors.colorWhite,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save,
                  color: AppColors.colorGreen,
                  size: averageSize * 0.03,
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text(
                  '${AppString.package}',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: AppColors.colorBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: deviceHeight * 0.008,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorGrey, width: 1.2),
              borderRadius: BorderRadiusDirectional.circular(averageSize * 0.018),
              color: AppColors.colorWhite,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.stars,
                  color: AppColors.colorBlack,
                  size: averageSize * 0.03,
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text(
                  '${AppString.review}',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: AppColors.colorBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: deviceHeight * 0.007,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorGrey, width: 1.2),
              borderRadius: BorderRadiusDirectional.circular(averageSize * 0.018),
              color: AppColors.colorWhite,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_camera_back,
                  color: AppColors.colorBlack,
                  size: averageSize * 0.03,
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text(
                  '${AppString.Gallery}',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: AppColors.colorBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
        child: TabBarView(children: [
      _buildPackagePart(),
      _buildReviewPart(),
      _buildGalleryPart(),
    ]));
  }

  _buildPackagePart() {
    return Column(
      children: [
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        Container(
          constraints: BoxConstraints(maxHeight: deviceHeight * 0.04),
          child: ListView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: deviceWidth * 0.02,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _selectionBloc.sortingList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.01),
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: deviceWidth * 0.04,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorGrey, width: 1.2),
                    borderRadius: BorderRadiusDirectional.circular(averageSize * 0.05),
                    color: AppColors.colorWhite,
                  ),
                  child: Center(
                    child: Text(
                      _selectionBloc.sortingList[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: averageSize * 0.025,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, s) {
                return Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: deviceHeight * 0.01),
                  child: Divider(
                    color: AppColors.colorGrey,
                    thickness: 0.5,
                  ),
                );
              },
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: deviceWidth * 0.05,
                vertical: deviceHeight * 0.02,
              ),
              itemCount: _selectionBloc.sortingList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: deviceWidth * 0.5,
                            minWidth: deviceWidth * 0.2,
                          ),
                          child: Text(
                            '${_selectionBloc.sortingList[index]} ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: averageSize * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: deviceWidth * 0.2,
                            minWidth: deviceWidth * 0.1,
                          ),
                          child: Text(
                            '\$ ${20.00}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: averageSize * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.03,
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(vertical: deviceWidth * 0.01),
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: deviceWidth * 0.06,
                            vertical: deviceWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGrey, width: 1.2),
                            borderRadius: BorderRadiusDirectional.circular(averageSize * 0.015),
                            color: AppColors.colorWhite,
                          ),
                          child: Text(
                            'Add',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              color: AppColors.colorGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: averageSize * 0.028,
                            )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: deviceWidth,
                        minWidth: deviceWidth * 0.2,
                      ),
                      child: Text(
                        '${(_selectionBloc.sortingList[index] * 20)} ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: averageSize * 0.022,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }

  _buildReviewPart() {
    return Center(
      child: Text('Second'),
    );
  }

  _buildGalleryPart() {
    return Center(
      child: Text('Third'),
    );
  }
}
