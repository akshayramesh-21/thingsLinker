import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_bloc.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_event.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_state.dart';

PopupMenuButton<String> popUpmenu(
    double screenWidth, ProductLoaded state, BuildContext context) {
  final List<String> sortOut = [
    "Price: High to Low",
    "Price: Low to High",
    "Name descending",
    "Name ascending"
  ];

  return PopupMenuButton<String>(
    color: Colors.white,
    icon: Image.asset("images/filter-horizontal.png"),
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem<String>(
          enabled: false,
          child: Container(
            width: screenWidth * 0.95,
            child: Column(
              children: [
                Text(
                  'Sort by',
                  style: TextStyle(
                    fontFamily: "font1",
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
        ...sortOut.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, option);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    option,
                    style: TextStyle(
                      color: state.selectedSortOption == option
                          ? const Color.fromARGB(255, 15, 15, 15)
                          : Color.fromARGB(255, 109, 106, 106),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    state.selectedSortOption == option
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: state.selectedSortOption == option
                        ? Colors.black
                        : Colors.white,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ];
    },
    onSelected: (String? value) {
      if (value != null) {
        BlocProvider.of<ProductGetBloc>(context)
            .add(ProductSort(sortOption: value));
      }
    },
  );
}
