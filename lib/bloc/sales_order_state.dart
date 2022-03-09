part of 'sales_order_bloc.dart';

@immutable
abstract class SalesOrderState {}

class SalesOrderInitial extends SalesOrderState {}

class OrderSuccess extends SalesOrderState{
  OrderSuccess(this.orders);
  final Orders orders;
}

class OrderFailedException extends SalesOrderState{
  OrderFailedException(this.errorObject);
  final String errorObject;
}
