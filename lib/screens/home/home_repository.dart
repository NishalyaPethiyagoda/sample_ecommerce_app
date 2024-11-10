

import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:sample_ecommerce_app/network/http_methods.dart';

class HomeRepository {
  HttpMethods httpMethods = HttpMethods();

  HomeRepository();

  // ProductModel products
  Future<ProductModel> getPoducts() async {
    try{
      final response = await httpMethods.commonApiGet();
      ProductModel productModel = ProductModel.fromJson(response);
      return productModel;
    }catch(e){
      rethrow;
    }
  }
}