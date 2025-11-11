import 'dart:developer';

import 'package:bookia/core/services/dio/api_endpoints.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/data/models/place_order_params.dart';

class CartRepo {
  static Future<CartResponse?> getCart() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);

        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.addToCart,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);

        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeToCart({required int cartItemId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);

        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);

        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> placeOrder(PlaceOrderParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.placeOrder,
        data: params.toJson(),
        headers: {"Authorization": "Bearer ${SharedPref.getUserData()?.token}"},
      );

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  // static saveCartToLocal(List<CartProduct> wishlistIds) {
  //   if (wishlistIds.isEmpty) {
  //     SharedPref.saveCart([]);
  //   } else {
  //     List<int> bookIds = [];

  //     for (var id in wishlistIds) {
  //       bookIds.add(id.id ?? 0);
  //     }
  //     SharedPref.saveCart(bookIds);
  //   }
  // }
}
