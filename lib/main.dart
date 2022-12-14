// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/screens/Categories.dart';
import 'package:mystore/screens/Dashboard.dart';
import 'package:mystore/widgets/description.dart';
import 'package:mystore/widgets/products_by_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/dashboard',
          page: () => Dashboard(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/category',
          page: () => Categories(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/description',
          page: () => ProductDescription(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/products_by_category',
          page: () => ProductByCategory(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 200),
        )
      ],
      theme: ThemeData(),
      home: Dashboard(),
    );
  }
}
