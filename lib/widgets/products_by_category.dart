// ignore_for_file: prefer_final_fields, unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/models/product.dart';
import 'package:mystore/widgets/product_card.dart';

class ProductByCategory extends StatelessWidget {
  ProductByCategory({super.key});

  final String categoryName = Get.arguments[0];
  List<dynamic> _productsforcategory = Get.arguments[1];

  late List _categorized = _productsforcategory.where((element) {
    return (element as Product).category == categoryName;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          categoryName.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: GridView.builder(
              itemCount: _categorized.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width / 600,
              ),
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/description',
                        arguments: [_categorized[index]]);
                  },
                  child: ProductCard(
                    imageUrl: _categorized[index].image,
                    title: _categorized[index].title,
                    price: _categorized[index].price,
                  ),
                );
              }),
            )),
      ),
    );
  }
}
