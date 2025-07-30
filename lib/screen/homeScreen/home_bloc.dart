import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:staging_fox_jek_clone_app/constants/app_string.dart';
import 'package:staging_fox_jek_clone_app/screen/homeScreen/home_screen_repo.dart';

import 'home_screen_dl.dart';

class HomeBloc {
  /// Declare Variable
  final searchController = TextEditingController();
  final storeListSubject = BehaviorSubject<StoreListSliderModal>();
  final categoryList = BehaviorSubject<CategoryList>();
  final foodDelivery = BehaviorSubject<FoodDelivery>();
  final favoriteList = BehaviorSubject<FavoriteModal>();
  final pageIndex = BehaviorSubject<int>.seeded(0);
  final selectedValue = BehaviorSubject<String>.seeded(AppString.priceHtL);
  final _homeRepo = HomeRepo();
  List<int> favIndex = [];

  /// this is default sorting list
  List<String> sortingList = [
    AppString.sort,
    AppString.openNow,
    AppString.offers,
    AppString.orderDetails,
    AppString.orderTake,
  ];

  /// this constructor used to get all details
  HomeBloc() {
    getStoreListAndSliderData();
    getCategoryListDetails();
    getFoodDeliveryDetails();
    getFavoriteDetails();
  }

  /// this method used to get store List and slider data
  getStoreListAndSliderData() async {
    StoreListSliderModal storeListData = await StoreListSliderModal.fromJson(await _homeRepo.getStoreListAndSliderDetails());
    storeListSubject.sink.add(storeListData);
  }

  /// this method used to get Category List Details
  getCategoryListDetails() async {
    CategoryList categoryListData = await CategoryList.fromJson(await _homeRepo.getCategoryList());
    categoryList.sink.add(categoryListData);
  }

  /// this method used to get Food Delivery Details

  getFoodDeliveryDetails() async {
    FoodDelivery foodDeliveryData = await FoodDelivery.fromJson(await _homeRepo.getFeatureFoodDelivery());
    foodDelivery.sink.add(foodDeliveryData);
  }

  /// this method used to get Favorite Details
  getFavoriteDetails() async {
    FavoriteModal favoriteModalData = await FavoriteModal.fromJson(await _homeRepo.getFavoriteDetails());
    favoriteList.sink.add(favoriteModalData);
  }

  /// this method used to set Page Index
  setPageIndex(index) {
    pageIndex.sink.add(index);
  }

  /// this method used to select Sorting Values
  selectSortingValues(String index) {
    selectedValue.sink.add(index);
  }
}
