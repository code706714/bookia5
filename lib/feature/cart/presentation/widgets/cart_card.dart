import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onRefresh,
    required this.onUpdate,
  });

  final CartItem book;
  final Function() onDelete;
  final Function() onRefresh;
  final Function(int) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.delete, color: AppColors.whiteColor),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: GestureDetector(
        onTap: () {
          // pushTo(context, Routes.details, extra: book.mapToProduct()).then((
          //   value,
          // ) {
          //   onRefresh();
          // });
        },
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Hero(
                tag: book.itemProductId ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: book.itemProductImage ?? '',
                    height: 120,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      book.itemProductName ?? '',
                      style: TextStyles.styleSize18(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(10),
                    Text(
                      '\$${book.itemProductPriceAfterDiscount}',
                      style: TextStyles.styleSize16(),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) > 1) {
                              int newQuantity = (book.itemQuantity ?? 1) - 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, 'Minimum quantity is 1');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Gap(10),
                        Text(book.itemQuantity.toString()),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) <
                                (book.itemProductStock ?? 1)) {
                              int newQuantity = (book.itemQuantity ?? 1) + 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, 'Out of stock');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
