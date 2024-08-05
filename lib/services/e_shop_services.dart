import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:online_store_fl_app/models/produc_model.dart';

class EShopServices {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

    final String baseUrl = 'https://fakestoreapi.com';
  Future<List<String>> fetchCategories() async {

    
      final response =
          await http.get(Uri.parse('$baseUrl/products/categories'));
      if (response.statusCode == 200) {
        List<dynamic> categoriesJson = jsonDecode(response.body);
        List<String> categories =
            categoriesJson.map((category) => category.toString()).toList();
            
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    
  }
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<ProductModel> products = jsonList.map((json) => ProductModel.fromJson(json)).toList();
     
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  
  
}
