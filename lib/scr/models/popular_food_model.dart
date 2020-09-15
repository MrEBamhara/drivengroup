class GetPopFood{
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final String category;
  final double price;
  final double discount;
  final double ratings;
  final String restaurant;
  final String status;
  int quantity;

  GetPopFood({
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
    this.quantity = 1
  });
  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}

