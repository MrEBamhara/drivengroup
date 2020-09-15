class OrderFood{
  final String id;
  final String name;
  final String ItemId;
  final String description;
  final String order_number;
  final double price;
  final String order_status;
  final String payment_status;
  final String delivery_address;
  final String payment_method;
  final int quantity;
  final String Orders;
  final List<OrderFood> foodProducts;

  OrderFood({
    this.order_status,
    this.payment_status,
    this.payment_method,
    this.id,
    this.name,
    this.ItemId,
    this.description,
    this.order_number,
    this.quantity,
    this.delivery_address,
    this.price,
    this.Orders,
    this.foodProducts
  });

}

