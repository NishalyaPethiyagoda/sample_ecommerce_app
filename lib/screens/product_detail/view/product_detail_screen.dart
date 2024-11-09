import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/network/http_methods.dart';
import 'package:sample_ecommerce_app/widgets/bottom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final HttpMethods _httpMethods = HttpMethods();


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    final response = _httpMethods.commonApiGet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8C1A5),
        centerTitle: true,
        title: Text(
          "Product Details", 
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        // actions: [
        //   IconButton(
        //   onPressed: (){
        //     // expandSearch = true;
        //   }, 
        //   icon: Icon(Icons.search)
        // ),]
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenHeight * 0.45,
                  color: const Color(0xFFF8C1A5),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFFFF3EC),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5,
              left: 25,
              right: 25,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(16.0), 
                ),
                height: screenHeight * 0.5,
                child: Column(
                  children: [
                    Text("data"),
                    Expanded(
                      child: Text("hi")
                    ),
                    Text("Price - \$ 15.00"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5 + screenHeight * 0.5 + 20,
              left: 25,
              right: 25,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white, 
                  borderRadius: BorderRadius.circular(16.0), 
                ),
                height: screenHeight * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    Expanded(
                      child: Text("hi \n sdsf\nsdfsf \n sds", overflow: TextOverflow.ellipsis, maxLines: 4,)
                    ),
                    Text("Price - \$ 15.00"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5 + screenHeight * 0.5 +  screenHeight * 0.2 + 35,
              left: 25,
              right: 25,
              child: AnimatedGradientButton(buttonText: "Add to Cart",)
            ),
          ],
        ),
      ),
    );

  }
}