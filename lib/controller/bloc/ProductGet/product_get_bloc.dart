import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thingslinker_test/models/productModel.dart';

import 'product_get_event.dart';
import 'product_get_state.dart';


final List<String> listing = [
  'smartphones',
  'laptops',
  'fragrances',
  'skincare',
  'groceries',
  'home-decoration'
];

class ProductGetBloc extends Bloc<ProductGetEvent, ProductGetState> {
  ProductGetBloc() : super(ProductLoading()) {
    on<ProductFetch>(_onProductFetch);
    
    on<ProductCategorySelect>(_onProductCategorySelect);
    on<ProductSort>(_onProductSort);
  }

  Future<void> _onProductFetch(
      ProductFetch event, Emitter<ProductGetState> emit) async {
    emit(ProductLoading());

    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/products"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final homeData = AllProduct.fromJson(responseData);

        final filteredProducts = homeData.products!
            .where((product) => product.category == listing[event.indexValue])
            .toList();

        emit(ProductLoaded(
          allProduct: homeData,
          filteredProducts: filteredProducts,
          indexValue: event.indexValue,
          selectedSortOption: "Price: High to Low", // Default sort option
        ));
      }
    } catch (e) {
      emit(ProductError());
    }
  }

  void _onProductCategorySelect(
      ProductCategorySelect event, Emitter<ProductGetState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final filteredProducts = currentState.allProduct.products!
          .where((product) => product.category == listing[event.indexValue])
          .toList();

      emit(ProductLoaded(
        allProduct: currentState.allProduct,
        filteredProducts: filteredProducts,
        indexValue: event.indexValue,
        selectedSortOption: currentState.selectedSortOption,
      ));
    }
  }

  void _onProductSort(ProductSort event, Emitter<ProductGetState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> sortedProducts = List.from(currentState.filteredProducts);

      switch (event.sortOption) {
        case "Price: High to Low":
          sortedProducts.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
          break;
        case "Price: Low to High":
          sortedProducts.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
          break;
        case "Name descending":
          sortedProducts.sort((a, b) => (b.title ?? "").compareTo(a.title ?? ""));
          break;
        case "Name ascending":
          sortedProducts.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
          break;
      }

      emit(ProductLoaded(
        allProduct: currentState.allProduct,
        filteredProducts: sortedProducts,
        indexValue: currentState.indexValue,
        selectedSortOption: event.sortOption,
      ));
    }
  }
}
