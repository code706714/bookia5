import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtion.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            var books = cubit.cartResponse?.data?.cartItems ?? [];
            if (state is! CartSuccessState) {
              return const Center(child: CircularProgressIndicator());
            }
            // after success state
            if (books.isEmpty) {
              return _emptyUI();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: books.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CartCard(
                        book: books[index],
                        onDelete: () {
                          cubit.removeFromCart(
                            cartItemId: books[index].itemId ?? 0,
                          );
                        },
                        onUpdate: (q) {
                          cubit.updateCart(
                            cartItemId: books[index].itemId ?? 0,
                            quantity: q,
                          );
                        },
                        onRefresh: () {
                          cubit.getCart();
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price', style: TextStyles.styleSize18()),
                          Text(
                            '${(cubit.cartResponse?.data?.total ?? 0)} \$',
                            style: TextStyles.styleSize18(),
                          ),
                        ],
                      ),
                      Gap(20),
                      MainButton(
                        text: 'Checkout',
                        onPressed: () {
                          pushTo(
                            context,
                            Routes.placeOrder,
                            extra:
                                cubit.cartResponse?.data?.total.toString() ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Center _emptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.cartSvg,
            height: 100,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(20),
          Text('No books in wishlist'),
        ],
      ),
    );
  }
}
