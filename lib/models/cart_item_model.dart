
import 'package:sample_ecommerce_app/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, required this.quantity});

  void incrementQuantity(){
    quantity++;
  }

  void decrementQuantity(){
    quantity--;
  }
}