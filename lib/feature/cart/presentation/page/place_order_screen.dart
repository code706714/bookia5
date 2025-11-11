import 'package:bookia/components/app_bar/app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/naviagtion.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/cart/data/models/gov_list.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBarWithBack(),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoadingState) {
            showLoadingDialog(context);
          } else if (state is CartSuccessState) {
            pop(context);
            goToBase(context, Routes.main, extra: 0);
          } else if (state is CartErrorState) {
            pop(context);
            showMyDialog(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.styleSize30()),
                  Gap(10),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                    style: TextStyles.styleSize16(color: AppColors.greyColor),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: cubit.fullNameController,
                    hint: 'Full Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.addressController,
                    hint: 'Address',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.phoneController,
                    hint: 'Phone',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.govController,
                    hint: 'Governorate',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      selectGovernorate(context, cubit);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your governorate';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price', style: TextStyles.styleSize18()),
                Text('$total \$', style: TextStyles.styleSize18()),
              ],
            ),
            Gap(20),
            MainButton(
              text: 'Place Order',
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.placeOrder();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> selectGovernorate(BuildContext context, CartCubit cubit) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Governorate', style: TextStyles.styleSize20()),
              Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: governorateList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text(
                        governorateList[index].governorateNameEn ?? '',
                      ),

                      trailing: cubit.selectedGovId == governorateList[index].id
                          ? Icon(Icons.check)
                          : null,
                      onTap: () {
                        pop(context);
                        cubit.govController.text =
                            governorateList[index].governorateNameEn ?? '';
                        cubit.selectedGovId = governorateList[index].id ?? 0;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
