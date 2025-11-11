import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/data/models/place_order_params.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final govController = TextEditingController();

  int selectedGovId = -1;

  CartResponse? cartResponse;

  getCart() async {
    emit(CartLoadingState());
    var res = await CartRepo.getCart();

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  removeFromCart({required int cartItemId}) async {
    emit(CartLoadingState());
    var res = await CartRepo.removeToCart(cartItemId: cartItemId);

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  updateCart({required int cartItemId, required int quantity}) async {
    var res = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  placeOrder() async {
    emit(CartLoadingState());
    var params = PlaceOrderParams(
      governorateId: selectedGovId,
      name: fullNameController.text,
      phone: phoneController.text,
      address: addressController.text,
      email: emailController.text,
    );

    var res = await CartRepo.placeOrder(params);

    if (res) {
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  prefillOrderData() {
    var user = SharedPref.getUserData();
    fullNameController.text = user?.user?.name ?? '';
    addressController.text = user?.user?.address ?? '';
    phoneController.text = user?.user?.phone ?? '';
    emailController.text = user?.user?.email ?? '';
  }
}
