
List<Customers> customers = new List<Customers>();
List<Items> items = new List<Items>();

List<Order> selectedOrder = new List<Order>();

class Orders {
  List<Customers> customers;
  List<Items> items;

  Orders({this.customers, this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers.add(new Customers.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  String cUSCOD;
  String cUSNAM;

  Customers({this.cUSCOD, this.cUSNAM});

  Customers.fromJson(Map<String, dynamic> json) {
    cUSCOD = json['CUSCOD'];
    cUSNAM = json['CUSNAM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUSCOD'] = this.cUSCOD;
    data['CUSNAM'] = this.cUSNAM;
    return data;
  }
}

class Items {
  String iTMCOD;
  String iTMNAM;

  Items({this.iTMCOD, this.iTMNAM});

  Items.fromJson(Map<String, dynamic> json) {
    iTMCOD = json['ITMCOD'];
    iTMNAM = json['ITMNAM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITMCOD'] = this.iTMCOD;
    data['ITMNAM'] = this.iTMNAM;
    return data;
  }
}

class Order {

  final int orderNumber;
  final String transactionDate;
  final String customerCode;
  final String customerName;
  final int totalItemCount;
  final String totalGrossAmount;
  final String totalDiscountAmount;
  final String totalNetAmount;

  Order({
    this.orderNumber,
    this.transactionDate,
    this.customerCode,
    this.customerName,
    this.totalGrossAmount,
    this.totalItemCount,
    this.totalDiscountAmount,
    this.totalNetAmount
  });

  Map<String, dynamic> toMap() {
    return {
      'orderNumber': orderNumber,
      'transactionDate': transactionDate,
      'customerCode': customerCode,
      'customerName': customerName,
      'totalItemCount': totalItemCount,
      'totalGrossAmount': totalGrossAmount,
      'totalDiscountAmount': totalDiscountAmount,
      'totalNetAmount': totalNetAmount
    };
  }

}