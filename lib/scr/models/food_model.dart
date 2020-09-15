class Food{
  static const ID = "id";
  static const NAME = "name";
   String id;
   String name;
   String imagePath;
   String description;
   String category;
   double price;
   double discount;
   double ratings;
   String restaurant;
   String status;
  int quantity;
  String Orders;
  final List<Food> foodProducts;

  final String ItemId;
  final String order_number;
  final String order_status;
  final String payment_status;
  final String delivery_address;
  final String payment_method;

  Food({
    this.id,
    this.name,
    this.imagePath,
    this.description,
    this.category,
    this.status,
    this.price,
    this.discount,
    this.ratings,
    this.restaurant,
    this.quantity = 1,
    this.Orders,
    this.foodProducts,

    this.ItemId, this.order_number, this.order_status, this.payment_status, this.delivery_address, this.payment_method,
  });

  void incrementQuantity() {
    this.quantity = this.quantity +1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity -1;
  }

  Map toMap() => {
    ID: id,
    NAME: name,
  };
}

