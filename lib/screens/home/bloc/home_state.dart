

import 'package:sample_ecommerce_app/models/product_model.dart';

sealed class HomeState {}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeProductsLoadedState extends HomeState{
  final ProductModel products;
  HomeProductsLoadedState(this.products);
  // <Object> get props => [];
}