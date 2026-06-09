import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;
  MenuRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MenuItemEntity>> getMenuByKeyword(String keyword) async {
    try {
      return await remoteDataSource.getMenuByKeyword(keyword);
    } catch (e) {
      throw Exception('Gagal memuat menu: $e');
    }
  }
}