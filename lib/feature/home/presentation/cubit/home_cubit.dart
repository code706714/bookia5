import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/product.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/feature/home/data/repo/home_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> products = [];
  List<SliderModel> sliders = [];

  getInitData() async {
    emit(HomeLoadingState());

    // run in parallel
    var results = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.getBestSeller(),
      // ...
    ]);

    // results [SliderResponse? , BestSellerResponse?]

    var sliderRes = results[0] as SliderResponse?;
    var bestSellerRes = results[1] as BestSellerResponse?;

    // check 3la el response 3l4an nrg3 state l el screen

    if (sliderRes != null || bestSellerRes != null) {
      products = bestSellerRes?.data?.products ?? [];
      sliders = sliderRes?.data?.sliders ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }

  addRemoveWishlist({required int productId}) async {
    emit(HomeLoadingState());
    if (checkIfWishlist(productId)) {
      var res = await WishlistRepo.removeToWishlist(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: 'Removed from wishlist'));
      } else {
        emit(HomeErrorState());
      }
    } else {
      var res = await WishlistRepo.addToWishlist(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: 'Added to wishlist'));
      } else {
        emit(HomeErrorState());
      }
    }
  }

  addToCart({required int productId}) async {
    emit(HomeLoadingState());

    var res = await CartRepo.addToCart(productId: productId);
    if (res != null) {
      emit(HomeSuccessState(message: 'Added to cart'));
    } else {
      emit(HomeErrorState());
    }
  }

  bool checkIfWishlist(int productId) {
    var cachedWishlist = SharedPref.getWishlist();

    return cachedWishlist?.contains(productId) ?? false;
  }
}
