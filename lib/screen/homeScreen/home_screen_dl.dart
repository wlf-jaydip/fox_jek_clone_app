class StoreListSliderModal {
  String? displayTitleName;
  int? noOfStore;
  List<StoreList>? storeList;
  List<ServiceSliderData>? serviceSliderData;

  StoreListSliderModal({this.displayTitleName, this.noOfStore, this.storeList, this.serviceSliderData});

  StoreListSliderModal.fromJson(Map<String, dynamic> json) {
    displayTitleName = json['display_title_name'];
    noOfStore = json['no_of_store'];
    if (json['store_list'] != null) {
      storeList = <StoreList>[];
      json['store_list'].forEach((v) {
        storeList!.add(new StoreList.fromJson(v));
      });
    }
    if (json['service_slider_data'] != null) {
      serviceSliderData = <ServiceSliderData>[];
      json['service_slider_data'].forEach((v) {
        serviceSliderData!.add(new ServiceSliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_title_name'] = this.displayTitleName;
    data['no_of_store'] = this.noOfStore;
    if (this.storeList != null) {
      data['store_list'] = this.storeList!.map((v) => v.toJson()).toList();
    }
    if (this.serviceSliderData != null) {
      data['service_slider_data'] = this.serviceSliderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreList {
  int? storeId;
  String? storeName;
  String? storeBanner;
  String? storeProducts;
  dynamic averageRatings;
  dynamic offer;
  int? orderDeliveryTime;
  dynamic orderMinAmount;
  dynamic storeStatus;
  dynamic offerType;
  dynamic offerMinAmount;
  dynamic offerAmount;
  dynamic noOfRatings;
  dynamic distance;
  dynamic isFavStore;
  dynamic isSubcatFlow;

  StoreList(
      {this.storeId,
      this.storeName,
      this.storeBanner,
      this.storeProducts,
      this.averageRatings,
      this.offer,
      this.orderDeliveryTime,
      this.orderMinAmount,
      this.storeStatus,
      this.offerType,
      this.offerMinAmount,
      this.offerAmount,
      this.noOfRatings,
      this.distance,
      this.isFavStore,
      this.isSubcatFlow});

  StoreList.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeBanner = json['store_banner'];
    storeProducts = json['store_products'];
    averageRatings = json['average_ratings'];
    offer = json['offer'];
    orderDeliveryTime = json['order_delivery_time'];
    orderMinAmount = json['order_min_amount'];
    storeStatus = json['store_status'];
    offerType = json['offer_type'];
    offerMinAmount = json['offer_min_amount'];
    offerAmount = json['offer_amount'];
    noOfRatings = json['no_of_ratings'];
    distance = json['distance'];
    isFavStore = json['is_fav_store'];
    isSubcatFlow = json['is_subcat_flow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_banner'] = this.storeBanner;
    data['store_products'] = this.storeProducts;
    data['average_ratings'] = this.averageRatings;
    data['offer'] = this.offer;
    data['order_delivery_time'] = this.orderDeliveryTime;
    data['order_min_amount'] = this.orderMinAmount;
    data['store_status'] = this.storeStatus;
    data['offer_type'] = this.offerType;
    data['offer_min_amount'] = this.offerMinAmount;
    data['offer_amount'] = this.offerAmount;
    data['no_of_ratings'] = this.noOfRatings;
    data['distance'] = this.distance;
    data['is_fav_store'] = this.isFavStore;
    data['is_subcat_flow'] = this.isSubcatFlow;
    return data;
  }
}

class ServiceSliderData {
  int? id;
  int? storeId;
  int? serviceCategoryId;
  String? storeName;
  String? bannerImage;

  ServiceSliderData({this.id, this.storeId, this.serviceCategoryId, this.storeName, this.bannerImage});

  ServiceSliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    serviceCategoryId = json['service_category_id'];
    storeName = json['store_name'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['service_category_id'] = this.serviceCategoryId;
    data['store_name'] = this.storeName;
    data['banner_image'] = this.bannerImage;
    return data;
  }
}

class CategoryList {
  int? status;
  String? message;
  int? messageCode;
  List<ProductCategoryList>? productCategoryList;

  CategoryList({this.status, this.message, this.messageCode, this.productCategoryList});

  CategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    messageCode = json['message_code'];
    if (json['product_category_list'] != null) {
      productCategoryList = <ProductCategoryList>[];
      json['product_category_list'].forEach((v) {
        productCategoryList!.add(new ProductCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['message_code'] = this.messageCode;
    if (this.productCategoryList != null) {
      data['product_category_list'] = this.productCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategoryList {
  int? productCategoryId;
  String? productCategoryName;
  String? categoryIcon;

  ProductCategoryList({this.productCategoryId, this.productCategoryName, this.categoryIcon});

  ProductCategoryList.fromJson(Map<String, dynamic> json) {
    productCategoryId = json['product_category_id'];
    productCategoryName = json['product_category_name'];
    categoryIcon = json['category_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_category_id'] = this.productCategoryId;
    data['product_category_name'] = this.productCategoryName;
    data['category_icon'] = this.categoryIcon;
    return data;
  }
}

class FoodDelivery {
  List<AllFeatureStore>? allFeatureStore;
  int? status;
  String? message;
  int? messageCode;

  FoodDelivery({this.allFeatureStore, this.status, this.message, this.messageCode});

  FoodDelivery.fromJson(Map<String, dynamic> json) {
    if (json['all_feature_store'] != null) {
      allFeatureStore = <AllFeatureStore>[];
      json['all_feature_store'].forEach((v) {
        allFeatureStore!.add(new AllFeatureStore.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    messageCode = json['message_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allFeatureStore != null) {
      data['all_feature_store'] = this.allFeatureStore!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['message_code'] = this.messageCode;
    return data;
  }
}

class AllFeatureStore {
  int? serviceCategoryId;
  String? serviceCategoryName;
  String? serviceCategoryIcon;
  String? displayTitleName;
  List<StoreLists>? storeLists;
  int? viewAllBtn;

  AllFeatureStore(
      {this.serviceCategoryId,
      this.serviceCategoryName,
      this.serviceCategoryIcon,
      this.displayTitleName,
      this.storeLists,
      this.viewAllBtn});

  AllFeatureStore.fromJson(Map<String, dynamic> json) {
    serviceCategoryId = json['service_category_id'];
    serviceCategoryName = json['service_category_name'];
    serviceCategoryIcon = json['service_category_icon'];
    displayTitleName = json['display_title_name'];
    if (json['store_lists'] != null) {
      storeLists = <StoreLists>[];
      json['store_lists'].forEach((v) {
        storeLists!.add(new StoreLists.fromJson(v));
      });
    }
    viewAllBtn = json['view_all_btn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_category_id'] = this.serviceCategoryId;
    data['service_category_name'] = this.serviceCategoryName;
    data['service_category_icon'] = this.serviceCategoryIcon;
    data['display_title_name'] = this.displayTitleName;
    if (this.storeLists != null) {
      data['store_lists'] = this.storeLists!.map((v) => v.toJson()).toList();
    }
    data['view_all_btn'] = this.viewAllBtn;
    return data;
  }
}

class StoreLists {
  int? id;
  int? storeId;
  int? serviceCategoryId;
  String? storeName;
  String? storeProducts;
  dynamic averageRatings;
  dynamic etaDeliveryTime;
  String? storeImage;
  double? distance;
  int? serviceRadius;
  String? offer;
  dynamic offerType;
  dynamic offerMinAmount;
  dynamic offerAmount;
  dynamic noOfRatings;
  dynamic storeStatus;

  StoreLists(
      {this.id,
      this.storeId,
      this.serviceCategoryId,
      this.storeName,
      this.storeProducts,
      this.averageRatings,
      this.etaDeliveryTime,
      this.storeImage,
      this.distance,
      this.serviceRadius,
      this.offer,
      this.offerType,
      this.offerMinAmount,
      this.offerAmount,
      this.noOfRatings,
      this.storeStatus});

  StoreLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    serviceCategoryId = json['service_category_id'];
    storeName = json['store_name'];
    storeProducts = json['store_products'];
    averageRatings = json['average_ratings'];
    etaDeliveryTime = json['eta_delivery_time'];
    storeImage = json['store_image'];
    distance = json['distance'];
    serviceRadius = json['service_radius'];
    offer = json['offer'];
    offerType = json['offer_type'];
    offerMinAmount = json['offer_min_amount'];
    offerAmount = json['offer_amount'];
    noOfRatings = json['no_of_ratings'];
    storeStatus = json['store_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['service_category_id'] = this.serviceCategoryId;
    data['store_name'] = this.storeName;
    data['store_products'] = this.storeProducts;
    data['average_ratings'] = this.averageRatings;
    data['eta_delivery_time'] = this.etaDeliveryTime;
    data['store_image'] = this.storeImage;
    data['distance'] = this.distance;
    data['service_radius'] = this.serviceRadius;
    data['offer'] = this.offer;
    data['offer_type'] = this.offerType;
    data['offer_min_amount'] = this.offerMinAmount;
    data['offer_amount'] = this.offerAmount;
    data['no_of_ratings'] = this.noOfRatings;
    data['store_status'] = this.storeStatus;
    return data;
  }
}
