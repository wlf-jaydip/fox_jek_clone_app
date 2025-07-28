import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staging_fox_jek_clone_app/constants/app_color.dart';
import 'package:staging_fox_jek_clone_app/constants/app_string.dart';
import 'package:staging_fox_jek_clone_app/constants/size_constants.dart';
import 'package:staging_fox_jek_clone_app/screen/favoriteRestaurant/favorite_restaurants_screen.dart';
import 'package:staging_fox_jek_clone_app/screen/homeScreen/home_bloc.dart';
import 'package:staging_fox_jek_clone_app/utils/utils.dart';

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
      backgroundColor: AppColors.colorWhite,
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
            height: deviceWidth * 0.03,
          ),
          _buildSorting(),
          SizedBox(
            height: deviceWidth * 0.03,
          ),
          _buildFeatureFoodDelivery(),
          SizedBox(
            height: deviceWidth * 0.02,
          ),
          _buildFavoriteList(),
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
                deviceWidth * 0.046,
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
                    height: averageSize * 0.000025,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: asyncSnapshot.data?.serviceSliderData?.length ?? 0,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: _homeBloc.pageIndex.stream,
                              builder: (context, pageIndexSnapshot) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.00002),
                                  width: pageIndexSnapshot.data == (index) ? averageSize * 0.00025 : averageSize * 0.00007,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(deviceWidth * 0.02),
                                    shape: BoxShape.rectangle,
                                    color: pageIndexSnapshot.data == (index)
                                        ? AppColors.colorBlack
                                        : AppColors.colorBlack.withValues(alpha: 0.2),
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
                  vertical: averageSize * 0.0001,
                ),
                child: Text('${AppString.categoryTitle}',
                    style: GoogleFonts.lato(
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
                            child: Text('${categorySnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    color: AppColors.colorBlack,
                                    fontSize: averageSize * 0.00007,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: deviceWidth * 0.002)),
                          )
                        ],
                      );
                    },
                  )),
            ],
          );
        });
  }

  Widget _buildSorting() {
    return StreamBuilder(
        stream: _homeBloc.categoryList.stream,
        builder: (context, sortingSnapshot) {
          return SizedBox(
              height: averageSize * 0.00022,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.builder(
                        padding: EdgeInsetsDirectional.only(start: averageSize * 0.00005),
                        scrollDirection: Axis.horizontal,
                        itemCount: _homeBloc.sortingList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: averageSize * 0.00005,
                                vertical: averageSize * 0.00002,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  border: Border.all(
                                    color: AppColors.colorBlack,
                                  ),
                                  borderRadius: BorderRadiusDirectional.circular(averageSize * 0.0002)),
                              margin: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.00003),
                              child: Center(
                                child: index == 0
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: AppColors.colorWhite,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: deviceWidth,
                                                    height: averageSize * 0.0023,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          AppString.sortBy,
                                                          style: TextStyle(
                                                              fontSize: averageSize * 0.0001, fontWeight: FontWeight.bold),
                                                        ),
                                                        Divider(
                                                          color: AppColors.colorGrey.withValues(alpha: 0.3),
                                                          height: averageSize * 0.0002,
                                                          thickness: averageSize * 0.000015,
                                                        ),
                                                        StreamBuilder(
                                                            stream: _homeBloc.selectedValue.stream,
                                                            builder: (context, asyncSnapshot) {
                                                              return RadioListTile(
                                                                  controlAffinity: ListTileControlAffinity.trailing,
                                                                  title: Text(
                                                                    AppString.priceHtL,
                                                                    style: TextStyle(
                                                                      fontSize: averageSize * 0.00008,
                                                                      color: AppColors.colorBlack,
                                                                    ),
                                                                  ),
                                                                  dense: true,
                                                                  contentPadding: EdgeInsetsDirectional.symmetric(
                                                                      horizontal: averageSize * 0.00008),
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
                                                                      horizontal: averageSize * 0.00008),
                                                                  title: Text(
                                                                    AppString.priceLtH,
                                                                    style: TextStyle(
                                                                      fontSize: averageSize * 0.00008,
                                                                      color: AppColors.colorBlack,
                                                                    ),
                                                                  ),
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
                                                                      horizontal: averageSize * 0.00008),
                                                                  title: Text(
                                                                    AppString.priceNearBy,
                                                                    style: TextStyle(
                                                                      fontSize: averageSize * 0.00008,
                                                                      color: AppColors.colorBlack,
                                                                    ),
                                                                  ),
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
                                                                      horizontal: averageSize * 0.00008),
                                                                  title: Text(
                                                                    AppString.DeliveryTime,
                                                                    style: TextStyle(
                                                                      fontSize: averageSize * 0.00008,
                                                                      color: AppColors.colorBlack,
                                                                    ),
                                                                  ),
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
                                                                      horizontal: averageSize * 0.00008),
                                                                  title: Text(
                                                                    AppString.ratting,
                                                                    style: TextStyle(
                                                                      fontSize: averageSize * 0.00008,
                                                                      color: AppColors.colorBlack,
                                                                    ),
                                                                  ),
                                                                  value: AppString.ratting,
                                                                  groupValue: asyncSnapshot.data,
                                                                  activeColor: AppColors.colorGreen,
                                                                  onChanged: (value) {
                                                                    _homeBloc.selectSortingValues(value!);
                                                                  });
                                                            }),
                                                        SizedBox(
                                                          height: averageSize * 0.00015,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: averageSize * 0.0001,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                width: averageSize * 0.00094,
                                                                padding: EdgeInsetsDirectional.symmetric(
                                                                    vertical: averageSize * 0.00005),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors.colorWhite,
                                                                    borderRadius: BorderRadiusDirectional.circular(
                                                                      averageSize * 0.00008,
                                                                    ),
                                                                    border: Border.all(color: AppColors.colorBlack)),
                                                                child: Center(
                                                                  child: Text(
                                                                    AppString.clear,
                                                                    style: TextStyle(fontSize: averageSize * 0.00008),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: averageSize * 0.0001,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                width: averageSize * 0.00094,
                                                                padding: EdgeInsetsDirectional.symmetric(
                                                                    vertical: averageSize * 0.00005),
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.colorGreen,
                                                                  borderRadius: BorderRadiusDirectional.circular(
                                                                    averageSize * 0.00008,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    AppString.applyFilter,
                                                                    style: TextStyle(
                                                                        color: AppColors.colorWhite,
                                                                        fontSize: averageSize * 0.00008),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                                                    fontSize: averageSize * 0.00008,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: deviceWidth * 0.002)),
                                            Icon(Icons.arrow_drop_down_sharp)
                                          ],
                                        ),
                                      )
                                    : Text(
                                        _homeBloc.sortingList[index],
                                        style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.00008,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: deviceWidth * 0.002),
                                      ),
                              ),
                            ),
                          );
                        }),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: sortingSnapshot.data?.productCategoryList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: averageSize * 0.00005,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  border: Border.all(
                                    color: AppColors.colorBlack,
                                  ),
                                  borderRadius: BorderRadiusDirectional.circular(averageSize * 0.0002)),
                              margin: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.00003),
                              child: Center(
                                child: Text(
                                  '${sortingSnapshot.data?.productCategoryList?[index].productCategoryName ?? ''}',
                                  style: GoogleFonts.lato(
                                      color: AppColors.colorBlack,
                                      fontSize: averageSize * 0.00008,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: deviceWidth * 0.002),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ));
        });
  }

  Widget _buildFavoriteList() {
    return StreamBuilder(
        stream: _homeBloc.favoriteList.stream,
        builder: (context, favoriteSnapshot) {
          if (!favoriteSnapshot.hasData) {
            return SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: averageSize * 0.00009,
                  vertical: averageSize * 0.00009,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${favoriteSnapshot.data?.displayTitleName ?? AppString.favorite}',
                        style: GoogleFonts.lato(
                            color: AppColors.colorBlack,
                            fontSize: averageSize * 0.0001,
                            fontWeight: FontWeight.w600,
                            letterSpacing: deviceWidth * 0.002)),
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
                          horizontal: averageSize * 0.00005,
                          vertical: averageSize * 0.00001,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorBlack.withValues(alpha: 0.5), width: averageSize * 0.000008),
                            borderRadius: BorderRadiusDirectional.circular(averageSize * 0.0002)),
                        child: Text('${AppString.viewAll}',
                            style: GoogleFonts.lato(
                                color: AppColors.colorBlack,
                                fontSize: averageSize * 0.00006,
                                fontWeight: FontWeight.w600,
                                letterSpacing: deviceWidth * 0.002)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: averageSize * 0.0013,
                child: ListView.builder(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: averageSize * 0.00005),
                    itemCount:
                        (favoriteSnapshot.data?.storeLists?.length ?? 0) > 3 ? 3 : favoriteSnapshot.data?.storeLists?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: averageSize * 0.00085,
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
                            averageSize * 0.0001,
                          ),
                        ),
                        margin: EdgeInsetsDirectional.symmetric(
                          horizontal: averageSize * 0.00005,
                          vertical: averageSize * 0.00001,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(
                                averageSize * 0.0001,
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    '${favoriteSnapshot.data?.storeLists?[index].storeBanner ?? ''}',
                                    fit: BoxFit.fill,
                                    width: averageSize * 0.00085,
                                    height: averageSize * 0.0006,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: averageSize * 0.001,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.1),
                                        ),
                                      );
                                    },
                                  ),
                                  (favoriteSnapshot.data?.storeLists?[index].offerType) != 0
                                      ? Container(
                                          margin: EdgeInsetsDirectional.only(
                                            top: averageSize * 0.0002,
                                            start: averageSize * 0.000051,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [AppColors.colorBlack, AppColors.colorBlack.withValues(alpha: 0.01)],
                                                end: AlignmentDirectional.topCenter,
                                                begin: AlignmentDirectional.bottomCenter,
                                                tileMode: TileMode.decal),
                                          ),
                                          width: averageSize * 0.00075,
                                          height: averageSize * 0.0004,
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
                                                      fontSize: averageSize * 0.00008,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: deviceWidth * 0.002),
                                                ),
                                                Text(
                                                  'Order above \$${favoriteSnapshot.data?.storeLists?[index].offerMinAmount ?? ''}',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      color: AppColors.colorWhite,
                                                      fontSize: averageSize * 0.00006,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: deviceWidth * 0.002),
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
                            SizedBox(
                              height: averageSize * 0.00005,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: averageSize * 0.00006),
                              child: Text(
                                '${(favoriteSnapshot.data?.storeLists?[index].storeName) ?? '-'}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                    color: AppColors.colorBlack,
                                    fontSize: averageSize * 0.0001,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: deviceWidth * 0.002),
                              ),
                            ),
                            SizedBox(
                              height: averageSize * 0.00002,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                              child: Text('${favoriteSnapshot.data?.storeLists?[index].storeProducts ?? '-'}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.lato(
                                    color: AppColors.colorBlack,
                                    fontSize: averageSize * 0.00008,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            SizedBox(
                              height: averageSize * 0.00002,
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
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                        '${(favoriteSnapshot.data?.storeLists?[index].orderDeliveryTime ?? '-') == 0 ? '-' : '${favoriteSnapshot.data?.storeLists?[index].orderDeliveryTime} ${AppString.min}'} ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.00008,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: averageSize * 0.00009,
                                    color: AppColors.amber,
                                  ),
                                  SizedBox(
                                    width: averageSize * 0.00002,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                        '${(favoriteSnapshot.data?.storeLists?[index].averageRatings ?? '-') == 0 ? '-' : favoriteSnapshot.data?.storeLists?[index].averageRatings}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.00008,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: Text(
                                          '${(favoriteSnapshot.data?.storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${favoriteSnapshot.data?.storeLists?[index].noOfRatings})'}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.lato(
                                              color: AppColors.colorBlack,
                                              fontSize: averageSize * 0.00008,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: deviceWidth * 0.002))),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: averageSize * 0.00009,
                  vertical: averageSize * 0.00006,
                ),
                child: Text(AppString.featureFoodDelivery,
                    style: GoogleFonts.lato(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.0001,
                        fontWeight: FontWeight.w600,
                        letterSpacing: deviceWidth * 0.002)),
              ),
              SizedBox(
                  height: averageSize * 0.0014,
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
                      return SizedBox(
                        height: averageSize * 0.0014,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(deviceWidth * 0.04),
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
                                      width: averageSize * 0.00065,
                                      height: averageSize * 0.00068,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: averageSize * 0.00065,
                                          height: averageSize * 0.00068,
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
                                              width: averageSize * 0.00065,
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
                                                        style: GoogleFonts.lato(
                                                            color: AppColors.colorWhite,
                                                            fontSize: averageSize * 0.0001,
                                                            fontWeight: FontWeight.w600,
                                                            letterSpacing: deviceWidth * 0.002)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: averageSize * 0.00004, bottom: averageSize * 0.00006),
                                                    child: Text(
                                                        'Order above \$${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].offerMinAmount ?? ''}',
                                                        textAlign: TextAlign.start,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.lato(
                                                            color: AppColors.colorWhite,
                                                            fontSize: averageSize * 0.00006,
                                                            fontWeight: FontWeight.w600,
                                                            letterSpacing: deviceWidth * 0.002)),
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
                                      style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.0001,
                                        fontWeight: FontWeight.w600,
                                      )),
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
                                      color: AppColors.colorBlack,
                                    ),
                                    SizedBox(
                                      width: averageSize * 0.00002,
                                    ),
                                    Text(
                                        '${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].etaDeliveryTime ?? ''} ${AppString.min}',
                                        style: GoogleFonts.lato(
                                            color: AppColors.colorBlack,
                                            fontSize: averageSize * 0.00007,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: deviceWidth * 0.002)),
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
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.00008,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(
                                      width: averageSize * 0.00002,
                                    ),
                                    Text(
                                        '${(foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${foodDeliverySnapshot.data?.allFeatureStore?[0].storeLists?[index].noOfRatings})'}',
                                        style: GoogleFonts.lato(
                                          color: AppColors.colorBlack,
                                          fontSize: averageSize * 0.00008,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
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
                    style: GoogleFonts.lato(
                        color: AppColors.colorBlack,
                        fontSize: averageSize * 0.0001,
                        fontWeight: FontWeight.w600,
                        letterSpacing: deviceWidth * 0.002)),
              ),
              ListView.builder(
                  itemCount: snapshot.data?.storeList?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsetsDirectional.symmetric(
                        vertical: averageSize * 0.00006,
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
                                                Text('\$${snapshot.data?.storeList?[index].offerAmount ?? ''} % Off ',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                        color: AppColors.colorWhite,
                                                        fontSize: averageSize * 0.00008,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: deviceWidth * 0.002)),
                                                Text(' Order above \$${snapshot.data?.storeList?[index].offerMinAmount ?? ''}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lato(
                                                        color: AppColors.colorWhite,
                                                        fontSize: averageSize * 0.00008,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: deviceWidth * 0.002)),
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
                                style: GoogleFonts.lato(
                                    color: AppColors.colorBlack,
                                    fontSize: averageSize * 0.0001,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: deviceWidth * 0.002)),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.03),
                            child: Text('${snapshot.data?.storeList?[index].storeProducts ?? '-'}',
                                style: GoogleFonts.lato(
                                    color: AppColors.colorBlack.withValues(alpha: 0.5),
                                    fontSize: averageSize * 0.00006,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: deviceWidth * 0.002)),
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
                                    style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.00006,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: deviceWidth * 0.002)),
                                SizedBox(
                                  width: averageSize * 0.000051,
                                ),
                                Text('|',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.00006,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: deviceWidth * 0.002)),
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
                                    style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.00006,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: deviceWidth * 0.002)),
                                Text(
                                    '${(snapshot.data?.storeList?[index].noOfRatings ?? '-') == 0 ? '-' : '(${snapshot.data?.storeList?[index].noOfRatings})'}',
                                    style: GoogleFonts.lato(
                                        color: AppColors.colorBlack,
                                        fontSize: averageSize * 0.00006,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: deviceWidth * 0.002)),
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
