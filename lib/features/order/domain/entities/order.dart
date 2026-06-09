class OrderEntity {
  final String id;
  final String restoName;
  final String restoImageUrl;
  final List<String> items;
  final int total;
  final String status;
  final String date;

  const OrderEntity({
    required this.id,
    required this.restoName,
    required this.restoImageUrl,
    required this.items,
    required this.total,
    required this.status,
    required this.date,
  });
}