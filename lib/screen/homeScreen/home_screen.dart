import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../commanView/app_bar.dart';
import '../../constants/app_color.dart';
import '../../constants/app_string.dart';
import '../../constants/size_constants.dart';
import '../../utils/utils.dart';
import '../favoriteRestaurant/favorite_restaurants_screen.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Declare Variable
  final _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(),
      body: _buildHomeScreen(),
    );
  }

  /// this method used to load all sub widget
  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSearchText(),
          _buildImageSlider(),
          _buildDots(),
          _buildCategoryList(),
          _buildSorting(),
          // _buildFeatureFoodDelivery(),
          // _buildFavoriteList(),
          // _buildNearRestaurant()
        ],
      ),
    );
  }

  /// this method used to display search text field
  Widget _buildSearchText() {
    return Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: deviceWidth * 0.025,
          vertical: deviceHeight * 0.012,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorGrey, width: 0.7),
          borderRadius: BorderRadiusDirectional.circular(
            averageSize * 0.025,
          ),
        ),
        margin: EdgeInsetsDirectional.only(
          start: deviceWidth * 0.05,
          end: deviceWidth * 0.05,
          top: deviceHeight * 0.035,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.search,
              size: averageSize * 0.035,
              color: AppColors.colorGrey,
            ),
            SizedBox(
              width: deviceWidth * 0.02,
            ),
            Expanded(
              child: Text(AppString.searchHint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: AppColors.colorGrey,
                    // fontSize: averageSize * 0.02,
                    fontWeight: FontWeight.w400,
                  )),
            )
          ],
        ));
  }

  /// this method used to display Image Slider
  Widget _buildImageSlider() {
    return StreamBuilder(
        stream: _homeBloc.storeListSubject.stream,
        builder: (context, asyncSnapshot) {
          // if (!asyncSnapshot.hasData) {
          //   return SizedBox();
          // }
          return Container(
            constraints: BoxConstraints(
              maxHeight: deviceHeight * 0.2,
              maxWidth: deviceWidth,
              minWidth: deviceWidth,
              minHeight: deviceHeight * 0.1,
            ),
            margin: EdgeInsetsDirectional.only(
              top: deviceHeight * 0.025,
            ),
            child: CarouselSlider(
              disableGesture: true,
              options: CarouselOptions(
                  autoPlay: true,
                  // viewportFraction: deviceWidth * 0.0024,
                  viewportFraction: 0.98,
                  initialPage: 0,
                  onPageChanged: (index, c) {
                    _homeBloc.setPageIndex(index);
                  }),
              items: _homeBloc.sortingList.map((items) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth,
                          minWidth: deviceWidth,
                          minHeight: deviceHeight * 0.3,
                        ),
                        margin: EdgeInsetsDirectional.symmetric(
                          horizontal: deviceWidth * 0.02,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(
                            averageSize * 0.028,
                          ),
                          child: Image.network(
                            // items.bannerImage ?? '',
                            'https://picsum.photos/250?image=9',
                            height: deviceHeight * 0.2,
                            width: deviceWidth,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: deviceHeight * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.1),
                                ),
                              );
                            },
                          ),
                        ));
                  },
                );
              }).toList(),
            ),
          );
        });
  }

  /// this method used to display dots of image slider
  Widget _buildDots() {
    return StreamBuilder(
        stream: _homeBloc.storeListSubject.stream,
        builder: (context, asyncSnapshot) {
          // if (!asyncSnapshot.hasData) {
          //   return SizedBox();
          // }

          return Container(
            constraints: BoxConstraints(
              maxHeight: deviceHeight * 0.006,
              minHeight: deviceHeight * 0.004,
            ),
            margin: EdgeInsetsDirectional.symmetric(vertical: deviceHeight * 0.013),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _homeBloc.sortingList.length ?? 0,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: _homeBloc.pageIndex.stream,
                      builder: (context, pageIndexSnapshot) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.01),
                          width: pageIndexSnapshot.data == (index) ? deviceWidth * 0.11 : deviceWidth * 0.03,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(averageSize * 0.02),
                            shape: BoxShape.rectangle,
                            color: pageIndexSnapshot.data == (index)
                                ? AppColors.colorBlack
                                : AppColors.colorBlack.withValues(alpha: 0.2),
                          ),
                        );
                      });
                }),
          );
        });
  }

  /// this method used to display category list
  Widget _buildCategoryList() {
    return StreamBuilder(
        stream: _homeBloc.categoryList.stream,
        builder: (context, categorySnapshot) {
          // if (!categorySnapshot.hasData) {
          //   return SizedBox.shrink();
          // }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: deviceWidth * 0.05,
                  // vertical: averageSize * 0.03,
                ),
                child: Text(
                  '${AppString.categoryTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: AppColors.colorBlack,
                      // fontSize: averageSize * 0.027,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(
                height: deviceHeight * 0.02,
              ),

              Container(
                height: averageSize * 0.45,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: categorySnapshot.data?.productCategoryList?.length ?? 0,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: averageSize * 0.065,
                          backgroundImage: NetworkImage('https://picsum.photos/250?image=9'
                              // '${categorySnapshot.data?.productCategoryList?[index].categoryIcon ?? ''}',
                              ),
                        ),
                        // Container(
                        //   height: averageSize * 0.13,
                        //   width: averageSize * 0.13,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: Image.network(
                        //     '${categorySnapshot.data?.productCategoryList?[index].categoryIcon ?? ''}',
                        //     height: averageSize * 0.13,
                        //     width: averageSize * 0.13,
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        Text(
                            // '${categorySnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
                            index == 2 ? 'Dominos Pizza asdfasdfsafas' : 'ads',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    );
                  },
                ),
              ),
              // Container(
              //   constraints: BoxConstraints(
              //     maxHeight: deviceHeight * 0.3,
              //     minHeight: deviceHeight * 0.15,
              //     maxWidth: deviceWidth,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.m,
              //     children: [
              //       GridView.builder(
              //         shrinkWrap: true,
              //         padding: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.01),
              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           mainAxisSpacing: averageSize * 0.03,
              //           mainAxisExtent: averageSize * 0.15,
              //           crossAxisSpacing: deviceHeight * 0.001,
              //           childAspectRatio: 1.5,
              //         ),
              //
              //         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         //   crossAxisCount: 2,
              //         //   crossAxisSpacing: deviceWidth * 0.3,
              //         //   mainAxisExtent: 100,
              //         // ),
              //
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 1,
              //         itemBuilder: (context, index) {
              //           return Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               CircleAvatar(
              //                 radius: averageSize * 0.065,
              //                 backgroundImage: NetworkImage(
              //                   '${categorySnapshot.data?.productCategoryList?[index].categoryIcon ?? ''}',
              //                 ),
              //                 onBackgroundImageError: (_, __) {
              //                   print('Error loading image');
              //                 },
              //               ),
              //               Expanded(
              //                 child: Text('${categorySnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
              //                     maxLines: 2,
              //                     overflow: TextOverflow.ellipsis,
              //                     textAlign: TextAlign.center,
              //                     style: GoogleFonts.lato(
              //                       color: AppColors.colorBlack,
              //                       fontSize: averageSize * 0.017,
              //                       fontWeight: FontWeight.w400,
              //                     )),
              //               )
              //             ],
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        });
  }

  /// this method used to display Horizontal Sorting list
  Widget _buildSorting() {
    return StreamBuilder(
        stream: _homeBloc.categoryList.stream,
        builder: (context, sortingSnapshot) {
          // if (!sortingSnapshot.hasData) {
          //   return SizedBox.shrink();
          // }
          return Container(
              constraints: BoxConstraints(
                minHeight: deviceHeight * 0.035,
                maxHeight: deviceHeight * 0.045,
              ),
              margin: EdgeInsetsDirectional.only(top: deviceHeight * 0.01),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                        padding: EdgeInsetsDirectional.only(
                          start: averageSize * 0.02,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: _homeBloc.sortingList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: deviceWidth * 0.03,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  border: Border.all(
                                    color: AppColors.colorBlack,
                                  ),
                                  borderRadius: BorderRadiusDirectional.circular(
                                    averageSize * 0.05,
                                  )),
                              margin: EdgeInsetsDirectional.symmetric(
                                horizontal: averageSize * 0.01,
                              ),
                              child: Center(
                                child: index == 0
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: AppColors.colorWhite,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Expanded(
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: deviceWidth,
                                                    maxHeight: deviceHeight * 0.5,
                                                    minHeight: deviceHeight * 0.25,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: deviceHeight * 0.025,
                                                      ),
                                                      Text(
                                                        AppString.sortBy,
                                                        style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                            fontSize: averageSize * 0.023,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: deviceHeight * 0.025,
                                                      ),
                                                      Divider(
                                                        color: AppColors.colorGrey.withValues(alpha: 0.3),
                                                        height: averageSize * 0.001,
                                                        thickness: averageSize * 0.005,
                                                      ),
                                                      StreamBuilder(
                                                          stream: _homeBloc.selectedValue.stream,
                                                          builder: (context, asyncSnapshot) {
                                                            return RadioListTile(
                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                title: Text(AppString.priceHtL,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        fontSize: averageSize * 0.023,
                                                                        color: AppColors.colorBlack,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                dense: true,
                                                                contentPadding: EdgeInsetsDirectional.symmetric(
                                                                    horizontal: averageSize * 0.03),
                                                                value: AppString.priceHtL,
                                                                groupValue: asyncSnapshot.data,
                                                                visualDensity: VisualDensity.compact,
                                                                activeColor: AppColors.colorGreen,
                                                                autofocus: true,
                                                                selectedTileColor: AppColors.colorGreen,
                                                                onChanged: (value) {
                                                                  _homeBloc.selectSortingValues(value!);
                                                                });
                                                          }),
                                                      StreamBuilder(
                                                          stream: _homeBloc.selectedValue.stream,
                                                          builder: (context, asyncSnapshot) {
                                                            return RadioListTile(
                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                activeColor: AppColors.colorGreen,
                                                                dense: true,
                                                                visualDensity: VisualDensity.compact,
                                                                contentPadding: EdgeInsetsDirectional.symmetric(
                                                                    horizontal: averageSize * 0.03),
                                                                title: Text(AppString.priceLtH,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        fontSize: averageSize * 0.023,
                                                                        color: AppColors.colorBlack,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                value: AppString.priceLtH,
                                                                groupValue: asyncSnapshot.data,
                                                                onChanged: (value) {
                                                                  _homeBloc.selectSortingValues(value!);
                                                                });
                                                          }),
                                                      StreamBuilder(
                                                          stream: _homeBloc.selectedValue.stream,
                                                          builder: (context, asyncSnapshot) {
                                                            return RadioListTile(
                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                dense: true,
                                                                visualDensity: VisualDensity.compact,
                                                                contentPadding: EdgeInsetsDirectional.symmetric(
                                                                    horizontal: averageSize * 0.03),
                                                                title: Text(AppString.priceNearBy,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        fontSize: averageSize * 0.023,
                                                                        color: AppColors.colorBlack,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                value: AppString.priceNearBy,
                                                                groupValue: asyncSnapshot.data,
                                                                activeColor: AppColors.colorGreen,
                                                                onChanged: (value) {
                                                                  _homeBloc.selectSortingValues(value!);
                                                                });
                                                          }),
                                                      StreamBuilder(
                                                          stream: _homeBloc.selectedValue.stream,
                                                          builder: (context, asyncSnapshot) {
                                                            return RadioListTile(
                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                dense: true,
                                                                visualDensity: VisualDensity.compact,
                                                                activeColor: AppColors.colorGreen,
                                                                contentPadding: EdgeInsetsDirectional.symmetric(
                                                                    horizontal: averageSize * 0.03),
                                                                title: Text(AppString.DeliveryTime,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        fontSize: averageSize * 0.023,
                                                                        color: AppColors.colorBlack,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                value: AppString.DeliveryTime,
                                                                groupValue: asyncSnapshot.data,
                                                                onChanged: (value) {
                                                                  _homeBloc.selectSortingValues(value!);
                                                                });
                                                          }),
                                                      StreamBuilder(
                                                          stream: _homeBloc.selectedValue.stream,
                                                          builder: (context, asyncSnapshot) {
                                                            return RadioListTile(
                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                dense: true,
                                                                visualDensity: VisualDensity.compact,
                                                                contentPadding: EdgeInsetsDirectional.symmetric(
                                                                    horizontal: averageSize * 0.03),
                                                                title: Text(AppString.ratting,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        fontSize: averageSize * 0.023,
                                                                        color: AppColors.colorBlack,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                value: AppString.ratting,
                                                                groupValue: asyncSnapshot.data,
                                                                activeColor: AppColors.colorGreen,
                                                                onChanged: (value) {
                                                                  _homeBloc.selectSortingValues(value!);
                                                                });
                                                          }),
                                                      SizedBox(
                                                        height: deviceHeight * 0.015,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: deviceWidth * 0.03,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: deviceWidth * 0.44,
                                                              padding:
                                                                  EdgeInsetsDirectional.symmetric(vertical: averageSize * 0.01),
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.colorWhite,
                                                                  borderRadius: BorderRadiusDirectional.circular(
                                                                    averageSize * 0.027,
                                                                  ),
                                                                  border: Border.all(color: AppColors.colorBlack)),
                                                              child: Center(
                                                                child: Text(AppString.clear,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        color: AppColors.colorBlack,
                                                                        fontSize: averageSize * 0.023,
                                                                      ),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: deviceWidth * 0.05,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: deviceWidth * 0.45,
                                                              padding:
                                                                  EdgeInsetsDirectional.symmetric(vertical: averageSize * 0.015),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.colorGreen,
                                                                borderRadius: BorderRadiusDirectional.circular(
                                                                  averageSize * 0.027,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(AppString.applyFilter,
                                                                    style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                        color: AppColors.colorWhite,
                                                                        fontSize: averageSize * 0.023,
                                                                      ),
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: deviceHeight * 0.015,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(_homeBloc.sortingList[index],
                                                style: GoogleFonts.lato(
                                                  color: AppColors.colorBlack,
                                                  fontSize: averageSize * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            Icon(
                                              Icons.arrow_drop_down_sharp,
                                              size: averageSize * 0.022,
                                              color: AppColors.colorBlack,
                                            )
                                          ],
                                        ),
                                      )
                                    : Text(
                                        _homeBloc.sortingList[index],
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.018,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        }),
                    // ListView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: sortingSnapshot.data?.productCategoryList?.length ?? 0,
                    //     itemBuilder: (context, index) {
                    //       return InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           padding: EdgeInsetsDirectional.symmetric(
                    //             horizontal: deviceWidth * 0.03,
                    //             vertical: deviceHeight * 0.001,
                    //           ),
                    //           decoration: BoxDecoration(
                    //               color: AppColors.colorWhite,
                    //               border: Border.all(
                    //                 color: AppColors.colorBlack,
                    //               ),
                    //               borderRadius: BorderRadiusDirectional.circular(averageSize * 0.05)),
                    //           margin: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.0081),
                    //           child: Center(
                    //             child: Text(
                    //               '${sortingSnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
                    //               style: GoogleFonts.lato(
                    //                 color: AppColors.colorBlack,
                    //                 fontSize: averageSize * 0.018,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }),
                  ],
                ),
              ));
        });
  }

  /// this method used to display feature food delivery
  Widget _buildFeatureFoodDelivery() {
    return StreamBuilder(
        stream: _homeBloc.foodDelivery.stream,
        builder: (context, foodDeliverySnapshot) {
          // if (!foodDeliverySnapshot.hasData) {
          //   return SizedBox.shrink();
          // }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: averageSize * 0.03,
                    top: averageSize * 0.03,
                    bottom: averageSize * 0.02,
                  ),
                  child: Text(
                    AppString.featureFoodDelivery,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.027,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                  constraints: BoxConstraints(
                    maxHeight: deviceHeight * 0.3,
                    minHeight: deviceHeight * 0.27,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.04),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: averageSize * 0.035,
                      mainAxisSpacing: averageSize * 0.05,
                      mainAxisExtent: averageSize * 0.5,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusDirectional.circular(
                              deviceWidth * 0.04,
                            ),
                            child: ColorFiltered(
                              colorFilter:
                                  (foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].storeStatus ?? '') == 0
                                      ? ColorFilter.mode(
                                          Colors.grey.withValues(alpha: 0.9),
                                          BlendMode.hue,
                                        )
                                      : ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.color,
                                        ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].storeImage ?? ''}',
                                    width: deviceWidth * 0.3,
                                    height: deviceHeight * 0.3,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: deviceWidth * 0.3,
                                        height: deviceHeight * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  (foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerType) != 0
                                      ? Align(
                                          alignment: AlignmentDirectional.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [AppColors.colorBlack, AppColors.colorBlack.withValues(alpha: 0.01)],
                                                  end: AlignmentDirectional.topCenter,
                                                  begin: AlignmentDirectional.bottomCenter,
                                                  tileMode: TileMode.decal),
                                            ),
                                            width: deviceWidth * 0.3,
                                            height: deviceHeight * 0.1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.symmetric(
                                                    horizontal: averageSize * 0.01,
                                                  ),
                                                  child: Text(
                                                      '\$${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerAmount ?? ''} % Off ',
                                                      textAlign: TextAlign.start,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.lato(
                                                        color: AppColors.colorWhite,
                                                        fontSize: averageSize * 0.02,
                                                        fontWeight: FontWeight.w600,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(
                                                      start: averageSize * 0.01, bottom: averageSize * 0.01),
                                                  child: Text(
                                                      'Order above \$${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerMinAmount ?? ''}',
                                                      textAlign: TextAlign.start,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.lato(
                                                        color: AppColors.colorWhite,
                                                        fontSize: averageSize * 0.02,
                                                        fontWeight: FontWeight.w600,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * 0.04,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                      '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].storeName ?? ''} ',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.023,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: averageSize * 0.025,
                                      color: AppColors.colorBlack,
                                    ),
                                    SizedBox(
                                      width: deviceHeight * 0.005,
                                    ),
                                    Expanded(
                                      child: Text(
                                          '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].etaDeliveryTime ?? ''} ${AppString.min}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.02,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: averageSize * 0.025,
                                      color: AppColors.amber,
                                    ),
                                    SizedBox(
                                      width: deviceHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                          '${(foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].averageRatings ?? '-') == 0 ? '-' : foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].averageRatings}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.018,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    SizedBox(
                                      width: deviceHeight * 0.005,
                                    ),
                                    Expanded(
                                      child: Text(
                                          '${(foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings})'}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.018,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )),
            ],
          );
        });
  }

  /// this method used to display Favorite List
  Widget _buildFavoriteList() {
    return StreamBuilder(
        stream: _homeBloc.favoriteList.stream,
        builder: (context, favoriteSnapshot) {
          if (!favoriteSnapshot.hasData) {
            return SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: averageSize * 0.03,
                    ),
                    child: Text(
                      '${favoriteSnapshot.data?.displayTitleName ?? AppString.favorite}',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: AppColors.colorBlack,
                          fontSize: averageSize * 0.027,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToPush(
                          context,
                          FavoriteRestaurantsScreen(
                            favoriteModal: favoriteSnapshot.data,
                          ));
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: deviceWidth * 0.018,
                        vertical: deviceHeight * 0.001,
                      ),
                      margin: EdgeInsetsDirectional.only(
                        end: averageSize * 0.03,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.colorGrey,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadiusDirectional.circular(averageSize * 0.02)),
                      child: Text('${AppString.viewAll}',
                          style: GoogleFonts.lato(
                            color: AppColors.colorBlack,
                            fontSize: averageSize * 0.016,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.005,
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: deviceHeight * 0.3,
                  minHeight: deviceHeight * 0.27,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.01),
                    itemCount:
                        (favoriteSnapshot.data?.storeLists?.length ?? 0) > 3 ? 3 : favoriteSnapshot.data?.storeLists?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: deviceWidth * 0.35,
                            minWidth: deviceWidth * 0.3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.colorGrey.withValues(alpha: 0.5),
                                offset: Offset(0.0, 0.5),
                                blurRadius: 3,
                              ),
                              BoxShadow(
                                color: AppColors.colorGrey.withValues(alpha: 0.5),
                                offset: Offset(0.0, 0.5),
                                blurRadius: 3,
                              ),
                            ],
                            borderRadius: BorderRadiusDirectional.circular(
                              averageSize * 0.02,
                            ),
                          ),
                          margin: EdgeInsetsDirectional.symmetric(
                            horizontal: averageSize * 0.015,
                            vertical: averageSize * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusDirectional.circular(
                                  averageSize * 0.02,
                                ),
                                child: Stack(
                                  children: [
                                    ColorFiltered(
                                      colorFilter: (favoriteSnapshot.data?.storeLists?[index].storeStatus ?? '') == 0
                                          ? ColorFilter.mode(
                                              Colors.grey.withValues(alpha: 0.9),
                                              BlendMode.hue,
                                            )
                                          : ColorFilter.mode(
                                              Colors.transparent,
                                              BlendMode.color,
                                            ),
                                      child: Image.network(
                                        '${favoriteSnapshot.data?.storeLists?[index].storeBanner ?? ''}',
                                        fit: BoxFit.fill,
                                        width: deviceWidth,
                                        height: deviceHeight * 0.12,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: deviceHeight * 0.13,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(alpha: 0.1),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    (favoriteSnapshot.data?.storeLists?[index].offerType) != 0
                                        ? Container(
                                            margin: EdgeInsetsDirectional.only(
                                              top: averageSize * 0.042,
                                              start: averageSize * 0.02,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    AppColors.colorBlack,
                                                    AppColors.colorBlack.withValues(
                                                      alpha: 0.01,
                                                    )
                                                  ],
                                                  end: AlignmentDirectional.topCenter,
                                                  begin: AlignmentDirectional.bottomCenter,
                                                  tileMode: TileMode.decal),
                                            ),
                                            width: deviceWidth,
                                            height: deviceHeight * 0.088,
                                            child: Align(
                                              alignment: AlignmentDirectional.bottomCenter,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    '\$${favoriteSnapshot.data?.storeLists?[index].offerAmount ?? ''} % Off ',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.colorWhite,
                                                      fontSize: averageSize * 0.02,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Order above \$${favoriteSnapshot.data?.storeLists?[index].offerMinAmount ?? ''}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.colorWhite,
                                                      fontSize: averageSize * 0.02,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: deviceWidth * 0.005,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: averageSize * 0.02,
                                  top: deviceHeight * 0.005,
                                ),
                                child: Text(
                                  '${(favoriteSnapshot.data?.storeLists?[index].storeName) ?? '-'}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.lato(
                                    color: AppColors.colorBlack,
                                    fontSize: averageSize * 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: averageSize * 0.02,
                                  top: deviceHeight * 0.004,
                                  bottom: deviceHeight * 0.006,
                                ),
                                child: Text('${favoriteSnapshot.data?.storeLists?[index].storeProducts ?? '-'}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                      color: AppColors.colorBlack.withValues(alpha: 0.5),
                                      fontSize: averageSize * 0.015,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: deviceWidth * 0.03,
                                  ),
                                  Icon(
                                    Icons.watch_later_outlined,
                                    size: averageSize * 0.028,
                                    color: AppColors.colorBlack,
                                  ),
                                  SizedBox(
                                    width: deviceWidth * 0.01,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                        '${(favoriteSnapshot.data?.storeLists?[index].orderDeliveryTime ?? '-') == 0 ? '-' : '${favoriteSnapshot.data?.storeLists?[index].orderDeliveryTime} ${AppString.min}'} ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.015,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: deviceWidth * 0.03,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: averageSize * 0.025,
                                    color: AppColors.amber,
                                  ),
                                  SizedBox(
                                    width: deviceWidth * 0.01,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                        '${(favoriteSnapshot.data?.storeLists?[index].averageRatings ?? '-') == 0 ? '-' : favoriteSnapshot.data?.storeLists?[index].averageRatings}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.015,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: Text(
                                          ' ${(favoriteSnapshot.data?.storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${favoriteSnapshot.data?.storeLists?[index].noOfRatings})'}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.015,
                                            fontWeight: FontWeight.w400,
                                          ))),
                                  SizedBox(
                                    height: deviceHeight * 0.04,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        });
  }

  /// this method used to display Near Restaurants
  Widget _buildNearRestaurant() {
    return StreamBuilder(
        stream: _homeBloc.storeListSubject.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: deviceWidth * 0.04,
                  vertical: deviceWidth * 0.02,
                ),
                child: Text('${(snapshot.data?.displayTitleName ?? '-')}',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.027,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                      fontWeight: FontWeight.w600,
                    )),
              ),
              ListView.builder(
                  itemCount: snapshot.data?.storeList?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsetsDirectional.symmetric(
                        vertical: averageSize * 0.025,
                        horizontal: averageSize * 0.02,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadiusDirectional.circular(
                                    averageSize * 0.029,
                                  ),
                                  child: ColorFiltered(
                                    colorFilter: (snapshot.data?.storeList?[index].storeStatus ?? '') == 0
                                        ? ColorFilter.mode(
                                            Colors.grey.withValues(alpha: 0.9),
                                            BlendMode.hue,
                                          )
                                        : ColorFilter.mode(
                                            Colors.transparent,
                                            BlendMode.color,
                                          ),
                                    child: Image.network(
                                      '${snapshot.data?.storeList?[index].storeBanner ?? ''}',
                                      colorBlendMode: BlendMode.luminosity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: deviceHeight * 0.22,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                        );
                                      },
                                      height: deviceHeight * 0.21,
                                      fit: BoxFit.fill,
                                      width: deviceWidth,
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: deviceWidth * 0.025,
                                    vertical: deviceWidth * 0.025,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.colorWhite,
                                        radius: averageSize * 0.021,
                                        child: (snapshot.data?.storeList?[index].isFavStore ?? '') == 1
                                            ? Icon(
                                                Icons.favorite,
                                                color: AppColors.colorRed,
                                                size: averageSize * 0.035,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: AppColors.colorBlack,
                                                size: averageSize * 0.035,
                                              ),
                                      ),
                                    ),
                                  )),
                              (snapshot.data?.storeList?[index].offerType) != 0
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(top: deviceWidth * 0.17),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.only(
                                            bottomStart: Radius.circular(deviceWidth * 0.045),
                                            bottomEnd: Radius.circular(deviceWidth * 0.045),
                                          ),
                                          gradient: LinearGradient(
                                              colors: [
                                                AppColors.colorBlack,
                                                AppColors.colorBlack.withValues(alpha: 0.6),
                                                AppColors.colorBlack.withValues(alpha: 0.01)
                                              ],
                                              end: AlignmentDirectional.topCenter,
                                              begin: AlignmentDirectional.bottomCenter,
                                              tileMode: TileMode.decal),
                                        ),
                                        width: deviceWidth,
                                        height: deviceHeight * 0.132,
                                        child: Align(
                                          alignment: AlignmentDirectional.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.symmetric(
                                                horizontal: deviceWidth * 0.03, vertical: deviceWidth * 0.02),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('\$${snapshot.data?.storeList?[index].offerAmount ?? ''} % Off',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.colorWhite,
                                                      fontSize: averageSize * 0.02,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                                Text(' Order above \$${snapshot.data?.storeList?[index].offerMinAmount ?? ''}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                      color: AppColors.colorWhite,
                                                      fontSize: averageSize * 0.02,
                                                      fontWeight: FontWeight.w600,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: averageSize * 0.02,
                              bottom: deviceHeight * 0.005,
                            ),
                            child: Text('${snapshot.data?.storeList?[index].storeName ?? '-'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  color: AppColors.colorBlack,
                                  fontSize: averageSize * 0.023,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: deviceWidth * 0.03,
                              bottom: deviceHeight * 0.005,
                            ),
                            child: Text('${snapshot.data?.storeList?[index].storeProducts ?? '-'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  color: AppColors.colorBlack.withValues(alpha: 0.5),
                                  fontSize: averageSize * 0.018,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: averageSize * 0.028,
                                  color: AppColors.colorBlack,
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.01,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                      '${(snapshot.data?.storeList?[index].orderDeliveryTime ?? '-') == 0 ? '-' : '${snapshot.data?.storeList?[index].orderDeliveryTime} ${AppString.min}'} ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.018,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                                SizedBox(
                                  width: averageSize * 0.01,
                                ),
                                Text('|',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      color: AppColors.colorBlack,
                                      fontSize: averageSize * 0.02,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  width: deviceWidth * 0.03,
                                ),
                                Icon(
                                  Icons.star,
                                  size: averageSize * 0.028,
                                  color: AppColors.amber,
                                ),
                                SizedBox(
                                  width: averageSize * 0.015,
                                ),
                                Text(
                                    '${(snapshot.data?.storeList?[index].averageRatings ?? '-') == 0 ? '-' : snapshot.data?.storeList?[index].averageRatings} ',
                                    style: GoogleFonts.lato(
                                      color: AppColors.colorBlack,
                                      fontSize: averageSize * 0.018,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                    '${(snapshot.data?.storeList?[index].noOfRatings ?? '-') == 0 ? '-' : '(${snapshot.data?.storeList?[index].noOfRatings})'}',
                                    style: GoogleFonts.lato(
                                      color: AppColors.colorBlack,
                                      fontSize: averageSize * 0.018,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
