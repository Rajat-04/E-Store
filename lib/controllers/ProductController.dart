// ignore_for_file: unused_local_variable, avoid_print, file_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:mystore/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var isLoading = false.obs;
  List<dynamic>? products;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse("https://fakestoreapi.com/products")!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        products = result.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      print("Fetching Unsuccessful, error is $e");
    } finally {
      isLoading(false);
    }
  }
}
