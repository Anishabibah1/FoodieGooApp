import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
  @override
  List<Object> get props => [name, email, phone, password];
}

class LogoutEvent extends AuthEvent {}

// STATES
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;
  AuthSuccess(this.email);
  @override
  List<Object> get props => [email];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLoggedOut extends AuthState {}

// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(AuthFailure('Email dan password tidak boleh kosong'));
      } else if (event.password.length < 6) {
        emit(AuthFailure('Password minimal 6 karakter'));
      } else {
        emit(AuthSuccess(event.email));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.name.isEmpty || event.email.isEmpty || event.password.isEmpty) {
        emit(AuthFailure('Semua field harus diisi'));
      } else if (event.password.length < 6) {
        emit(AuthFailure('Password minimal 6 karakter'));
      } else {
        emit(AuthSuccess(event.email));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(AuthLoggedOut());
    });
  }
}