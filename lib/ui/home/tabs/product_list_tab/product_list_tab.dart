import 'package:ecommerce/core/utils/my_assets.dart';
import 'package:ecommerce/core/utils/my_colors.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_states.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/custom_text_field.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/widgets/grid_view_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cart/cart_screen.dart';
import '../../product_details/product_details_view.dart';

class ProductListTab extends StatelessWidget {
  const ProductListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListTabViewModel, ProductListTabStates>(
      bloc: ProductListTabViewModel.get(context)..getProducts(),
      listener: (BuildContext context, ProductListTabStates state) {},
      builder: (context, state) {
        final viewModel = ProductListTabViewModel.get(context);
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Image.asset(
                  MyAssets.logo,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    const Expanded(
                      child: CustomTextField(),
                    ),
                    SizedBox(width: 24.w),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      child: Badge(
                        label: BlocBuilder<CartViewModel, CartStates>(
                            builder: (context, state) {
                          return Text(CartViewModel.get(context)
                              .cartItems
                              .length
                              .toString());
                        }),
                        child: ImageIcon(
                          const AssetImage(MyAssets.shoppingCart),
                          size: 28.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                state is ProductListTabLoadingStates
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount: viewModel.productsList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2.4,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemBuilder: (context, index) {
                            final product = viewModel.productsList[index];
                            return InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ProductDetailsView.routeName,
                                  arguments: product,
                                );
                              },
                              child: GridViewCardItem(productEntity: product),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
