import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_order/models/Orders.dart';

part 'sales_order_event.dart';
part 'sales_order_state.dart';

class SalesOrderBloc extends Bloc<SalesOrderEvent, SalesOrderState> {
  SalesOrderBloc() : super(SalesOrderInitial());

  @override
  Stream<SalesOrderState> mapEventToState(SalesOrderEvent event) async* {
    if (event is SalesOrderEvent) {
      yield* _salesOrderEvent(event);
    }
  }

  Stream<SalesOrderState> _salesOrderEvent(SalesOrderEvent event) async* {

    try{
      final response = await http.get("http://www.arpicoedi.com:8090/test/interview/test.php");

      if (response.statusCode == 200) {
        yield OrderSuccess(Orders.fromJson(jsonDecode(response.body)));
      }

    } catch(e){
      String errorObject = e.toString().split(':')[1];
      yield OrderFailedException(errorObject);
    }
  }
}
