import 'package:flutter/material.dart';
import 'package:sales_order/models/Orders.dart';
import 'package:sales_order/shared/Repository.dart';


class Selection extends StatefulWidget {
  const Selection({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {

  Repository _repository = new Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index){
          return
            (widget.title=="Customer") ? GestureDetector(
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.blueGrey,
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Customer Code : "+ customers[index].cUSCOD, style: TextStyle(fontSize: 15),),
                    Text("Customer Name : "+ customers[index].cUSNAM, style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              onTap: (){
                _repository.addValue("customerCode", customers[index].cUSCOD.toString());
                _repository.addValue("customerName", customers[index].cUSNAM.toString());


                print("saved cusCode & cusName");
                Navigator.pop(context);
              },
            ) :
            (widget.title=="Items") ? GestureDetector(
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.blueGrey,
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Item Code : "+ items[index].iTMCOD, style: TextStyle(fontSize: 15),),
                    Text("Item Description : "+ items[index].iTMNAM, style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              onTap: (){
                _repository.addValue("itemCode", items[index].iTMCOD.toString());
                _repository.addValue("itemDescription", items[index].iTMNAM.toString());

                Navigator.pop(context);

                for(int i = 0; i<selectedOrder.length; i++) {
                  print(selectedOrder[i]);
                }
              },
            ) : Placeholder(color: Colors.transparent,);

        }
      ),
    );
  }
}
