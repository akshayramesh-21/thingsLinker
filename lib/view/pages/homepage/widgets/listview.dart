import 'package:flutter/material.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_state.dart';

SliverList silverListMethod(
    ProductLoaded state, double screenWidth, double screenHeight) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        final product = state.filteredProducts[index];
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.18,
                  height: screenHeight * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: NetworkImage(
                          product.thumbnail!,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          product.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "font1",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        product.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "font1",
                          fontSize: 11,
                          color: Colors.blueGrey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          '\$${product.price!.toString()}',
                          style: TextStyle(
                            fontFamily: "font1",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      childCount: state.filteredProducts.length,
    ),
  );
}
