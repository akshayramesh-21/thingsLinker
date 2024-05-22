import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_bloc.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_event.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_state.dart';
import 'package:thingslinker_test/models/productModel.dart';
import 'package:thingslinker_test/view/pages/homepage/widgets/gridview.dart';
import 'package:thingslinker_test/view/pages/homepage/widgets/listview.dart';
import 'package:thingslinker_test/view/pages/homepage/widgets/popupmenu.dart';

import '../search/searchPage.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FocusNode _focusNode = FocusNode();
  final List<String> category = [
    'Smart phone',
    'Laptop',
    'Fragrances',
    'Skincare',
    'Groceries',
    'Home decoration',
  ];

  final List<String> sortOptions = [
    "Price: High to Low",
    "Price: Low to High",
    "Name descending",
    "Name ascending"
  ];

  List<Product> allProducts = [];
  ValueNotifier<bool> isSelectedButton = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductGetBloc>(context).add(ProductFetch(indexValue: 0));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    isSelectedButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<ProductGetBloc, ProductGetState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
            allProducts = state.allProduct.products!;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Container(
                              width: screenWidth * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(46),
                              ),
                              child: TextField(
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'Search...',
                                  contentPadding: EdgeInsets.only(
                                      top: screenHeight * 0.015),
                                  hintStyle: TextStyle(fontFamily: "font1"),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Color(0xffCCCCCC),
                                  ),
                                  suffixIcon:
                                      Image.asset("images/search-visual.png"),
                                ),
                                onTap: () {
                                  _focusNode.unfocus();
                                  showSearch(
                                    context: context,
                                    delegate: CustomSearchDelegate(allProducts),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(46),
                            ),
                            child: popUpmenu(screenWidth, state, context),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.028),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "font1",
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            final isSelected = state.indexValue == index;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ProductGetBloc>(context).add(
                                      ProductCategorySelect(indexValue: index));
                                },
                                child: Chip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: BorderSide(
                                      width: 0,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  label: Text(category[index]),
                                  backgroundColor: isSelected
                                      ? Colors.black
                                      : Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    fontFamily: "font1",
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Products",
                                    style: TextStyle(
                                        fontFamily: "font1",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("${state.filteredProducts.length} Result",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                isSelectedButton.value =
                                    !isSelectedButton.value;
                                log(isSelectedButton.value.toString());
                              },
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isSelectedButton,
                                builder: (context, value, child) {
                                  return Container(
                                    width: screenWidth * 0.1,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Icon(
                                      value ? Icons.grid_view : Icons.menu,
                                      size: 16,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isSelectedButton,
                  builder: (context, isListView, child) {
                    return isListView
                        ? silverListMethod(state, screenWidth, screenHeight)
                        : silverDridMethod(state, screenWidth, screenHeight);
                  },
                ),
              ],
            );
          }

          return Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}
