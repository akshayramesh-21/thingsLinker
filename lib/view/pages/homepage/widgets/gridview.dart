 import 'package:flutter/material.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_state.dart';

SliverGrid silverDridMethod(ProductLoaded state, double screenWidth, double screenHeight) {
    return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product =
                                  state.filteredProducts[index];
                              return Card(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 6.0),
                                      child: Center(
                                        child: Container(
                                          width: screenWidth * 0.4,
                                          height: screenHeight * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  product.thumbnail!,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        product.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: "font1",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        product.description!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: "font1",
                                          fontSize: 11,
                                          color:
                                              Colors.blueGrey.shade300,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8.0),
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
                              );
                            },
                            childCount: state.filteredProducts.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 2 / 3,
                          ),
                        );
  }