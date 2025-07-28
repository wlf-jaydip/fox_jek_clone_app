import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:staging_fox_jek_clone_app/screen/homeScreen/home_screen_repo.dart';

import 'home_screen_dl.dart';

class HomeBloc {
  final searchController = TextEditingController();
  final storeListSubject = BehaviorSubject<StoreListSliderModal>();
  final categoryList = BehaviorSubject<CategoryList>();
  final foodDelivery = BehaviorSubject<FoodDelivery>();
  final pageIndex = BehaviorSubject<int>.seeded(0);
  final _homeRepo = HomeRepo();
  List<int> favIndex = [];

  HomeBloc() {
    getStoreListAndSliderData();
    getCategoryListDetails();
    getFoodDeliveryDetails();
  }

  getStoreListAndSliderData() async {
    StoreListSliderModal storeListData = await StoreListSliderModal.fromJson(await _homeRepo.getStoreListAndSliderDetails());
    storeListSubject.sink.add(storeListData);
  }

  getCategoryListDetails() async {
    CategoryList categoryListData = await CategoryList.fromJson(await _homeRepo.getCategoryList());
    categoryList.sink.add(categoryListData);
  }

  getFoodDeliveryDetails() async {
    FoodDelivery foodDeliveryData = await FoodDelivery.fromJson(await _homeRepo.getFeatureFoodDelivery());
    foodDelivery.sink.add(foodDeliveryData);
  }

  setPageIndex(index) {
    pageIndex.sink.add(index);
  }
}
