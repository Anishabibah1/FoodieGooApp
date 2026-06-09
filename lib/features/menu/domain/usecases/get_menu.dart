import '../entities/menu_item.dart';
import '../repositories/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repository;
  GetMenuUseCase(this.repository);

  Future<List<MenuItemEntity>> call(String keyword) async {
    return await repository.getMenuByKeyword(keyword);
  }
}