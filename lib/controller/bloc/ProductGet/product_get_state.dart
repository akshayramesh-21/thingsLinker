import 'package:thingslinker_test/models/productModel.dart';

abstract class ProductGetState {}

class ProductLoading extends ProductGetState {}

class ProductLoaded extends ProductGetState {
  final AllProduct allProduct;
  final List<Product> filteredProducts;
  final int indexValue;
  final String selectedSortOption;

  ProductLoaded({
    required this.allProduct,
    required this.filteredProducts,
    required this.indexValue,
    required this.selectedSortOption,
  });
}

class ProductError extends ProductGetState {}
