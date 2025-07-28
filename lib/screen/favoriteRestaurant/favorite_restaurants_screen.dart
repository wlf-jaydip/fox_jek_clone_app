import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_string.dart';
import '../../constants/size_constants.dart';
import '../homeScreen/home_screen_dl.dart';

class FavoriteRestaurantsScreen extends StatefulWidget {
  final FavoriteModal? favoriteModal;
  const FavoriteRestaurantsScreen({super.key, required this.favoriteModal});

  @override
  State<FavoriteRestaurantsScreen> createState() => _FavoriteRestaurantsScreenState();
}

class _FavoriteRestaurantsScreenState extends State<FavoriteRestaurantsScreen> {
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
        leadingWidth: averageSize * 0.00013,
        title: Text(
          AppString.favoriteRes,
          style: TextStyle(
            fontSize: averageSize * 0.00009,
            fontWeight: FontWeight.bold,
            letterSpacing: deviceWidth * 0.003,
            color: AppColors.colorBlack,
          ),
        ),
      ),
      body: _buildFavoriteRestaurant(),
    );
  }

  Widget _buildFavoriteRestaurant() {
    return SingleChildScrollView(
      child: ListView.builder(
          itemCount: widget.favoriteModal?.storeLists?.length ?? 0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.symmetric(vertical: averageSize * 0.00005),
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
                            colorFilter: (widget.favoriteModal?.storeLists?[index].storeStatus ?? '') == 0
                                ? ColorFilter.mode(
                                    Colors.grey.withValues(alpha: 0.9),
                                    BlendMode.hue,
                                  )
                                : ColorFilter.mode(
                                    Colors.transparent,
                                    BlendMode.color,
                                  ),
                            child: Image.network(
                              '${widget.favoriteModal?.storeLists?[index].storeBanner ?? ''}',
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
                      (widget.favoriteModal?.storeLists?[index].offerType) != 0
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
                                          '\$${widget.favoriteModal?.storeLists?[index].offerAmount ?? ''} % Off ',
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: averageSize * 0.00008,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.colorWhite),
                                        ),
                                        Text(
                                          'Order above \$${widget.favoriteModal?.storeLists?[index].offerMinAmount ?? ''}',
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
                    child: Text('${widget.favoriteModal?.storeLists?[index].storeName ?? '-'}',
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
                    child: Text('${widget.favoriteModal?.storeLists?[index].storeProducts ?? '-'}',
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
                            '${(widget.favoriteModal?.storeLists?[index].orderDeliveryTime ?? '-') == 0 ? '-' : '${widget.favoriteModal?.storeLists?[index].orderDeliveryTime} Min'} ',
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
                            '${(widget.favoriteModal?.storeLists?[index].averageRatings ?? '-') == 0 ? '-' : widget.favoriteModal?.storeLists?[index].averageRatings} ',
                            style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: deviceWidth * 0.03,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(
                            '${(widget.favoriteModal?.storeLists?[index].noOfRatings ?? '-') == 0 ? '-' : '(${widget.favoriteModal?.storeLists?[index].noOfRatings})'}',
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
    );
  }
}
