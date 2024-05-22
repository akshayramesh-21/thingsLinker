import 'package:flutter/material.dart';
import 'package:thingslinker_test/models/productModel.dart'; 

class CustomSearchDelegate extends SearchDelegate<Product> {
  final List<Product> allProducts;

  CustomSearchDelegate(this.allProducts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (query.isEmpty || allProducts.isEmpty) {
          close(
              context,
              allProducts.isNotEmpty
                  ? allProducts.first
                  : Product());
        } else {
          close(context,
              Product()); 
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Product> results = allProducts
        .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(
            product.title.toString(),
            style: TextStyle(fontFamily: "font1"),
          ),
          subtitle: Text(
            product.category.toString(),
            style: TextStyle(fontFamily: "font1"),
          ),
          leading: Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.05,
              child: Image.network(product.images![0])),
          onTap: () {
            close(context, product);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestions = allProducts
        .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.title.toString()),
          subtitle: Text(product.category.toString()),
          leading: Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.05,
              child: Image.network(product.images![0])),
          onTap: () {
            query = product.title.toString();
            showResults(context);
          },
        );
      },
    );
  }
}
