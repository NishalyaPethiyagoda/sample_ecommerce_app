
import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:sample_ecommerce_app/network/http_methods.dart';

class HomeRepository {
  HttpMethods httpMethods = HttpMethods();

  HomeRepository();

  // ProductModel products
  Future<List<ProductModel>> getPoducts() async {
    try{
      final response = await httpMethods.commonApiGet("products");
      List<ProductModel> allProductslist = (response as List<dynamic>).map( (json) => ProductModel.fromJson(json)).toList();
      return allProductslist;
    }catch(e){
      rethrow;
    }
  }
}