
import 'package:get/get.dart';
import 'package:online_store_fl_app/models/produc_model.dart';

import 'package:online_store_fl_app/services/e_shop_services.dart';

class EShopHomeController extends GetxController {
  var categories = <String>[].obs;
  var productsList = <ProductModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;
  // var selectedCategory = ''.obs;
  var selectedMinPrice = 0.0.obs;
  var selectedMaxPrice = 1000.0.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 0.0.obs;
  var selectedCategories = <String>[].obs;
  var cartItems = <ProductModel>[].obs;
   var quantity = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();
    fetchProducts();
  }


  

  void fetchCategories() async {
    try {
      isLoading.value = true;
      var fetchedCategories = await EShopServices().fetchCategories();
      categories.assignAll(fetchedCategories);
      categories.value = fetchedCategories;
     
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      var fetchedProducts = await EShopServices().fetchProducts();
      productsList.assignAll(fetchedProducts);
      productsList.value = fetchedProducts;
      updatePriceRange(productsList);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // List<ProductModel> get filteredProducts {
  //   if (searchQuery.value.isEmpty) {
  //     return productsList;
  //   } else {
  //     return productsList
  //         .where((product) =>
  //             product.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
  //             product.description.toLowerCase().contains(searchQuery.value.toLowerCase()))
  //         .toList();

  //   }
  // }
  void updatePriceRange(List<ProductModel> productList) {
    if (productList.isNotEmpty) {
      minPrice.value =
          productList.map((p) => p.price).reduce((a, b) => a < b ? a : b);
      maxPrice.value =
          productList.map((p) => p.price).reduce((a, b) => a > b ? a : b);
      selectedMinPrice.value = minPrice.value;
      selectedMaxPrice.value = maxPrice.value;
    }
  }

  List<ProductModel> get filteredProducts {
    var filteredList = productsList;

    if (searchQuery.value.isNotEmpty) {
      filteredList = filteredList
          .where((product) =>
              product.title
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList()
          .obs;
    }

    // if (selectedCategory.value.isNotEmpty) {
    //   filteredList = filteredList
    //       .where((product) => product.category == selectedCategory.value)
    //       .toList()
    //       .obs;
    // }

    filteredList = filteredList
        .where((product) =>
            product.price >= selectedMinPrice.value &&
            product.price <= selectedMaxPrice.value)
        .toList()
        .obs;

    if (selectedCategories.isNotEmpty) {
      filteredList = filteredList
          .where((product) => selectedCategories.contains(product.category))
          .toList()
          .obs;
    }

    return filteredList;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  // void setSelectedCategory(String category) {
  //   selectedCategory.value = category;
  // }

  void setPriceRange(double min, double max) {
    selectedMinPrice.value = min;
    selectedMaxPrice.value = max;
  }

  void toggleSelectedCategory(String category) {
    if (selectedCategories.contains(category)) {
      
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void increment() {
    quantity++;
    update();
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
    update();
  }
}
