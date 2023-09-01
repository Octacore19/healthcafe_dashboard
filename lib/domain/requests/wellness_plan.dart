class WellnessPlanRequest {
  const WellnessPlanRequest({
    this.name,
    this.price,
    this.description,
  });

  final String? name;
  final String? price;
  final String? description;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
