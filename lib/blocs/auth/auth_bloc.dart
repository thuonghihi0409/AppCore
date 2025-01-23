
import 'package:appcore/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (event.email == '12345' && event.password == '12345') {
         User _user = User(
        id: "001",
        name: "Tharo",
        email: "tharo@gmail.com",
        password: "12345",
        avatarUrl: " ",);
        emit(AuthAuthenticated(user:_user )) ;
        
      } else {
        emit(AuthError(message: 'Sai email hoặc mật khẩu'));
      }
    } catch (e) {
      emit(AuthError(message: 'Đã xảy ra lỗi: ${e.toString()}'));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }

  void _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) {
    final isLoggedIn = false;
    if (isLoggedIn) {
     // emit(AuthAuthenticated(userId: '123'));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
