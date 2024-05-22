import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:thingslinker_test/controller/bloc/ProductGet/product_get_bloc.dart';

import 'package:thingslinker_test/view/pages/homepage/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
       BlocProvider<ProductGetBloc>(create: (context) => ProductGetBloc(),),
   




    ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(theme: ThemeData(
            scaffoldBackgroundColor: Colors.white
          ),
            home:ProductScreen() ,
          );
        },
      ),
    );
  }
}