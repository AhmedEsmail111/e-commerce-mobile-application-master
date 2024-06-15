import 'package:ecommerce/core/utils/my_assets.dart';
import 'package:ecommerce/core/utils/my_colors.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cart/cart_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String selectedCategory = '';

  final Map<String, List<Map<String, String>>> categories = {
    'Men\'s Fashion': [
      {'name': 'T-shirts', 'image': 'assets/images/Frame 47.png'},
      {'name': 'Shorts', 'image': 'assets/images/shorts.png'},
      {'name': 'Pants', 'image': 'assets/images/pants.png'},
      {'name': 'Footwear', 'image': 'assets/images/footwear.png'},
      {'name': 'Suits', 'image': 'assets/images/suits.png'},
      {'name': 'Watches', 'image': 'assets/images/watches.png'},
      {'name': 'Bags', 'image': 'assets/images/bags.png'},
      {'name': 'Eyewears', 'image': 'assets/images/eyewears.png'}
    ],
    'Women\'s Fashion': [
      {'name': 'Dresses', 'image': 'assets/images/dresses.png'},
      {'name': 'Jeans', 'image': 'assets/images/womens_jeans.png'},
      {'name': 'Skirts', 'image': 'assets/images/skirts.png'},
      {'name': 'Pajamas', 'image': 'assets/images/pajamas.png'},
      {'name': 'Bags', 'image': 'assets/images/womens_bags.png'},
      {'name': 'T-shirts', 'image': 'assets/images/womens_tshirts.png'},
      {'name': 'Footwear', 'image': 'assets/images/womens_footwear.png'},
      {'name': 'Watches', 'image': 'assets/images/womens_watches.png'},
    ],
    'Skincare': [
      {'name': 'Moisturizer', 'image': 'assets/images/dresses.png'},
      {'name': 'Cleanser', 'image': 'assets/images/womens_jeans.png'},
      {'name': 'Sheet mask', 'image': 'assets/images/skirts.png'},
      {'name': 'Sunblock', 'image': 'assets/images/pajamas.png'},
      {'name': 'Face Oil', 'image': 'assets/images/womens_bags.png'},
    ],
    'Beauty': [
      {'name': 'Foundation', 'image': 'assets/images/dresses.png'},
      {'name': 'Concealer', 'image': 'assets/images/womens_jeans.png'},
      {'name': 'Primer', 'image': 'assets/images/skirts.png'},
      {'name': 'Lip gloss', 'image': 'assets/images/pajamas.png'},
      {'name': 'Blusher', 'image': 'assets/images/womens_bags.png'},
    ],
    'Cameras': [
      {'name': 'DSLR', 'image': 'assets/images/dresses.png'},
      {'name': 'mirrorless', 'image': 'assets/images/womens_jeans.png'},
    ],
    'Mobile': [
      {'name': 'IOS', 'image': 'assets/images/dresses.png'},
      {'name': 'Android', 'image': 'assets/images/womens_jeans.png'},
    ],
    'Laptop': [
      {'name': 'Gaming Laptops', 'image': 'assets/images/dresses.png'},
      {'name': 'Business Laptops', 'image': 'assets/images/womens_jeans.png'},
    ],
    'Baby & Toys': [
      {'name': 'Scooter', 'image': 'assets/images/womens_jeans.png'},
    ],
  };

  final Map<String, String> categoryImages = {
    'Men\'s Fashion': 'assets/images/Frame 32.png',
    'Women\'s Fashion': 'assets/images/Frame 31.png',
    'Skincare': 'assets/images/skincare.png',
    'Beauty': 'assets/images/beauty.png',
    'Cameras': 'assets/images/camera cover.png',
    'Mobile': 'assets/images/mobile.png',
    'Laptop': 'assets/images/laptop cover.png',
    'Baby & Toys': 'assets/images/toys 1.png',
  };

  TextEditingController _textFieldController =
      TextEditingController(); // Add text field controller

  @override
  void dispose() {
    _textFieldController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      MyAssets.logo,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                        height: 10), // Add spacing between image and text field
                    Row(
                      children: [
                        Expanded(
                          child:
                              CustomTextField(), // Assuming this is your custom text field widget
                        ),
                        SizedBox(width: 24.w),
                        // Placeholder for viewModel
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          child: ImageIcon(
                            AssetImage(MyAssets.shoppingCart),
                            size: 28.sp,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 150, // Width of the side menu
                      color: Color.fromARGB(128, 219, 228, 237),
                      child: ListView(
                        children: categories.keys.map((category) {
                          return Container(
                            color: selectedCategory == category
                                ? Colors.white
                                : Color.fromARGB(128, 219, 228, 237),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // Space between title and subtitle
                                children: [
                                  Text(
                                    category,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(6, 0, 79, 1),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          27), // Add spacing between title and subtitle
                                  Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: selectedCategory.isEmpty
                        ? Center(child: Text('Select a category'))
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 16.0, 16.0, 8.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      selectedCategory,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromRGBO(6, 0, 79, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                child: Image.asset(
                                  categoryImages[selectedCategory]!,
                                  width: 500,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                // Added Expanded widget
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 4,
                                  ),
                                  itemCount:
                                      categories[selectedCategory]!.length,
                                  itemBuilder: (context, index) {
                                    final subcategory =
                                        categories[selectedCategory]![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SubcategoryPage(
                                              category: selectedCategory,
                                              subcategory: subcategory['name']!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  12.0, 8.0, 12.0, 1.0),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.asset(
                                                  subcategory['image']!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                subcategory['name']!,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubcategoryPage extends StatelessWidget {
  final String category;
  final String subcategory;

  SubcategoryPage({required this.category, required this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category - $subcategory'),
      ),
      body: Center(
        child: Text(
          'Welcome to $subcategory in $category',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
