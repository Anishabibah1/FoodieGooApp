import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email dan password tidak boleh kosong');
    }
    if (password.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }
    return UserModel(
      id: '1',
      name: 'Pengguna FoodieGoo',
      email: email,
      phone: '08123456789',
    );
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Semua field harus diisi');
    }
    if (password.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }
    return UserModel(
      id: '1',
      name: name,
      email: email,
      phone: phone,
    );
  }
}