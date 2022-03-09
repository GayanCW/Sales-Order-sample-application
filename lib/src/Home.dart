
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_order/models/Orders.dart';
import 'package:sales_order/shared/SQLdb.dart';
import 'package:sales_order/src/Selection.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController date = TextEditingController();
  final myDB = SQLdb.instance;

  void insert(
      int orderNumber,
      String transactionDate,
      String customerCode,
      String customerName,
      int totalItemCount,
      String totalGrossAmount,
      String totalDiscountAmount,
      String totalNetAmount,
      ) async {

    Map<String, dynamic> row = {
      SQLdb.orderNumber : orderNumber,
      SQLdb.transactionDate  : transactionDate,
      SQLdb.customerCode: customerCode,
      SQLdb.customerName: customerName,
      SQLdb.totalItemCount: totalItemCount,
      SQLdb.totalGrossAmount: totalGrossAmount,
      SQLdb.totalDiscountAmount: totalDiscountAmount,
      SQLdb.totalNetAmount: totalNetAmount,

      // SQLdb.orderNumber : 1,
      // SQLdb.transactionDate  : '2022/03/09',
      // SQLdb.customerCode: customers[0].cUSCOD,
      // SQLdb.customerName: customers[0].cUSNAM,
      // SQLdb.totalItemCount: 2,
      // SQLdb.totalGrossAmount: '100.00',
      // SQLdb.totalDiscountAmount: '25.00',
      // SQLdb.totalNetAmount: '75.00',
    };
    final id = await myDB.insert(row);
    print('inserted row id: $id');
  }

  @override
  void initState() {
    super.initState();
    print("Home init");
    getDataFromURL();

  }

  Future<void> getDataFromURL() async{
    final response = await http.get("http://www.arpicoedi.com:8090/test/interview/test.php");
    if (response.statusCode == 200) {

        Orders _orders = Orders.fromJson(jsonDecode(response.body));
        for(int i=0; i<_orders.customers.length; i++){
          customers.add(_orders.customers[i]);
        }
        for(int i=0; i<_orders.items.length; i++){
          items.add(_orders.items[i]);
        }

    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TextField(
                decoration: InputDecoration(
                    hintText: "Date",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      date.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),

                ),
                controller: date,
              ),
              SizedBox(height: 20),


              FlatButton(
                color: Colors.green,
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Customer",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Selection(title: "Customer",)));
                },
              ),
              SizedBox(height: 20,),
              FlatButton(
                color: Colors.green,
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Items",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Selection(title: "Items",)));
                },
              ),
              SizedBox(height: 20,),

              FlatButton(
                color: Colors.green,
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onPressed: (){
                  insert(
                    0,
                    date.text,
                    customers[0].cUSCOD,
                    customers[0].cUSNAM,
                    2,
                    '100.00',
                    '25.00',
                    '75.00'
                  );

                  print('save success');
                },
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//
//   return BlocListener<SalesOrderBloc, SalesOrderState>(
//       listener: (context, state){
//         if(state is OrderSuccess){
//           print(state.orders.customers);
//
//           for(int i=0; i<state.orders.customers.length; i++){
//             customers.add(state.orders.customers[i]);
//           }
//           for(int i=0; i<state.orders.items.length; i++){
//             items.add(state.orders.items[i]);
//           }
//         }
//
//         if(state is OrderFailedException){
//
//         }
//       },
//
//       child: BlocBuilder<SalesOrderBloc, SalesOrderState>(
//         builder: (context, state) {
//           return buildHome(context);
//         },
//       )
//   );
// }
}
