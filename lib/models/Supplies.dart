class Supplies{
  String id;
  String name;
  String description;
  double price;
  String imageUrl;
  int quant;

  Supplies(
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.quant
  );

  Supplies.fromJson(Map<String, dynamic> json) : 
  id = json['id'],
  name = json['name'],
  description = json['description'],
  price = json['price'],
  imageUrl = json['imageUrl'],
  quant = json['quant'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'price' : price,
    'description' : description,
    'imageUrl' : imageUrl,
    'quant' : quant,
  };

  static List<Supplies> listFromJson(Map<String, dynamic> json) {
    List<Supplies>  supplies = [];
    json.forEach((key, value) {
        Map<String, dynamic> item = {"id": key, ...value};
        supplies.add(Supplies.fromJson(item));
     });

     return supplies;
  }
}