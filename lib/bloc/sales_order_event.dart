part of 'sales_order_bloc.dart';

@immutable
abstract class SalesOrderEvent {}

class SalesOrder extends SalesOrderEvent{
  // SalesOrder({this.authentication});
  // final String authentication;
  SalesOrder();
}
