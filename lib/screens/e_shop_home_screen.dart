import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:online_store_fl_app/controller/auth_controller.dart';
import 'package:online_store_fl_app/controller/e_shop_home_controller.dart';
import 'package:online_store_fl_app/models/produc_model.dart';
import 'package:online_store_fl_app/screens/e_shop_info_screen.dart';


class EshopHomePage extends StatelessWidget {
  final EShopHomeController controller = Get.put(EShopHomeController());
  final AuthController logincontroller = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('E-Shop'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Get.to(() => EshopHomePage());
                logincontroller.signOut();
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${controller.errorMessage}'));
          } else if (controller.filteredProducts.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => controller.setSearchQuery(value),
                    decoration: InputDecoration(
                      hintText: 'Search for products',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Obx(() {
                //     return DropdownButton<String>(
                //       value: controller.selectedCategory.value.isEmpty
                //           ? null
                //           : controller.selectedCategory.value,
                //       hint: Text('Select Category'),
                //       items: controller.categories
                //           .map((category) => DropdownMenuItem<String>(
                //                 value: category,
                //                 child: Text(category),
                //               ))
                //           .toList(),
                //       onChanged: (value) =>
                //           controller.setSelectedCategory(value!),
                //     );
                //   }),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Column(
                      children: [
                        Text('Price Range'),
                        RangeSlider(
                          values: RangeValues(
                            controller.selectedMinPrice.value,
                            controller.selectedMaxPrice.value,
                          ),
                          min: controller.minPrice.value,
                          max: controller.maxPrice.value,
                          divisions: 100,
                          labels: RangeLabels(
                            controller.selectedMinPrice.value.toString(),
                            controller.selectedMaxPrice.value.toString(),
                          ),
                          onChanged: (RangeValues values) {
                            controller.setPriceRange(values.start, values.end);
                          },
                        ),
                      ],
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: controller.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChipWidget(
                              label: category,
                              selected: controller.selectedCategories
                                  .contains(category),
                              onSelected: (value) {
                                print(
                                    "ajgdsjahsfjhgdhgsgvfhgsghfdsghfghfhgfdghj $value");
                                controller.toggleSelectedCategory(category);
                              }),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Obx(() {
                //     return Wrap(
                //       spacing: 8.0,
                //       children: controller.categories
                //           .map((category) => FilterChipWidget(
                //                 label: category,
                //                 selected: controller.selectedCategories
                //                     .contains(category),
                //                 onSelected: (bool selected) {
                //                   print("selected category==> $selected");
                //                   print(
                //                       "controller.selectedCategories.contains(category)=> ${controller.selectedCategories.contains(category)}");
                //                   controller.toggleSelectedCategory(category);
                //                 },
                //               ))
                //           .toList(),
                //     );
                //   }),
                // ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => EShopInfoScreen(
                                productList: controller.filteredProducts[index],
                              ));
                        },
                        child: ProductCard(
                            product: controller.filteredProducts[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }));
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final void Function(bool) onSelected;
  final bool selected;

  FilterChipWidget(
      {required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: const Color.fromARGB(255, 16, 155, 225),
      label: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      selected: selected,
      onSelected: (bool value) {},
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
  
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16),
                SizedBox(width: 4),
                Text('${product.rating.rate} (${product.rating.count})'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\Rs. ${product.price}',
                style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
