import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/screens/product_detail/view/product_detail_screen.dart';

class ProductDashboardCard extends StatelessWidget {
  final ProductModel product;
  const ProductDashboardCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => ProductDetailScreen(
              product: product,
              isProductAddedToCart: Provider.of<CartProvider>(context).cartItems.contains(product)
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child); 
            },
          ),
        );
      
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8.0, 4, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: product.productId,
                child: Image.network(product.imageUrl, width: 60, height: 70),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, overflow: TextOverflow.ellipsis, maxLines: 2,),
                    Text('\$ ${product.price.toString()}'),
                    product.rating.rating != null ? Row(
                    children: List.generate(
                      5,
                      (star) => Icon(
                        Icons.star,
                        color: star < product.rating.rating!.toInt() ? Colors.orange : Colors.grey,
                        size: 12,
                      ),
                    ),
                  ): Container(),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}