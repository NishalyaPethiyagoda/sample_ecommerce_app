import 'package:sample_ecommerce_app/models/product_model.dart';

double getTotalPrice (List<ProductModel> cartItems){
  double totalPrice = 0.0;

  for(var item in cartItems){
    totalPrice += item.price;
  }
  return totalPrice;
}