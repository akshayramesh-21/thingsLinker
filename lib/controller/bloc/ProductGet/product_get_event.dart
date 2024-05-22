abstract class ProductGetEvent {}

class ProductFetch extends ProductGetEvent {
  final int indexValue;
  ProductFetch({required this.indexValue});
}

class ProductSort extends ProductGetEvent {
  final String sortOption;
  ProductSort({required this.sortOption});
}

class ProductCategorySelect extends ProductGetEvent {
  final int indexValue;
  ProductCategorySelect({required this.indexValue});
}
