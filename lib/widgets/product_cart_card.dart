import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/cart_item_model.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/providers/product_provider.dart';
import 'package:sample_ecommerce_app/widgets/quantity_set_buttons.dart';

class ProductCartCard extends StatefulWidget {
  final CartItemModel cartItem;
  const ProductCartCard({super.key, required this.cartItem});

  @override
  State<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {
  @override
  Widget build(BuildContext context) {

    final product = widget.cartItem.product;

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8.0, 4, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(product.imageUrl, width: 60, height: 70),
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
              QuantitySetButtons(cartItem: widget.cartItem),
              IconButton(
                  onPressed: (){
                    Provider.of<CartProvider>(context, listen: false).removeItemFromCart(widget.cartItem);
                    Provider.of<ProductProvider>(context, listen: false).addProduct(product);
                  }, 
                  icon: const Icon(Icons.close)
                )
            ],
          ),
        )
      ),
    );
  }
}