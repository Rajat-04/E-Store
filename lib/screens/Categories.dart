// ignore_for_file: prefer_final_fields, unused_field, must_be_immutable, file_names, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/controllers/CategoryController.dart';
import 'package:mystore/widgets/category_card.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  CategoryController _categoryController = Get.put(CategoryController());
  List<dynamic> _productsList = Get.arguments[0];
  List<String> imagesList = [
    'assets/images/electronics.jpg',
    'assets/images/jewellery.jpg',
    'assets/images/men.jpg',
    'assets/images/women.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Category",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
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
            child: Obx(
              (() => _categoryController.isLoading.value
                  ? GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 460,
                      ),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Shimmer.fromColors(
                              highlightColor: Colors.white,
                              baseColor: Colors.grey[300],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 243, 243, 243),
                                      width: 1),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 243, 243, 243),
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }),
                    )
                  : GridView.builder(
                      itemCount: _categoryController.categories?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 460,
                      ),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/products_by_category', arguments: [
                              _categoryController.categories?[index].toString(),
                              _productsList
                            ]);
                          },
                          child: CategoryCard(
                            imageUrl: imagesList[index],
                            title: _categoryController.categories?[index]
                                .toString(),
                          ),
                        );
                      }),
                    )),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    "Abhishek Mishra",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text("abhishekm977@gmail.com"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Center(
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.storefront_rounded),
                title: const Text(' All Products '),
                onTap: () {
                  Get.toNamed('/dashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.category_rounded),
                title: const Text(' Categories '),
                onTap: () {
                  Get.toNamed('/category');
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text(' My Orders '),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
