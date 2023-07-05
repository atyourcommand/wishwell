class Doc {
  final String client;
  final String address;
  final String type;
  final String name;
  final String description;
  final bool enabled;
  final List<LineItem> items;
  Doc({
    required this.client,
    required this.address,
    required this.items,
    required this.type,
    required this.name,
    required this.description,
    required this.enabled,
  });
  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }
}

class LineItem {
  final String description;
  final double cost;

  LineItem(this.description, this.cost);
}
