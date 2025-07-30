import 'package:staging_fox_jek_clone_app/apiHelper/api_end_points.dart';
import 'package:staging_fox_jek_clone_app/apiHelper/api_helper.dart';
import 'package:staging_fox_jek_clone_app/apiHelper/api_parameters.dart';

class HomeRepo {
  /// Declare object of ApiHelper
  final _apiHelper = ApiHelper();

  /// this method used to get store List and slider data
  getStoreListAndSliderDetails() async {
    final storeList = await _apiHelper.post(ApiEndPoints.storeList, body: {
      ApiParameters.user_id: ApiParameters.user_id_value,
      ApiParameters.access_token: ApiParameters.access_token_value,
      ApiParameters.lat: ApiParameters.lat_value,
      ApiParameters.long: ApiParameters.long_value,
      ApiParameters.filter_type: ApiParameters.filter_type_value,
      ApiParameters.service_category_id: ApiParameters.service_category_id_value,
      ApiParameters.filter_key: ApiParameters.filter_key_value
    });

    return storeList;
  }

  /// this method used to get Category List Details
  getCategoryList() async {
    final categoryList = await _apiHelper.post(ApiEndPoints.categoryList, body: {
      ApiParameters.user_id: ApiParameters.user_id_value,
      ApiParameters.access_token: ApiParameters.access_token_value,
      ApiParameters.service_category_id: ApiParameters.service_category_id_value,
    });
    return categoryList;
  }

  getFeatureFoodDelivery() async {
    final foodDeliveryResponse = await _apiHelper.post(ApiEndPoints.foodDelivery, body: {
      ApiParameters.user_id: ApiParameters.user_id_value,
      ApiParameters.access_token: ApiParameters.access_token_value,
      ApiParameters.service_category_id: ApiParameters.service_category_id_value,
      ApiParameters.lat: ApiParameters.lat_value,
      ApiParameters.long: ApiParameters.long_value,
      ApiParameters.authorization: ApiParameters.authentication_value,
      ApiParameters.device_token: ApiParameters.device_token_value,
    });
    return foodDeliveryResponse;
  }

  /// this method used to get Favorite Details
  getFavoriteDetails() async {
    final foodDeliveryResponse = await _apiHelper.post(ApiEndPoints.favoriteList, body: {
      ApiParameters.user_id: ApiParameters.user_id_value,
      ApiParameters.access_token: ApiParameters.access_token_value,
      ApiParameters.service_category_id: ApiParameters.service_category_id_value,
      ApiParameters.lat: ApiParameters.lat_value,
      ApiParameters.long: ApiParameters.long_value,
      ApiParameters.authorization: ApiParameters.authentication_value,
      ApiParameters.device_token: ApiParameters.device_token_value,
      ApiParameters.view_all: ApiParameters.view_all_value,
    });
    return foodDeliveryResponse;
  }
}
