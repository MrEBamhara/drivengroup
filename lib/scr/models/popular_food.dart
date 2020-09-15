class PopularFood{
  final String id;
  final String name;
  final String restaurant;
  final String image;
  final String category;
  final double price;
  final double rating;

  PopularFood({this.id, this.name, this.image, this.category, this.price, this.rating, this.restaurant});
}
final food = [
  PopularFood(
    id: "1",
    name: "Rice",
    image: "images/7.jpg",
    category: "1",
    price: 14.25,
    rating: 4.5,
    restaurant: "The Teahouse",
   ),

  PopularFood(
    id: "1",
    name: "Cake",
    image: "images/1.jpg",
    category: "1",
    price: 12.00,
    rating: 4.5,
    restaurant: "The Teahouse",
  ),

  PopularFood(
    id: "1",
    name: "Burger",
    image: "images/10.jpg",
    category: "1",
    price: 8.00,
    rating: 4.5,
    restaurant: "The Teahouse",
  ),
];
