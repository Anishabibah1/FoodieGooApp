import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  static const _boxName = 'auth';

  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox(_boxName);
    await box.put('user', user.toJson());
  }

  Future<UserModel?> getUser() async {
    final box = await Hive.openBox(_boxName);
    final data = box.get('user');
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> clearUser() async {
    final box = await Hive.openBox(_boxName);
    await box.delete('user');
  }
}