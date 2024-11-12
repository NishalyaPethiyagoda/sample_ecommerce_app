

import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier{
  final List<ProductModel> allProductsList = [];
  List<ProductModel> filteredProducts = [];

  ProductProvider(){
    filteredProducts = allProductsList;
  }

  void filterProducts(String searchQuery) {
    if (searchQuery.isEmpty) {
      filteredProducts = allProductsList; 
    } else {
      filteredProducts = allProductsList
          .where((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList(); 
    }
    notifyListeners(); 
  }

  void setProductItems(List<ProductModel> allProducts){
    allProductsList.clear();
    allProductsList.addAll(allProducts);
    notifyListeners();
  }

  void addProduct(ProductModel product){
    allProductsList.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product){
    allProductsList.remove(product);
    notifyListeners();
  }
}