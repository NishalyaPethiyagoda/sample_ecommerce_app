

import 'package:flutter/material.dart';

class ProductDashboardCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final double? rating;
  const ProductDashboardCard({super.key, required this.productName, required this.productImage, required this.productPrice, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(productImage, width: 50, height: 50),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName, overflow: TextOverflow.ellipsis,),
                  Text(productPrice.toString()),
                  rating != null ? Row(
                  children: List.generate(
                    5,
                    (star) => Icon(
                      Icons.star,
                      color: star < rating!.toInt() ? Colors.orange : Colors.grey,
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
    );
  }
}