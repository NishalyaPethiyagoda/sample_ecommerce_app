import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Stack(
          children: [ 
            Container(
             color: Colors.amber,
             height: screenHeight * 0.6,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Text("hii"),
              ),
             
            ),

          ],
        )
        ),
    );
  }
}