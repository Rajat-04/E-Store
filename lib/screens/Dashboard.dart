// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/controllers/ProductController.dart';
import 'package:mystore/widgets/cart_item.dart';
import 'package:mystore/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatelessWidget {
  ProductController _productController = Get.put(ProductController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Store",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                //Get.snackbar("Shopping Cart", "This is your shopping cart");
                Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Shopping Cart",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 348,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: GridView.builder(
                                itemCount: 10,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width / 120,
                                ),
                                itemBuilder: ((context, index) {
                                  return CartItem(
                                    image: _productController
                                        .products?[index].image,
                                    name: _productController
                                        .products?[index].title,
                                    price: _productController
                                        .products?[index].price,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
              () => _productController.isLoading.value
                  ? GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 600,
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
                      itemCount: _productController.products?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 600,
                      ),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/description', arguments: [
                              _productController.products?[index]
                            ]);
                          },
                          child: ProductCard(
                            imageUrl: _productController.products?[index].image,
                            title: _productController.products?[index].title,
                            price: _productController.products?[index].price,
                          ),
                        );
                      }),
                    ),
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
                  Get.toNamed('/category',
                      arguments: [_productController.products]);
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
