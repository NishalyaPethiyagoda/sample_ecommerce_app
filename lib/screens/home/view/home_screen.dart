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
  bool expandSearch = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChange);
  }

  void _onSearchChange(){
    Provider.of<ProductProvider>(context, listen: false).filterProducts(searchController.text);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
        child: GestureDetector(
          onTap: (){
            setState(() {
              FocusScope.of(context).unfocus();
              expandSearch = !expandSearch;
            });
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:  const Color.fromARGB(255, 251, 169, 128),
              centerTitle: false,
              title: Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.85)),
              ),
              actions: [
                expandSearch 
                  ? Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,12.0, 0.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                          autofocus: false,
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.85),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                              borderSide: BorderSide.none, // Optional: to remove border color
                            ),
                          ),
                        ),
                    ),
                  )
                  : IconButton(
                      onPressed: (){
                        setState(() {
                          expandSearch = !expandSearch;
                        });
                      },
                      icon: const Icon(Icons.search)
                    ) 
              ]
            ),
            body: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
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
                          ? const Center(child: CircularProgressIndicator(color: Colors.grey,))
                          : ListView.builder(
                              itemCount: (productProvider.filteredProducts.length / 2).ceil(),
                              itemBuilder: (context, index) {
                                int firstIndex = index * 2;
                                int secondIndex = firstIndex + 1;
                    
                                ProductModel leftProduct = productProvider.filteredProducts[firstIndex];
                                ProductModel? rightProduct = secondIndex < productProvider.filteredProducts.length ? productProvider.filteredProducts[secondIndex] : null;
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
      ),
    );
  }
}
