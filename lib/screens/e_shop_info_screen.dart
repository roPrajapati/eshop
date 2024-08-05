import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_store_fl_app/controller/e_shop_home_controller.dart';
import 'package:online_store_fl_app/models/produc_model.dart';
import 'package:online_store_fl_app/screens/e_shop_check_out_screen.dart';
import 'package:online_store_fl_app/screens/login_screen.dart';

class EShopInfoScreen extends StatelessWidget {
  EShopInfoScreen({
    super.key,
    required this.productList,
  });
  final ProductModel productList;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<EShopHomeController>(
        init: EShopHomeController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  productList.image,
                  height: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productList.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          productList.category,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 10),
                        Text(productList.rating.rate.toString(),
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      maxLines: 5,
                      productList.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorOption(Colors.brown),
                        ColorOption(Colors.pink),
                        ColorOption(Colors.green),
                        ColorOption(Colors.brown.shade900),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            controller.decrement();
                          },
                        ),
                        Text(
                          controller.quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            controller.increment();
                          },
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs.${productList.price.toString()}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  final Box box = Hive.box('StoargeToken');
                  print("User signed in: ${box.get('userToken')}");
                  if (box.get('userToken') == null) {
                    Get.to(() => LoginScreen());
                  } else {
                    Get.to(() => EShopCheckOutScreen());
                  }
                },
                child: Container(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;

  ColorOption(this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
      ),
    );
  }
}
