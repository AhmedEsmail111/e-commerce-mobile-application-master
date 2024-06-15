import 'package:ecommerce/domain/entities/ProductResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_assets.dart';
import '../home_tab/widgets/custom_search_with_shopping_cart.dart';
import '../product_list_tab/widgets/grid_view_card_item.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              MyAssets.logo,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: 18.h,
            ),
            const CustomSearchWithShoppingCart(),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.4,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemBuilder: (context, index) {
                  // final product = viewModel.productsList[index];
                  return InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   ProductDetailsView.routeName,
                      //   arguments: ProductEntity(),
                      // );
                    },
                    child: GridViewCardItem(
                      productEntity: ProductEntity(
                        id: '',
                        imageCover: '',
                        title: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
    ));
  }
}
