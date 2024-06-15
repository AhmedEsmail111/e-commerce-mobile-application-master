import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../DetailScreen.dart';
import 'category_item.dart';

class CategoriesOrBrandsSection extends StatelessWidget {
  final List<CategoryOrBrandEntity> list;

  const CategoriesOrBrandsSection({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    print(
        'the list lemgth is ${list.length} and the first item is ${list.first.image}');
    return SizedBox(
      height: 200.h,
      child: GridView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the detail screen (e.g., BrandScreen or CategoryScreen)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(categoryOrBrandEntity: list[index]),
                ),
              );
            },
            child: CategoryOrBrandItem(categoryOrBrandEntity: list[index]),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
      ),
    );
  }
}
