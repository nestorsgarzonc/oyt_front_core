import 'package:oyt_front_core/constants/url_constants.dart';

class UrlBuilder {
  static String dinnerWithRestaurantId(String id) {
    return '${UrlConstants.dinnerUrl}/menu?restaurantId=$id';
  }

  static String dinnerWithTableId(String id) {
    return '${UrlConstants.dinnerUrl}/menu?tableId=$id';
  }
}
