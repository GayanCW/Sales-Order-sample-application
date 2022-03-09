import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_order/bloc/sales_order_bloc.dart';
import 'package:sales_order/src/Home.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<SalesOrderBloc>(create: (BuildContext context) => SalesOrderBloc())
      ],
      child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

