import '../models/order_model.dart';

class OrderDataSource {
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      OrderModel(
        id: '#FG-001',
        restoName: 'Warung Nasi Padang',
        restoImageUrl: 'https://www.themealdb.com/images/media/meals/sytuqu1511786590.jpg',
        items: ['Nasi Goreng Spesial', 'Es Teh Manis'],
        total: 33000,
        status: 'Selesai',
        date: '04 Jun 2026',
      ),
      OrderModel(
        id: '#FG-002',
        restoName: 'Burger Kuy!',
        restoImageUrl: 'https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg',
        items: ['Burger Spesial', 'Kentang Goreng'],
        total: 45000,
        status: 'Selesai',
        date: '03 Jun 2026',
      ),
      OrderModel(
        id: '#FG-003',
        restoName: 'Pizza Hut Express',
        restoImageUrl: 'https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg',
        items: ['Pizza Margherita'],
        total: 75000,
        status: 'Dibatalkan',
        date: '01 Jun 2026',
      ),
    ];
  }
}