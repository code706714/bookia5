import 'package:bookia/feature/wishlist/data/models/wishlist_response/datum.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  List<WishlistProduct> books = [
    WishlistProduct(),
    WishlistProduct(),
    WishlistProduct(),
    WishlistProduct(),
  ];

  getWishlist() async {
    emit(WishlistLoadingState());
    var res = await WishlistRepo.getWishlist();

    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }

  removeFromWishlist({required int productId}) async {
    emit(WishlistLoadingState());
    var res = await WishlistRepo.removeToWishlist(productId: productId);

    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }
}
