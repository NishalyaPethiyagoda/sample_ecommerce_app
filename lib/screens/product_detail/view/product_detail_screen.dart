import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/providers/product_provider.dart';
import 'package:sample_ecommerce_app/widgets/bottom_button.dart';
import 'package:sample_ecommerce_app/widgets/text_gradient_container.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  final bool isProductAddedToCart;
  const ProductDetailScreen({super.key, required this.product, required this.isProductAddedToCart});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isNotExpanded = true; 

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 251, 169, 128),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.white, // Set the back button color to white
            ),
            title: Text(
              widget.product.name, 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.85)),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: screenHeight * 0.48,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 251, 169, 128),
                            Color(0xFFF8C1A5), 
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
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
                    height: screenHeight * 0.51,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack(
                        children: [
                          Center(child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 20.0),
                            child: Hero(
                              tag: widget.product.productId,
                              child: Image.network(widget.product.imageUrl),
                            ),
                          )),
                          Positioned(
                            left: 5,
                            bottom: 5,
                            child: TextGradientContainer(
                              text: "\$ ${widget.product.price.toString()}",
                              textSize: 16,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: widget.product.rating.rating != null 
                              ? Row(
                                  children: List.generate(
                                    5,
                                    (star) => Icon(
                                      Icons.star,
                                      color: star < widget.product.rating.rating!.toInt() ? Colors.orange : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                )
                              : Container(),
                          )
                        ],
                      ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            Text("Count - ${widget.product.rating.count}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Expanded(
                          child: widget.isProductAddedToCart 
                            ? SingleChildScrollView(
                                child: Text(
                                  widget.product.description, 
                                  overflow: null, 
                                  maxLines: null,
                              ))
                            : Stack(
                              children: [
                                SingleChildScrollView(
                                child: GestureDetector(
                                  onTap: (){
                                    setState((){
                                      isNotExpanded = !isNotExpanded;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: const Color.fromARGB(255, 103, 103, 103), width: 1),
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(6.0,6.0,6.0, 0.0),
                                          child: Text(
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),
                                            widget.product.description, 
                                            overflow: isNotExpanded ? TextOverflow.ellipsis : null, 
                                            maxLines: isNotExpanded ? 4 : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4,),
                                      isNotExpanded 
                                        ? const Text("Tap on Description for more", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))
                                        : Container()
                                    ],
                                  )
                                  )),
                                  
                              ] 
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if(!widget.isProductAddedToCart)
          Positioned(
            bottom: 2,
            left: 25,
            right: 25,
              child: AnimatedGradientButton(
                buttonText: "Add to Cart",
                onPressed: (){
                  Provider.of<CartProvider>(context, listen: false).addItemToCart(widget.product);
                  Provider.of<ProductProvider>(context, listen: false).removeProduct(widget.product);
                  Future.microtask(() => Navigator.pop(context));
                },
              ),
            )
      ]
    );

  }
}