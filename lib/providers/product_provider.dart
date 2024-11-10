

import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier{
  final List<ProductModel> allProductsList = [];

  void setProductItems(List<ProductModel> allProducts){
    allProductsList.clear();
    allProductsList.addAll(allProducts);
    notifyListeners();
  }

  void removeProduct(ProductModel product){
    allProductsList.remove(product);
    notifyListeners();
  }
}