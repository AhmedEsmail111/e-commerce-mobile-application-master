import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_states.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/my_assets.dart';
import '../../../../../core/utils/my_colors.dart';
import '../../../../../domain/entities/ProductResponseEntity.dart';

class GridViewCardItem extends StatelessWidget {
  bool isWishlisted = false;
  ProductEntity productEntity;
  GridViewCardItem({super.key, required this.productEntity});
  @override
  Widget build(BuildContext context) {
    print(productEntity.id);
    return Container(
      width: 191.w,
      height: 237.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  productEntity.imageCover != null
                      ? productEntity.imageCover ?? ''
                      : productEntity.images?.first ?? "",
                  fit: BoxFit.cover,
                  width: 191.w,
                  height: 128.h,
                ),
              ),
              Positioned(
                top: 5.h,
                right: 2.w,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: IconButton(
                    color: AppColors.primaryColor,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ApiManager.getInstance()
                          .handleWishListAddandRemove(productEntity.id!);
                    },
                    icon: isWishlisted == true
                        ? const Icon(Icons.favorite_rounded)
                        : const Icon(
                            Icons.favorite_border_rounded,
                          ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              productEntity.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.darkPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: [
                Text(
                  productEntity.price != null
                      ? "EGP ${productEntity.price}"
                      : "EGP 134",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
            child: Row(
              children: [
                Text(
                  productEntity.ratingsAverage != null
                      ? "Review (${productEntity.ratingsAverage})"
                      : "Review (3)",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Image.asset(
                  MyAssets.starIcon,
                ),
                const Spacer(
                  flex: 1,
                ),
                BlocBuilder<CartViewModel, CartStates>(
                    builder: (context, state) {
                  final viewModel = CartViewModel.get(context);
                  return InkWell(
                    onTap: state is AddToCartLoadingStates ||
                            state is GetCartLoadingStates
                        ? null
                        : () {
                            if (!viewModel.isInCart(productEntity.id!)) {
                              CartViewModel.get(context)
                                  .addToCart(productEntity.id ?? "");
                            }
                          },
                    splashColor: Colors.transparent,
                    child: Icon(
                      viewModel.isInCart(productEntity.id!)
                          ? Icons.done
                          : Icons.add_circle,
                      size: 32.sp,
                      color: AppColors.primaryColor,
                    ),
                  );
                })
              ],
            ),
          )
          // GridViewCardItemBody(
          //   productEntity: productEntity,
          // )
        ],
      ),
    );
  }
}
