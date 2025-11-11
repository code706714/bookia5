import 'dart:developer';

import 'package:bookia/core/services/dio/api_endpoints.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider_response.dart';

class HomeRepo {
  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.productsBestSeller,
      );

      if (res.statusCode == 200) {
        return BestSellerResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<SliderResponse?> getSliders() async {
    try {
      var res = await DioProvider.get(endpoint: ApiEndpoints.sliders);

      if (res.statusCode == 200) {
        return SliderResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
