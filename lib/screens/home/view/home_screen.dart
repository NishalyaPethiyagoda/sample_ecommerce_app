import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:sample_ecommerce_app/providers/product_provider.dart';
import 'package:sample_ecommerce_app/screens/home/bloc/home_bloc.dart';
import 'package:sample_ecommerce_app/screens/home/bloc/home_event.dart';
import 'package:sample_ecommerce_app/screens/home/bloc/home_state.dart';
import 'package:sample_ecommerce_app/screens/home/home_repository.dart';
import 'package:sample_ecommerce_app/widgets/product_dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final productsList = Provider.of<ProductProvider>(context).allProductsList;

    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          HomeBloc(HomeRepository())..add(HomeGetProductsEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            isLoading = true;
          } else if (state is HomeProductsLoadedState) {
            products = state.products;
            Provider.of<ProductProvider>(context, listen: false).setProductItems(products);
            isLoading = false;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  Color.fromARGB(255, 251, 169, 128),
            centerTitle: false,
            title: Text(
              "Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.85)),
            ),
            // actions: [
            //   IconButton(
            //   onPressed: (){
            //     // expandSearch = true;
            //   },
            //   icon: Icon(Icons.search)
            // ),]
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 251, 169, 128),
                        Color.fromARGB(255, 251, 222, 208), 
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(  
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: (productsList.length / 2).ceil(),
                            itemBuilder: (context, index) {
                              int firstIndex = index * 2;
                              int secondIndex = firstIndex + 1;
                  
                              ProductModel leftProduct = productsList[firstIndex];
                              ProductModel? rightProduct = secondIndex < productsList.length ? productsList[secondIndex] : null;
                              return Row(
                                children: [
                                  Expanded(
                                    child: ProductDashboardCard(
                                      product: leftProduct,
                                      
                                    ),
                                  ),
                                  rightProduct != null ? Expanded(
                                    child: ProductDashboardCard(
                                      product: rightProduct,
                                    ),
                                  ) : Container(),
                                ],
                              );
                            },
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
