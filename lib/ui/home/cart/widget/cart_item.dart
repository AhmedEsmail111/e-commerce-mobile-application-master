import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_colors.dart';
import '../../tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import '../cubit/cart_view_model.dart';

class CartItem extends StatelessWidget {
  final CartItemData cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListTabViewModel, ProductListTabStates>(
      listener: (conntext, state) {},
      builder: (conntext, state) {
        final product = ProductListTabViewModel.get(context)
            .getProductById(cartItem.product);

        return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border:
                    Border.all(width: 1.w, color: AppColors.lightGreyColor)),
            width: 398.w,
            height: 145.h,
            child: Row(children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 145.h,
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Image.network(
                    product.imageCover != null
                        ? product.imageCover ?? ''
                        : product.images?.first ?? '',
                    fit: BoxFit.fill),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                // cartItem.product?.title ??
                                "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () {
                                //logic here
                                CartViewModel.get(context)
                                    .deleteItemInCart(cartItem.id ?? "");
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                        child: Row(
                          children: [
                            Text('Count: ${cartItem.quantity}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.blueGreyColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('EGP ${cartItem.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold)),
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    100.r,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        var counter = cartItem.quantity ?? 0;
                                        counter--;
                                        CartViewModel.get(context)
                                            .updateCountInCart(
                                                cartItem.id ?? '', counter);
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline_rounded,
                                        color: AppColors.whiteColor,
                                        size: 28.sp,
                                      ),
                                    ),
                                    Text(
                                      cartItem.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        var counter = cartItem.quantity ?? 0;
                                        counter++;
                                        CartViewModel.get(context)
                                            .updateCountInCart(
                                                cartItem.id ?? '', counter);
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: AppColors.whiteColor,
                                        size: 28.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              )),
            ]),
          ),
        );
      },
    );
  }
}
