

import 'package:sample_ecommerce_app/models/rating_model.dart';
  
class ProductModel {
  final int productId;
  final String name;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final RatingModel rating;

  ProductModel({required this.productId, required this.name, required this.price, required this.description, required this.category, required this.imageUrl, required this.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      productId: json["id"] ?? 0, 
      name: json["title"] ?? '', 
      price: json["price"] != null 
          ? ((json["price"] is int) ? (json["price"] as int).toDouble() : json["price"]) 
          : 0.00, 
      description: json["description"] ?? '',
      category: json["category"] ?? '', 
      imageUrl: json["image"] ?? '',    // add a default product URL to show improper loaded image
      rating: RatingModel.fromJson(json["rating"]),
    );
  }
}