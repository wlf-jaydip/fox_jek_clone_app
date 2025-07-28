import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staging_fox_jek_clone_app/constants/app_color.dart';
import 'package:staging_fox_jek_clone_app/constants/app_string.dart';
import 'package:staging_fox_jek_clone_app/constants/size_constants.dart';
import 'package:staging_fox_jek_clone_app/screen/homeScreen/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: AppColors.colorBlack.withValues(alpha: 0.2),
        elevation: deviceWidth * 0.05,
        backgroundColor: AppColors.colorWhite,
        toolbarOpacity: 0.5,
        surfaceTintColor: AppColors.colorWhite,
        bottomOpacity: 10,
        useDefaultSemanticsOrder: true,
        foregroundColor: AppColors.colorBlack,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_outlined,
              color: AppColors.colorBlack,
            ),
            SizedBox(
              width: deviceWidth * 0.03,
            ),
            Image.asset(
              'assets/images/location.png',
              fit: BoxFit.fill,
              width: averageSize * 0.00017,
            ),
            SizedBox(
              width: deviceWidth * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.yourLocation,
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: averageSize * 0.00007,
                    fontWeight: FontWeight.w500,
                    letterSpacing: deviceWidth * 0.003,
                    color: AppColors.colorBlack.withValues(alpha: 0.4),
                  ),
                ),
                SizedBox(
                  width: averageSize * 0.00155,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          AppString.currentsLocation,
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: averageSize * 0.00008,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.colorBlack,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: _buildHomeScreen(),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchText(),
          _buildImageSlider(),
          SizedBox(
            height: deviceWidth * 0.02,
          ),
          _buildCategoryList(),
          SizedBox(
            height: deviceWidth * 0.02,
          ),
          _buildFeatureFoodDelivery(),
          SizedBox(
            height: deviceWidth * 0.051,
          ),
          _buildNearRestaurant()
        ],
      ),
    );
  }

  Widget _buildSearchText() {
    return Container(
      height: averageSize * 0.00025,
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceWidth * 0.05,
      ),
      child: TextFormField(
        controller: _homeBloc.searchController,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: AppString.searchHint,
            hintStyle: GoogleFonts.aBeeZee(
              color: AppColors.colorBlack.withValues(alpha: 0.5),
              fontSize: averageSize * 0.00007,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                deviceWidth * 0.048,
              ),
            ),
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder(
            stream: _homeBloc.storeListSubject.stream,
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) CircularProgressIndicator();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarouselSlider(
                    disableGesture: true,
                    options: CarouselOptions(
                        height: averageSize * 0.0009,
                        autoPlay: true,
                        viewportFraction: deviceWidth * 0.0024,
                        initialPage: 0,
                        onPageChanged: (index, c) {
                          _homeBloc.setPageIndex(index);
                        }),
                    items: asyncSnapshot.data?.serviceSliderData?.map((items) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: deviceWidth * 0.9,
                              decoration: BoxDecoration(color: AppColors.colorWhite),
                              margin: EdgeInsetsDirectional.symmetric(
                                horizontal: deviceWidth * 0.001,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusDirectional.circular(
                                  deviceWidth * 0.035,
                                ),
                                child: Image.network(
                                  items.bannerImage ?? '',
                                  height: averageSize * 0.2,
                                  width: averageSize,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: averageSize * 0.001,
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
                  SizedBox(
                    height: deviceWidth * 0.03,
                  ),
                  SizedBox(
                    height: deviceWidth * 0.012,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: asyncSnapshot.data?.serviceSliderData?.length ?? 0,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: _homeBloc.pageIndex.stream,
                              builder: (context, pageIndexSnapshot) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: EdgeInsetsDirectional.symmetric(
                                    horizontal: deviceWidth * 0.01,
                                  ),
                                  width: pageIndexSnapshot.data == (index) ? deviceWidth * 0.1 : deviceWidth * 0.025,
                                  decoration: BoxDecoration(
                                    color: pageIndexSnapshot.data == (index)
                                        ? AppColors.colorBlack
                                        : AppColors.colorBlack.withValues(alpha: 0.2),
                                    borderRadius: BorderRadiusDirectional.horizontal(
                                      start: Radius.circular(deviceWidth * 0.01),
                                      end: Radius.circular(
                                        deviceWidth * 0.01,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  )
                ],
              );
            }),
      ],
    );
  }

  Widget _buildCategoryList() {
    return StreamBuilder(
        stream: _homeBloc.categoryList.stream,
        builder: (context, categorySnapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: averageSize * 0.00009,
                  vertical: averageSize * 0.00009,
                ),
                child: Text('${AppString.categoryTitle}',
                    style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.0001,
                        fontWeight: FontWeight.w600,
                        letterSpacing: deviceWidth * 0.002)),
              ),
              SizedBox(
                  height: averageSize * 0.0014,
                  child: GridView.builder(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.02),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: averageSize * 0.00001,
                        mainAxisSpacing: averageSize * 0.0001,
                        mainAxisExtent: averageSize * 0.0005),
                    scrollDirection: Axis.horizontal,
                    itemCount: categorySnapshot.data?.productCategoryList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: averageSize * 0.00022,
                            backgroundImage: NetworkImage(
                              '${categorySnapshot.data?.productCategoryList?[index].categoryIcon ?? ''}',
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${categorySnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          )
                        ],
                      );
                    },
                  )),
            ],
          );
        });
  }

  Widget _buildFeatureFoodDelivery() {
    return StreamBuilder(
        stream: _homeBloc.foodDelivery.stream,
        builder: (context, foodDeliverySnapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: averageSize * 0.00009,
                  vertical: averageSize * 0.00006,
                ),
                child: Text(AppString.featureFoodDelivery,
                    style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.0001,
                        fontWeight: FontWeight.w600,
                        letterSpacing: deviceWidth * 0.002)),
              ),
              SizedBox(
                  height: averageSize * 0.0013,
                  child: GridView.builder(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.05),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: averageSize * 0.0001,
                      mainAxisSpacing: averageSize * 0.0001,
                      mainAxisExtent: averageSize * 0.0018,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusDirectional.circular(deviceWidth * 0.05),
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
                                    width: averageSize * 0.00063,
                                    height: averageSize * 0.00063,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: averageSize * 0.0006,
                                        height: averageSize * 0.0006,
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
                                            width: averageSize * 0.00063,
                                            height: averageSize * 0.0004,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.symmetric(
                                                    horizontal: averageSize * 0.00004,
                                                  ),
                                                  child: Text(
                                                    '\$${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerAmount ?? ''} % Off ',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: deviceWidth * 0.044,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.colorWhite),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(
                                                      start: averageSize * 0.00004, bottom: averageSize * 0.00006),
                                                  child: Text(
                                                    'Order above \$${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerMinAmount ?? ''}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: averageSize * 0.00006,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.colorWhite),
                                                  ),
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
                            width: averageSize * 0.00011,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: averageSize * 0.001,
                                child: Text(
                                  '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].storeName ?? ''} ',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: averageSize * 0.0001, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: averageSize * 0.00005,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    size: averageSize * 0.00008,
                                    color: AppColors.colorBlack.withValues(alpha: 0.5),
                                  ),
                                  SizedBox(
                                    width: averageSize * 0.00002,
                                  ),
                                  Text(
                                      '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].etaDeliveryTime ?? ''} ${AppString.min}',
                                      style: TextStyle(
                                        color: AppColors.colorBlack.withValues(alpha: 0.5),
                                        fontSize: deviceWidth * 0.035,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: averageSize * 0.00003,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: averageSize * 0.00009,
                                    color: AppColors.amber,
                                  ),
                                  SizedBox(
                                    width: averageSize * 0.00002,
                                  ),
                                  Text(
                                      '${(foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].averageRatings ?? '-') == 0 ? '-' : foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].averageRatings}',
                                      style: TextStyle(
                                        color: AppColors.colorBlack.withValues(alpha: 0.5),
                                        fontSize: deviceWidth * 0.03,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(
                                    width: averageSize * 0.00002,
                                  ),
                                  Text(
                                      '${(foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings})'}',
                                      style: TextStyle(
                                        color: AppColors.colorBlack.withValues(alpha: 0.5),
                                        fontSize: deviceWidth * 0.03,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  )),
            ],
          );
        });
  }

  Widget _buildNearRestaurant() {
    return StreamBuilder(
        stream: _homeBloc.storeListSubject.stream,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: deviceWidth * 0.05,
                  vertical: deviceWidth * 0.02,
                ),
                child: Text('${(snapshot.data?.displayTitleName ?? '-')}',
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: averageSize * 0.0001,
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
                        vertical: averageSize * 0.00002,
                        horizontal: averageSize * 0.00008,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadiusDirectional.circular(
                                    deviceWidth * 0.045,
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
                                          height: averageSize * 0.001,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                        );
                                      },
                                      height: averageSize * 0.001,
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
                                        radius: deviceWidth * 0.03,
                                        child: (snapshot.data?.storeList?[index].isFavStore ?? '') == 1
                                            ? Icon(
                                                Icons.favorite,
                                                color: AppColors.colorRed,
                                                size: deviceWidth * 0.05,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: AppColors.colorBlack,
                                                size: deviceWidth * 0.05,
                                              ),
                                      ),
                                    ),
                                  )),
                              (snapshot.data?.storeList?[index].offerType) != 0
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(top: deviceWidth * 0.16),
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
                                        height: averageSize * 0.00065,
                                        child: Align(
                                          alignment: AlignmentDirectional.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.symmetric(
                                                horizontal: deviceWidth * 0.03, vertical: deviceWidth * 0.02),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '\$${snapshot.data?.storeList?[index].offerAmount ?? ''} % Off ',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: averageSize * 0.00008,
                                                      fontWeight: FontWeight.w800,
                                                      color: AppColors.colorWhite),
                                                ),
                                                Text(
                                                  'Order above \$${snapshot.data?.storeList?[index].offerMinAmount ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: averageSize * 0.00008,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.colorWhite),
                                                ),
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
                            height: averageSize * 0.00005,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: averageSize * 0.00006),
                            child: Text('${snapshot.data?.storeList?[index].storeName ?? '-'}',
                                style: TextStyle(
                                  color: AppColors.colorBlack,
                                  fontSize: deviceWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(
                            height: averageSize * 0.00001,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                            child: Text('${snapshot.data?.storeList?[index].storeProducts ?? '-'}',
                                style: TextStyle(
                                  color: AppColors.colorBlack.withValues(alpha: 0.5),
                                  fontSize: deviceWidth * 0.03,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: averageSize * 0.00008,
                                  color: AppColors.colorBlack,
                                ),
                                SizedBox(
                                  width: averageSize * 0.00002,
                                ),
                                Text(
                                    '${(snapshot.data?.storeList?[index].orderDeliveryTime ?? '-') == 0 ? '-' : '${snapshot.data?.storeList?[index].orderDeliveryTime} ${AppString.min}'} ',
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: deviceWidth * 0.03,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  width: averageSize * 0.000051,
                                ),
                                Text('|',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: averageSize * 0.0001,
                                      fontWeight: FontWeight.w100,
                                    )),
                                SizedBox(
                                  width: averageSize * 0.00007,
                                ),
                                Icon(
                                  Icons.star,
                                  size: averageSize * 0.00009,
                                  color: AppColors.amber,
                                ),
                                SizedBox(
                                  width: averageSize * 0.00005,
                                ),
                                Text(
                                    '${(snapshot.data?.storeList?[index].averageRatings ?? '-') == 0 ? '-' : snapshot.data?.storeList?[index].averageRatings} ',
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: deviceWidth * 0.03,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                    '${(snapshot.data?.storeList?[index].noOfRatings ?? '-') == 0 ? '-' : '(${snapshot.data?.storeList?[index].noOfRatings})'}',
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: deviceWidth * 0.03,
                                      fontWeight: FontWeight.w500,
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
